#include "esp_camera.h"
#include <WiFi.h>
#include <ESPmDNS.h>
#define CAMERA_MODEL_AI_THINKER
#include "camera_pins.h"
#include <MQTT.h>


const char* ssid = "";
const char* password = "";

//void startCameraServer();

#define ESP32CAM_PUBLISH_TOPIC "esp32/cam_0"
const int bufferSize = 1024 * 23;  // 23552 bytes

WiFiClient net;
MQTTClient client(bufferSize);

const char broker[] = "192.168.1.12";
int port = 1883;

void waitWifiConnect() {
  Serial.println("Booting");
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  if (WiFi.waitForConnectResult() != WL_CONNECTED) {
    Serial.println("Connection Failed! Rebooting...");
    delay(5000);
    ESP.restart();
  }


  client.begin(broker, net);

  Serial.print("Attempting to connect to the MQTT broker: ");
  Serial.println(broker);


  Serial.print("\nconnecting...");
  while (!client.connect(broker)) {
    Serial.print(".");
    delay(1000);
  }


  Serial.println("You're connected to the MQTT broker!");
  Serial.println();

  Serial.print("Subscribing to topic: ");
  Serial.println(ESP32CAM_PUBLISH_TOPIC);
  Serial.println();

  // subscribe to a topic
  client.subscribe(ESP32CAM_PUBLISH_TOPIC);

  if (!client.connected()) {
    Serial.println(" IoT Timeout!");
    ESP.restart();
    return;
  }


  Serial.println("");
  Serial.println("WiFi connected");
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
    // mqttClient.beginMessage(ESP32CAM_PUBLISH_TOPIC);
    // mqttClient.print((const char*)fb->buf);
    // mqttClient.endMessage();

    bool result = client.publish(ESP32CAM_PUBLISH_TOPIC, (const char*)fb->buf, fb->len);
    Serial.println(result);

    if (!result) {
      ESP.restart();
    }
  }
  esp_camera_fb_return(fb);
  delay(10000);
}

void setup() {
  Serial.begin(115200);
  Serial.setDebugOutput(true);
  Serial.println();

  setupESPCam();
  waitWifiConnect();
  //startCameraServer();

  Serial.print("Camera Ready! Use 'http://");
  Serial.print(WiFi.localIP());
  Serial.println("' to connect");
}

void loop() {
  //ArduinoOTA.handle();
  delay(10);
  client.loop();
  if (client.connected()) grabImage();
}