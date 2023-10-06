int on = 1;
#define BUTTON_PIN 21 
#define SECOND_BUTTON_PIN 16 
// Variables will change:
int lastState = LOW;  // the previous state from the input pin
int currentState;     // the current reading from the input pin

int lastState2 = LOW;  // the previous state from the input pin
int currentState2;     // the current reading from the input pin

void setup() {
  // initialize digital pin GPIO18 as an output.
  pinMode(18, OUTPUT);
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  // initialize the pushbutton pin as an pull-up input
  // the pull-up input pin will be HIGH when the switch is open and LOW when the switch is closed.
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(SECOND_BUTTON_PIN, INPUT_PULLUP);
}

// the loop function runs over and over again forever
void loop() {
  if (on == 1) {
    digitalWrite(18, HIGH); 
  }

    // read the state of the switch/button:
  currentState = digitalRead(BUTTON_PIN);
  currentState2 = digitalRead(SECOND_BUTTON_PIN);

  if (lastState == HIGH && currentState == LOW)
    Serial.println("The first button is pressed");
  else if (lastState == LOW && currentState == HIGH)
    Serial.println("The first button is released");

  if (lastState2 == HIGH && currentState2 == LOW)
    Serial.println("The second button is pressed");
  else if (lastState2 == LOW && currentState2 == HIGH)
    Serial.println("The second button is released");

  // save the the last state
  lastState = currentState;
  lastState2 = currentState2;
  // digitalWrite(18, HIGH); // turn the LED on
  // delay(500);             // wait for 500 milliseconds
  // digitalWrite(18, LOW);  // turn the LED off
  // delay(500);             // wait for 500 milliseconds
}