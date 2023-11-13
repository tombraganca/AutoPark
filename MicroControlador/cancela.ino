#include <WiFi.h>
#include <time.h>
#include <ESP32Servo.h>
#include <PubSubClient.h>
#include <MillisTimerLib.h>
#include <WiFiManager.h>

enum State
{
  STATE_IDLE,
  STATE_OPENING,
  STATE_WAIT_FOR_CLOSE,
};

const char *mqttServer = "test.mosquitto.org";
const int mqttPort = 1883;
const char *mqtt_topic_cancela = "autopark/accessPort";
const char *mqtt_topic_connected_device = "autopark/connectedDevice";
MillisTimerLib timer;

WiFiClient espClient;
PubSubClient client(espClient);
Servo myservo;
State currentState = STATE_IDLE;
unsigned long stateStartTime = 0;

void setup()
{
  // Create an instance of WiFiManager
  WiFiManager wifiManager;

  // Uncomment the following line for initial setup to clear stored WiFi credentials
  // wifiManager.resetSettings();

  // Set configuration parameters
  WiFiManagerParameter custom_mqtt_server("mqtt_server", "MQTT Server", mqttServer, 40);
  WiFiManagerParameter custom_mqtt_port("mqtt_port", "MQTT Port", String(mqttPort).c_str(), 6);

  // Add parameters to WiFiManager
  wifiManager.addParameter(&custom_mqtt_server);
  wifiManager.addParameter(&custom_mqtt_port);

  // Connect to Wi-Fi
  wifiManager.autoConnect("AutoParkAccessPoint");

  // Get configuration values
  mqttServer = custom_mqtt_server.getValue();
  mqttPort = atoi(custom_mqtt_port.getValue());

  Serial.begin(4800);
  myservo.attach(13);

  // Inicializa a conexão com o broker MQTT
  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);

  reconnectMQTT();
}

void callback(char *topic, byte *payload, unsigned int length)
{
  Serial.print("Mensagem recebida do tópico: ");
  Serial.println(topic);

  String message = "";
  for (int i = 0; i < length; i++)
  {
    message += (char)payload[i];
  }
  Serial.println("Conteúdo da mensagem: " + message);

  String inputString = message;
  int dotIndex = inputString.indexOf(':');
  String incomingParkId = inputString.substring(0, dotIndex);
  String action = inputString.substring(firstDotIndex + 1);

  if (incomingParkId.equals(parkingIds))
  {
    if (action == "open" && currentState == STATE_IDLE)
    {
      currentState = STATE_OPENING;
      stateStartTime = millis();
      openCancela();
    }
  }

  switch (currentState)
  {
  case STATE_OPENING:
    if (millis() - stateStartTime >= 10000)
    {
      currentState = STATE_WAIT_FOR_CLOSE;
      stateStartTime = millis();
      fecharCancela();
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

void publishMessage(const char *topic, const char *message)
{
  client.publish(topic, message);
}

void reconnectMQTT()
{
  while (!client.connected())
  {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP8266Client"))
    {
      Serial.println("connected");
      client.subscribe(mqtt_topic_cancela);
      // ESP8266Client connected e hora atual
      const char *message = "ESP8266Client connected";
      publishMessage(mqtt_topic_connected_device, message);
    }
    else
    {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void openCancela()
{
  Serial.println("Cancela aberta");
  myservo.write(0);
}

void closeCancela()
{
  Serial.println("Cancela fechada");
  myservo.write(180);
}
