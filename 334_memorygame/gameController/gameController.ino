/*
 * This ESP32 code is created by esp32io.com
 *
 * This ESP32 code is released in the public domain
 *
 * For more detail (instruction and wiring diagram), visit https://esp32io.com/tutorials/esp32-joystick
 */

#include <ezButton.h>

#define VRX_PIN  36 // ESP32 pin GPIO36 (ADC0) connected to VRX pin
#define VRY_PIN  39 // ESP32 pin GPIO39 (ADC0) connected to VRY pin
#define SW_PIN   17 // ESP32 pin GPIO17 connected to SW  pin


#define BUTTON_PIN  18 // ESP32 pin GPIO18, which connected to button
#define LED_PIN     21 // ESP32 pin GPIO21, which connected to led

// variables will change:
int led_state = LOW;    // the current state of LED
int button_state;       // the current state of button
int last_button_state;  // the previous state of button
  
char last = 'X';
char current = 'Y';

ezButton button(SW_PIN);

int valueX = 0; // to store the X-axis value
int valueY = 0; // to store the Y-axis value
int bValue = 0; // To store value of the button



void setup() {
  Serial.begin(9600) ;
  button.setDebounceTime(50); // set debounce time to 50 milliseconds
  pinMode(BUTTON_PIN, INPUT_PULLUP); // set ESP32 pin to input pull-up mode
  pinMode(LED_PIN, OUTPUT);          // set ESP32 pin to output mode

  button_state = digitalRead(BUTTON_PIN);
}

void loop() {
  button.loop(); // MUST call the loop() function first


  // read X and Y analog values
  valueX = analogRead(VRX_PIN);
  valueY = analogRead(VRY_PIN);

  // Read the button value
  bValue = button.getState();

  if (button.isPressed()) {
    Serial.println("The button is pressed");
    // TODO do something here
  }

  if (button.isReleased()) {
    Serial.println("The button is released");
    // TODO do something here
  }

  // print data to Serial Monitor on Arduino IDE
  //Serial.print(valueX);
  if(valueX == 0) {
    current = 'L';
    if(current != last) {
      Serial.print("L");
      last = 'L';
    }
  }
if(valueX == 4095) {
  current = 'R';
  if(current != last)
   Serial.print("R");
   last = 'R';
  }
if(valueY == 4095) {
  current = 'D';
  if(current != last)
   Serial.print("D");
   last = 'D';
  }
  if(valueY == 0) {
  current = 'U';
  if(current != last)
   Serial.print("U");
   last = 'U';
  }
  

//  Serial.print(" : button = ");
//  Serial.println(bValue);

//   last_button_state = button_state;      // save the last state
//   button_state = digitalRead(BUTTON_PIN); // read new state

  if (last_button_state == HIGH && button_state == LOW) {
    Serial.println("BUTTON PRESSED");

    // toggle state of LED
    led_state = !led_state;

    // control LED arccoding to the toggled state
    digitalWrite(LED_PIN, led_state);
  }

  
}
