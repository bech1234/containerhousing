#include <Arduino.h>
#include <SPI.h>
#include <PN532_SPI.h>
#include <PN532.h>
#include <NfcAdapter.h>
#include <WebSocketsClient.h>

#include <ArduinoJson.h>

#include <ESP8266WiFi.h>
#include <WiFiClientSecure.h>
#include <ESP8266HTTPClient.h>

#include <ladder.h>

/*
#define DEVICE String("Housing1")
#define DEVICE_COLOR String("purple")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/e05221c3-a2c2-4c1e-b0f8-1e68eb7addec"
#define DEVICE_TOKEN "Authorization: Bearer 36711b54cbb3267059fd631a1cd27594"
#define DEG_0 26
#define DEG_45 46
#define DEG_90 65
#define DEG_135 87
#define DEG_180 108


#define DEVICE String("Housing2")
#define DEVICE_COLOR String("yellow")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/057c9d67-7914-41df-a243-80d9a0f00cb3"
#define DEVICE_TOKEN "Authorization: Bearer 13d93c1787fb5a4449688fe4fbaaa920"
#define DEG_0 26
#define DEG_45 46
#define DEG_90 60
#define DEG_135 87
#define DEG_180 100


#define DEVICE String("Housing3")
#define DEVICE_COLOR String("purple")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/c2072266-7452-453e-8652-c1d02c9a9b9a"
#define DEVICE_TOKEN "Authorization: Bearer f62ca010ffe3522d3b9cbdcf7cdf9b59"
#define DEG_0 26
#define DEG_45 46
#define DEG_90 65
#define DEG_135 87
#define DEG_180 108


#define DEVICE String("Housing4")
#define DEVICE_COLOR String("yellow")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/4145c58a-3a36-4620-b370-e5b02f9750ae"
#define DEVICE_TOKEN "Authorization: Bearer 34276ad49eef611872df9a712732a54"
#define DEG_0 26
#define DEG_45 46
#define DEG_90 65
#define DEG_135 87
#define DEG_180 108


#define DEVICE String("Housing5")
#define DEVICE_COLOR String("yellow")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/864ec918-be2c-41e8-9abf-5c11ce516df3"
#define DEVICE_TOKEN "Authorization: Bearer e690549b827b97e6a3175ec2cc48ff74"
#define DEG_0 26
#define DEG_45 46
#define DEG_90 65
#define DEG_135 87
#define DEG_180 108

*/

#define DEVICE String("Housing6")
#define DEVICE_COLOR String("red")
#define DEVICE_ID "/com.sap.iotservices.mms/v1/api/ws/data/278be146-2fd2-4860-8a70-23a1400c1342"
#define DEVICE_TOKEN "Authorization: Bearer fb4d9ce7f94711b0381a589ff4c9434d"

#define DEG_0 30
#define DEG_45 46
#define DEG_90 65
#define DEG_135 87
#define DEG_180 108

/*
*/


#define LED_R D0
#define LED_G D1
#define LED_B D2
#define LED_RED D0
#define LED_GREEN D1
#define LED_BLUE D2

#define HALL_RIGHT D3
#define HALL_TOP D4

#define SERVO D8

#define NFC_CS 10



PN532_SPI pn532spi(SPI, NFC_CS);
NfcAdapter nfc = NfcAdapter(pn532spi);

enum LedState { LED_OFF, LED_BLINK, LED_ON };

boolean tagPresent = false;
boolean online = false;
LedState red = LED_OFF;
LedState blue = LED_OFF;
LedState green = LED_OFF;

Ladder executor;

WebSocketsClient webSocket;

void webSocketEvent(WStype_t type, uint8_t * payload, size_t length);

#include "actions.h";

void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {


  switch (type) {
    case WStype_DISCONNECTED:
      online = false;
      Serial.printf("[WSc] Disconnected!\n");
      break;

    case WStype_CONNECTED:
      online = true;
      Serial.printf("[WSc] Connected to url: %s\n",  payload);
      executor.addAction(new SendPowerOnAction());
      break;

    case WStype_TEXT:
      {
        Serial.printf("ws: %s\n", payload);
        DynamicJsonBuffer jsonBuffer;
        JsonObject& root = jsonBuffer.parseObject(payload);

        if (root["messageType"].as<String>() == "0b829df5bec85cd0d05c") {
          executor.addAction(new ExtendEjectorAction());
          return;
        }
        if (root["messageType"].as<String>() == "24335d43d00a1f967d65") {
          executor.addAction(new WriteNfcAction(root["messages"][0]["payload"].as<String>()));
          return;
        }
        if (root["messageType"].as<String>() == "88f60e85ca9413bf4927") {
          if (root["messages"][0]["red"].as<String>() == "on") {
            red = LED_ON;
          }
          if (root["messages"][0]["red"].as<String>() == "off") {
            red = LED_OFF;
          }
          if (root["messages"][0]["red"].as<String>() == "blink") {
            red = LED_BLINK;
          }
          if (root["messages"][0]["green"].as<String>() == "on") {
            green = LED_ON;
          }
          if (root["messages"][0]["green"].as<String>() == "off") {
            green = LED_OFF;
          }
          if (root["messages"][0]["green"].as<String>() == "blink") {
            green = LED_BLINK;
          }
          if (root["messages"][0]["blue"].as<String>() == "on") {
            blue = LED_ON;
          }
          if (root["messages"][0]["blue"].as<String>() == "off") {
            blue = LED_OFF;
          }
          if (root["messages"][0]["blue"].as<String>() == "blink") {
            blue = LED_BLINK;
          }

          return;
        }

      }

      break;

    case WStype_BIN:
      // None of these
      break;
  }

}


void setup() {
  pinMode(LED_R, OUTPUT);
  pinMode(LED_G, OUTPUT);
  pinMode(LED_B, OUTPUT);

  pinMode(HALL_RIGHT, INPUT);
  pinMode(HALL_TOP, INPUT);
  pinMode(SERVO, OUTPUT);

  // Set the servo position immediately so nothing blocks or breaks
  analogWrite(SERVO, 0);
  analogWriteFreq(50);
  analogWriteRange(1000);
  analogWrite(SERVO, DEG_180);


  executor.addAction(new ApplyLedStateAction(micros(), 1000));
  executor.addAction(new SelfTestAction());
  executor.addAction(new ScanNetworksAction(2000000));

  // Start NFC after network connection acquired

  Serial.begin(74880);
  Serial.println("Setup done");
  Serial.println(DEVICE);
}

void loop() {
  executor.execute();
}
