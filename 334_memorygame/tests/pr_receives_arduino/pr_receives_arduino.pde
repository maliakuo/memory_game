import processing.serial.*;

Serial myPort;  // Create object from Serial class
Serial newESP32;
String val;     // Data received from the serial port
String newval;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  print(Serial.list());
  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  String maggiePort = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  newESP32 = new Serial(this, maggiePort, 9600);
}

void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
  val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  
  if ( newESP32.available() > 0) 
  {  // If data is available,
  newval = newESP32.readStringUntil('\n');         // read it and store it in val
  } 
println(val); //print it out in the console
println(newval);
}
