#include <WiFi.h>
#include <time.h>
#include <ESP32Servo.h>
#include <PubSubClient.h>
#include <MillisTimerLib.h>

enum State {
  STATE_IDLE,
  STATE_OPENING,
  STATE_WAIT_FOR_CLOSE,
};

// Configurações da rede Wi-Fi
const char *ssid = "BRAGANCA";
const char *password = "16210115";

// Configurações do broker MQTT
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
  // Inicializa a conexão Wi-Fi
  Serial.begin(4800);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(1000);
    Serial.println("Conectando ao WiFi...");
  }
  myservo.attach(13);

  // Inicializa a conexão com o broker MQTT
  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);

  reconnectMQTT();
}

void loop()
{
  if (!client.connected())
  {
    reconnectMQTT();
  }
  client.loop();
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
  
  if (mensagem == "open" && currentState == STATE_IDLE) {
      currentState = STATE_OPENING;
      stateStartTime = millis();
      openCancela();
    }

    switch (currentState) {
    case STATE_OPENING:
      if (millis() - stateStartTime >= 10000) {
        currentState = STATE_WAIT_FOR_CLOSE;
        stateStartTime = millis();
        fecharCancela();
      }
      break;
      
    case STATE_WAIT_FOR_CLOSE:
      if (millis() - stateStartTime >= 5000) {
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
