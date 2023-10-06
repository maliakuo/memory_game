/*
 * This ESP32 code is created by esp32io.com
 *
 * This ESP32 code is released in the public domain
 *
 * For more detail (instruction and wiring diagram), visit https://esp32io.com/tutorials/esp32-joystick
 */

#include <ezButton.h>

#define LED 22
#define VRX_PIN 36 // ESP32 pin GPIO36 (ADC0) connected to VRX pin
#define VRY_PIN 39 // ESP32 pin GPIO39 (ADC0) connected to VRY pin
#define SW_PIN 17 // ESP32 pin GPIO17 connected to SW  pin


#define BUTTON_PIN 18 // ESP32 pin GPIO18, which connected to button
// #define LED_PIN     21 // ESP32 pin GPIO21, which connected to led
// #define BUTTON_PIN 21 // GPIO21 pin connected to button

  char val;


// variables will change:
  bool ledState = LOW;    //the current state of LED
  int button_state;  // the current state of button
  int last_button_state;  // the previous state of button
// Variables will change:
  int lastState = HIGH; // the previous state from the input pin
  int currentState; // the current reading from the input pin  

  char last = 'X';
  char current = 'Y';

  ezButton button(SW_PIN);

  int valueX = 0; // to store the X-axis value
  int valueY = 0; // to store the Y-axis value
  int bValue = 0; // To store value of the button



void setup() {
  Serial.begin(9600) ;
  button.setDebounceTime(50); // set debounce time to 50 milliseconds
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED, OUTPUT);


  button_state = digitalRead(BUTTON_PIN);

}

void loop() {
  button.loop(); // MUST call the loop() function first

  if (Serial.available() > 0) { // If data is available to read,
    val = Serial.read(); // read it and store it in val

    if(val == '1') //if we get a 1
    {
       ledState = !ledState; //flip the ledState
       digitalWrite(LED, ledState); 
    }
    delay(100);
  } 
      
  //  read X and Y analog values
    valueX = analogRead(VRX_PIN);
    valueY = analogRead(VRY_PIN);

    // Serial.println("\n");
    // Serial.println(valueX);
    // Serial.println(valueY);

    if(valueX == 0 && (1500 < valueY < 2500)) {
      current = 'L';
      if(current != last) {
        Serial.print("L");
        last = 'L';
        }
    }
    else if(valueX == 4095 && (1500 < valueY < 2500)) {
      current = 'R';
      if(current != last)
    Serial.print("R");
      last = 'R';
    }
    else if(valueY == 4095 && (1500 < valueX < 2500)) {
      current = 'D';
      if(current != last)
      Serial.print("D");
      last = 'D';
    }
    else if(valueY == 0 && (1500 < valueX < 2500)) {
      current = 'U';
      if(current != last)
      Serial.print("U");
      last = 'U';
    } else {
      current = 'X';
      if (current != last) {
        Serial.print("X");
      last = 'X';
      }
      }

    // read state of button
    currentState = digitalRead(BUTTON_PIN);

    if(lastState == LOW && currentState == HIGH) {
      Serial.print("BP");
    }
    
    lastState = currentState;
    
}