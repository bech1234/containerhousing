class SendMessageAction;
class SendPowerOnAction;
class SendNfcPayloadAction;
class SendNfcRemoveAction;
class SendNeighbourEventAction;
class ApplyLedStateAction;
class SelfTestAction;
class SelfTest2Action;
class SelfTest3Action;
class LoopWebsocketAction;
class ConnectWebsocketAction;
class ConnectingAction;
class ConnectWiFiAction;
class ScanningAction;
class ScanNetworksAction;

class StartNfcAction;
class ReadNfcAction;
class WriteNfcAction;
class CheckNeighboursAction;
class ExtendEjectorAction;
class RetractEjectorAction;
class CheckNeighboursAction;

class StartNfcAction : public ActionInterface {
  private:

  public:
    StartNfcAction() : ActionInterface( &executor, micros(), 1000 ) {
    }

    unsigned short execute();
};

class WriteNfcAction : public ActionInterface {
  private:
    String message;
  public:
    WriteNfcAction(String m) : ActionInterface( &executor, micros(), 1000 ) {
      message = m;
    }

    unsigned short execute();
};

class ReadNfcAction : public ActionInterface {
  private:
    boolean tagPresent = false;

  public:
    ReadNfcAction() : ActionInterface( &executor, micros(), 1000 ) {
    }

    unsigned short execute();
};


class CheckNeighboursAction : public ActionInterface {
  private:
    boolean topPresent = false;
    boolean rightPresent = false;

  public:
    CheckNeighboursAction() : ActionInterface( &executor, micros(), 1000 ) {
    }

    unsigned short execute();
};


class SendMessageAction : public ActionInterface {
  private:
    String message;
  public:
    SendMessageAction(String m) : ActionInterface( &executor, micros(), 1000 ) {
      message = m;
    }

    unsigned short execute();
};


class SendPowerOnAction : public SendMessageAction {
  public:
    SendPowerOnAction() : SendMessageAction("{'messageType':'0f18a4c6d3ec0b850e74','messages':[{'device':'" + DEVICE + "', 'colour':'" + DEVICE_COLOR + "'}]}") {}
};

class SendNfcPayloadAction : public SendMessageAction {
  public:
    SendNfcPayloadAction(String nfcid, const char* payload) : SendMessageAction("{\"messageType\":\"c97316563d8cb6cd6054\",\"messages\":[{\"device\":\"" + DEVICE + "\", \"present\":true, \"nfcid\":\"" + nfcid + "\", \"payload\":\"" + payload + "\"}]}") {}
};

class SendNfcRemoveAction : public SendMessageAction {
  public:
    SendNfcRemoveAction() : SendMessageAction("{'messageType':'c97316563d8cb6cd6054','messages':[{'device':'" + DEVICE + "', 'present':false, 'nfcid':'', 'payload':''}]}") {}
};


class SendNeighbourEventAction : public SendMessageAction {
  public:
    SendNeighbourEventAction(String action, String location) : SendMessageAction("{'messageType':'bbf07d19bbae64f1e3c2','messages':[{'device':'" + DEVICE + "', 'action':'" + action + "', 'location':'" + location + "'}]}") {}
};

class ApplyLedStateAction : public ActionInterface {
  private:
    int blinkCounter = 0;
    const int blinkPoint = 50;
  public:
    ApplyLedStateAction(unsigned long b, unsigned long d) : ActionInterface( &executor, b, d ) {
    }

    unsigned short execute();
};

class ExtendEjectorAction : public ActionInterface {
  public:
    ExtendEjectorAction() : ActionInterface( &executor, micros(), 10 ) {
    }

    unsigned short execute();
};

class RetractEjectorAction : public ActionInterface {
  public:
    RetractEjectorAction() : ActionInterface( &executor, micros(), 500000 ) {
    }

    unsigned short execute();
};

class SelfTestAction : public ActionInterface {
  public:
    SelfTestAction() : ActionInterface( &executor, micros(), 1000 ) {
    }

    unsigned short execute();
};

class SelfTest2Action : public ActionInterface {
  public:
    SelfTest2Action() : ActionInterface( &executor, micros(), 500000 ) {
    }

    unsigned short execute();
};

class SelfTest3Action : public ActionInterface {
  public:
    SelfTest3Action() : ActionInterface( &executor, micros(), 500000 ) {
    }

    unsigned short execute();
};

class LoopWebsocketAction : public ActionInterface {
  private:

  public:
    LoopWebsocketAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};

class ConnectWebsocketAction : public ActionInterface {
  private:

  public:
    ConnectWebsocketAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};


class ConnectingAction : public ActionInterface {
  private:
    int lastBlue = -1;

