#include <WiFi.h>
#include <time.h>
#include <ESP32Servo.h>
#include <MQTT.h>
//#include <MillisTimerLib.h>
#include <WiFiManager.h>
#include <SimpleTimer.h>

enum State {
  STATE_IDLE,
  STATE_OPENING,
  STATE_WAIT_FOR_CLOSE,
};


const char *mqtt_topic_cancela = "autopark/access";
const char *mqtt_topic_connected_device = "autopark/connectedDevice";

WiFiClient espClient;
MQTTClient client;
Servo myservo;
State currentState = STATE_IDLE;
unsigned long stateStartTime = 0;
String parkingId = "d14ba0a6-2636-43f6-adba-9d6683b065a1";
String serverId = "";

void setup() {
  Serial.begin(921600);
  // Create an instance of WiFiManager
  WiFiManager wifiManager;

  // Uncomment the following line for initial setup to clear stored WiFi credentials
  //wifiManager.resetSettings();

  // Set configuration parameters
  WiFiManagerParameter custom_mqtt_server("mqtt_server", "MQTT Server", "test.mosquitto.org", 40);
  WiFiManagerParameter custom_mqtt_port("mqtt_port", "MQTT Port", String(1883).c_str(), 6);
  WiFiManagerParameter custom_parking_id("parking_id", "Parking ID", parkingId.c_str(), 40);

  // Add parameters to WiFiManager
  wifiManager.addParameter(&custom_mqtt_server);
  wifiManager.addParameter(&custom_mqtt_port);
  wifiManager.addParameter(&custom_parking_id);

  String AccessPointSSID = String("TORRE") + getChipIdAsString();
  // Connect to Wi-Fi
  if (!wifiManager.autoConnect(AccessPointSSID.c_str(), "AutoPark123")) {
    Serial.println(F("Failed to connect. Resetting and trying again..."));
    delay(3000);
    ESP.restart();
    delay(5000);
  }

  // Get configuration values
  const char *mqttServer = custom_mqtt_server.getValue();
  serverId = String(mqttServer);
  const int mqttPort = atoi(custom_mqtt_port.getValue());  // Convert to int
  parkingId = custom_parking_id.getValue();

  myservo.attach(13);

  // Inicializa a conexão com o broker MQTT
  client.begin("test.mosquitto.org", 1883, espClient);
  client.onMessage(messageReceived);

  connectMQTT(serverId);
  client.subscribe(mqtt_topic_cancela);
  client.publish(mqtt_topic_connected_device, AccessPointSSID + " Conected.");
}


void loop() {
  client.loop();

  if (!client.connected()) {
    connectMQTT(serverId);
  }
  switch (currentState)
  {
    case STATE_OPENING:
      if (millis() - stateStartTime >= 10000)
      {
        currentState = STATE_WAIT_FOR_CLOSE;
        stateStartTime = millis();
        closeCancela();
      }
      break;

    case STATE_WAIT_FOR_CLOSE:
      if (millis() - stateStartTime >= 5000)
      {
        currentState = STATE_IDLE;
        Serial.println("Estado Idle");
      }
      break;
  }
 
}

String getChipIdAsString() {
  // Get ESP32 Chip ID
  uint64_t chipId = ESP.getEfuseMac();

  // Convert Chip ID to a string
  String chipIdString = String(chipId, HEX);

  return chipIdString;
}

void messageReceived(String &topic, String &payload) {
  Serial.println("incoming: " + topic + " - " + payload);
  
  String message = payload;
  Serial.println("Conteúdo da mensagem: " + message);

  String inputString = message;
  int dotIndex = inputString.indexOf(':');
  String incomingParkId = inputString.substring(0, dotIndex);
  Serial.println("Conteúdo da incomingParkId: " + incomingParkId);
  String action = inputString.substring(dotIndex + 1);
  Serial.println("Conteúdo da action: " + action);


  Serial.println("parkingId" + parkingId); 
  if (incomingParkId.equals(parkingId)) {
    Serial.println("incomingParkId.equals(parkingId)==true");
    if (action == "open" && currentState == STATE_IDLE) {
       Serial.println("action=open");
      currentState = STATE_OPENING;
      stateStartTime = millis();
      openCancela();
    }
  }

}


void publishMessage(const char *topic, const char *message) {
  client.publish(topic, message);
}

void connectMQTT(String mqtt_server) {
    Serial.print("MQTT");
    while (!client.connect("MYUNIC0002ID")) {
    Serial.print(".");
    delay(1000);
  }
}

void openCancela() {
  Serial.println("Cancela aberta");
  myservo.write(0);
}

void closeCancela() {
  Serial.println("Cancela fechada");
  myservo.write(180);
}
