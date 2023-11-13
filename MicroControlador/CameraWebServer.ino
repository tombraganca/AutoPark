#include "esp_camera.h"
#include <WiFi.h>
#include <ESPmDNS.h>
#define CAMERA_MODEL_AI_THINKER
#include "camera_pins.h"
#include <MQTT.h>
#include <iostream>
#include <string>
#include <DNSServer.h>
#include <WiFiManager.h>

// Constants
#define ESP32CAM_PUBLISH_TOPIC "autopark/cam_0"
const int bufferSize = 1024 * 23;  // 23552 bytes
int max_attempts = 10;  // max mqqt conection attempts

WiFiClient wClient;
MQTTClient client(bufferSize); // bufferSize set directly in MQTTClient constructor
WiFiManager wifiManager;


int stoi(const char *str, int defaultValue);
void setupESPCam();
void grabImage();
String getChipIdAsString();
void setupWiFiManager();
void setupAPandMQTT();
void connectToWiFi();
void connectToMQTT();

void setup() {
  Serial.begin(115200);
  Serial.setDebugOutput(true);
  Serial.println();

  setupESPCam();
  setupAPandMQTT();
}

void loop() {
  delay(10); // every 10 ms, grab the ESP-CAM image
  client.loop();
  if (client.connected()) {
    grabImage();
  }
}

void setupWiFiManager() {
  Serial.println("Setting up WiFi Manager");
  wifiManager.setConfigPortalTimeout(240);
  wifiManager.resetSettings(); // to remove

  String AccessPointSSID = String("TORRE") + getChipIdAsString();
  if (!wifiManager.autoConnect(AccessPointSSID.c_str(), "AutoPark123")) {
    Serial.println(F("Failed to connect. Resetting and trying again..."));
    delay(3000);
    ESP.restart();
    delay(5000);
  }
}


int stoi(const char* str, int defaultValue) {
    try {
        return std::stoi(str);
    } catch (const std::invalid_argument&) {
        std::cerr << "Invalid argument: Unable to convert to integer." << std::endl;
    } catch (const std::out_of_range&) {
        std::cerr << "Out of range error: Unable to convert to integer." << std::endl;
    }
    return defaultValue;
}

void setupESPCam() {
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;

  if (psramFound()) {
    config.frame_size = FRAMESIZE_UXGA;
    config.jpeg_quality = 10;
    config.fb_count = 2;
  } else {
    config.frame_size = FRAMESIZE_SVGA;
    config.jpeg_quality = 12;
    config.fb_count = 1;
  }


  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    return;
  }

  sensor_t* s = esp_camera_sensor_get();

  if (s->id.PID == OV3660_PID) {
    s->set_vflip(s, 1);
    s->set_brightness(s, 1);
    s->set_saturation(s, -2);
  }

  s->set_framesize(s, FRAMESIZE_QVGA);
}

void grabImage() {
  // send message, the Print interface can be used to set the message contents

  camera_fb_t* fb = esp_camera_fb_get();
  if (fb != NULL && fb->format == PIXFORMAT_JPEG && fb->len < bufferSize) {
    Serial.print("Image Length: ");
    Serial.print(fb->len);
    Serial.print("\t Publish Image: ");
    bool result = client.publish(ESP32CAM_PUBLISH_TOPIC, (const char*)fb->buf, fb->len);
    Serial.println(result);

    if (!result) {
      ESP.restart();
    }
  }
  esp_camera_fb_return(fb);
  delay(10000);
}

String getChipIdAsString() {
  // Get ESP32 Chip ID
  uint64_t chipId = ESP.getEfuseMac();

  // Convert Chip ID to a string
  String chipIdString = String(chipId, HEX);

  return chipIdString;
}

void setupAPandMQTT() {
  WiFiManagerParameter custom_mqtt_server("server", "MQTT Server", "192.168.1.4", 40);
  WiFiManagerParameter custom_mqtt_port("port", "MQTT Port", "1883", 5);
  WiFiManagerParameter custom_mqtt_user("user", "MQTT User", "", 40);
  WiFiManagerParameter custom_mqtt_pass("pass", "MQTT Password", "", 40);

  wifiManager.addParameter(&custom_mqtt_server);
  wifiManager.addParameter(&custom_mqtt_port);
  wifiManager.addParameter(&custom_mqtt_user);
  wifiManager.addParameter(&custom_mqtt_pass);

  setupWiFiManager();

  const char *mqtt_server = custom_mqtt_server.getValue();
  const char *mqtt_portStr = custom_mqtt_port.getValue();
  int mqtt_port = stoi(mqtt_portStr, 1883);
  const char *mqtt_user = custom_mqtt_user.getValue();
  const char *mqtt_pass = custom_mqtt_pass.getValue();

  client.begin(mqtt_server, wClient);

  Serial.print("Attempting to connect to the MQTT broker: ");
  Serial.println(mqtt_server);

  Serial.print("\nConnecting to MQTT");

  int attempts = 1;
  bool isMqttConnected = false;

  while (!isMqttConnected) {
    if (strlen(mqtt_user) > 0 && strlen(mqtt_pass) > 0) {
      isMqttConnected = client.connect(mqtt_server, mqtt_user, mqtt_pass);
    } else {
      isMqttConnected = client.connect(mqtt_server);
    }
    Serial.print(".");
    delay(1000);
    if (attempts > max_attempts) {
      wifiManager.resetSettings();
      ESP.restart();
      break;
    }
    attempts++;
  }

  if (isMqttConnected) {
    Serial.println("\nConnected to MQTT");
    Serial.print("Subscribing to topic: ");
    Serial.println(ESP32CAM_PUBLISH_TOPIC);

    // subscribe to a topic
    client.subscribe(ESP32CAM_PUBLISH_TOPIC);


  } else {
    Serial.println("\nFailed to connect to MQTT. IoT Timeout!");
    ESP.restart();
  }
}