  public:
    ConnectingAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};


class ConnectWiFiAction : public ActionInterface {
  private:
    const char* ssid[4] = { "Holmemosen18", "Holmemosen18_2", "KasperAP", "pnet"};
    const char* password[4] = { "fnidderfnadder", "fnidderfnadder", "fnidderfnadder", "sapsapsap" };

  public:
    ConnectWiFiAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};

class ScanningAction : public ActionInterface {
  private:
    int lastRed = -1;

  public:
    ScanningAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};

class ScanNetworksAction : public ActionInterface {
  private:

  public:
    ScanNetworksAction(unsigned long d) : ActionInterface( &executor, micros(), d ) {
    }

    unsigned short execute();
};


/********/



unsigned short SendMessageAction::execute() {
  webSocket.sendTXT(message);
  return COMPLETE;
}


unsigned short ApplyLedStateAction::execute() {
  addDelay(10000);

  blinkCounter++;

  switch (red) {

    case LED_OFF:
      digitalWrite(LED_RED, LOW);
      break;
    case LED_ON:
      digitalWrite(LED_RED, HIGH);
      break;
    case LED_BLINK:
      if (blinkCounter == 1) {
        digitalWrite(LED_RED, HIGH);
      }
      if (blinkCounter == blinkPoint) {
        digitalWrite(LED_RED, LOW);
      }
      break;
  }

  switch (green) {

    case LED_OFF:
      digitalWrite(LED_GREEN, LOW);
      break;
    case LED_ON:
      digitalWrite(LED_GREEN, HIGH);
      break;
    case LED_BLINK:
      if (blinkCounter == 1) {
        digitalWrite(LED_GREEN, HIGH);
      }
      if (blinkCounter == blinkPoint) {
        digitalWrite(LED_GREEN, LOW);
      }
      break;
  }

  switch (blue) {

    case LED_OFF:
      digitalWrite(LED_BLUE, LOW);
      break;
    case LED_ON:
      digitalWrite(LED_BLUE, HIGH);
      break;
    case LED_BLINK:
      if (blinkCounter == 1) {
        digitalWrite(LED_BLUE, HIGH);
      }
      if (blinkCounter == blinkPoint) {
        digitalWrite(LED_BLUE, LOW);
      }
      break;
  }

  if (blinkCounter == (blinkPoint << 1)) {
    blinkCounter = 0;
  }

  return REPEAT;
}


unsigned short ExtendEjectorAction::execute() {
  analogWrite(SERVO, DEG_90);

  executor.addAction(new RetractEjectorAction());

  return COMPLETE;
}


unsigned short RetractEjectorAction::execute() {
  analogWrite(SERVO, DEG_180);

  return COMPLETE;
}


unsigned short SelfTestAction::execute() {
  Serial.println("Test LEDs");
  red = LED_ON;
  green = LED_ON;
  blue = LED_ON;

  Serial.println("Test Servo");
  analogWrite(SERVO, DEG_135);

  executor.addAction(new SelfTest2Action());

  return COMPLETE;
}


unsigned short SelfTest2Action::execute() {
  Serial.println("Test LEDs");
  red = LED_BLINK;
  green = LED_BLINK;
  blue = LED_BLINK;

  Serial.println("Test Servo");
  analogWrite(SERVO, DEG_90);

  executor.addAction(new SelfTest3Action());

  return COMPLETE;
}


unsigned short SelfTest3Action::execute() {
  Serial.println("Test LEDs");
  red = LED_OFF;
  green = LED_OFF;
  blue = LED_OFF;

  Serial.println("Test Servo");
  analogWrite(SERVO, DEG_180);

  return COMPLETE;
}

unsigned short LoopWebsocketAction::execute() {
  addDelay(100000);
  webSocket.loop();

  return REPEAT;
}


unsigned short ConnectWebsocketAction::execute() {
  webSocket.onEvent(webSocketEvent);
  webSocket.setExtraHeaders(DEVICE_TOKEN);
  webSocket.beginSSL("iotmmss0007342869trial.hanatrial.ondemand.com", 443, DEVICE_ID, "7a d8 d0 e6 a5 29 3f 47 55 b4 eb 80 54 4b a2 1b a5 b7 52 61", "wss");

  executor.addAction(new LoopWebsocketAction(1000));
  executor.addAction(new StartNfcAction());
  executor.addAction(new CheckNeighboursAction());

  return COMPLETE;
}



unsigned short ConnectingAction::execute() {
  // Wait for connection
  if (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    addDelay(500000);
    return REPEAT;
  }

  blue = LED_OFF;

  Serial.println();

  executor.addAction(new ConnectWebsocketAction(100000));

  return COMPLETE;
}


unsigned short ConnectWiFiAction::execute() {
  int networks = WiFi.scanComplete();
  int maxStrength = -100;
  int networkIndex = -1;

  for (int i = 0; i < networks; i++) {
    if (WiFi.RSSI(i) > maxStrength) {
      for (int j = 0; j < 4; j++) {
        if (WiFi.SSID(i) == ssid[j]) {
          maxStrength = WiFi.RSSI(i);
          networkIndex = j;
          break;
        }
      }
    }
  }

  if (networkIndex == -1) {
    WiFi.scanDelete();
    executor.addAction(new ScanNetworksAction(10000000l));
    return COMPLETE;
  }

  blue = LED_BLINK;

  Serial.print("Connecting ");
  Serial.println(ssid[networkIndex]);
  WiFi.begin(ssid[networkIndex], password[networkIndex]);
  executor.addAction(new ConnectingAction(10000));

  return COMPLETE;
}



unsigned short ScanningAction::execute() {
  // Wait for scan result
  int networks = WiFi.scanComplete();

  if (networks < 0) {
    Serial.print(".");
    addDelay(500000);
    return REPEAT;
  }

  red = LED_OFF;

  Serial.println();
  for (int i = 0; i < networks; i++) {
    Serial.printf("%d: %s, %ddBm\n", i + 1, WiFi.SSID(i).c_str(), WiFi.RSSI(i));
  }


  executor.addAction(new ConnectWiFiAction(1000));

  return COMPLETE;
}



unsigned short ScanNetworksAction::execute() {
  Serial.println("Scanning for WiFi networks");
  WiFi.scanNetworks(true, false);

  red = LED_BLINK;
  executor.addAction(new ScanningAction(10000));

  return COMPLETE;
}


unsigned short StartNfcAction::execute() {
  Serial.println("Starting NFC");

  nfc.begin();
  executor.addAction(new ReadNfcAction());

  return COMPLETE;
}

unsigned short ReadNfcAction::execute() {
  addDelay(1000000l);

  if (!online) {
    tagPresent = false;
    return REPEAT;
  }

  boolean isTagPresent = nfc.tagPresent(100);

  if (tagPresent == isTagPresent) {
    // no change
    return REPEAT;
  }
  if (!tagPresent && isTagPresent) {
    // Hey! News!
    // Send NFC data message
    NfcTag tag = nfc.read();

    Serial.print("UID: ");
    Serial.println(tag.getUidString());

//    const uint8_t header[] = { PN532_COMMAND_POWERDOWN, 0x20, 0x00 };
//    Serial.println(pn532spi.writeCommand(header, 3));

    if (tag.hasNdefMessage()) {
      NdefRecord record = tag.getNdefMessage().getRecord(0);
      int payloadLength = record.getPayloadLength();
      char payload[payloadLength + 1];

      record.getPayload((byte*)payload);
      payload[payloadLength] = '\0';

      Serial.println(payload);

      executor.addAction(new SendNfcPayloadAction(tag.getUidString(), payload));
    }

    tagPresent = true;
    return REPEAT;
  }
  if (tagPresent && !isTagPresent) {
    // Hey! Container gone
    executor.addAction(new SendNfcRemoveAction());
    tagPresent = false;
    return REPEAT;
  }

  return REPEAT;
}


unsigned short WriteNfcAction::execute() {
  NdefMessage nm = NdefMessage();

  Serial.print("Writing NFC ");
  Serial.println(message);

  nm.addMimeMediaRecord("application/json", message);

  nfc.write(nm);

  return COMPLETE;
}



unsigned short CheckNeighboursAction::execute() {
  addDelay(100000l);

  boolean isTopPresent = !digitalRead(HALL_TOP);
  boolean isRightPresent = !digitalRead(HALL_RIGHT);

  if (topPresent) {
    if (!isTopPresent) {
      // Hey! Housing gone
      Serial.println("Top Inactive");
      executor.addAction(new SendNeighbourEventAction("remove", "top"));
      topPresent = false;
    }
  } else {
    if (isTopPresent) {
      // Hey! News!
      Serial.println("Top Active");
      executor.addAction(new SendNeighbourEventAction("add", "top"));
      topPresent = true;
    }
  }

  if (rightPresent) {
    if (!isRightPresent) {
      // Hey! Housing gone
      Serial.println("Right Inactive");
      executor.addAction(new SendNeighbourEventAction("remove", "right"));
      rightPresent = false;
    }
  } else {
    if (isRightPresent) {
      // Hey! News!
      Serial.println("Right Active");
      executor.addAction(new SendNeighbourEventAction("add", "right"));
      rightPresent = true;
    }
  }

  return REPEAT;
}














//
