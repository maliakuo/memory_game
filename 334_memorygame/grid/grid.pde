
// Memory Game

// port stuff

import processing.serial.*;

Serial myPort;  // Create object from Serial class
Serial newESP32;
String val;     // Data received from the serial port
String newval;
String left = "0";
int input1;

// hover color

color[] pastel = {#FFFFFF, #ffffb3, #bebada, #fb8072, #80b1d3, #fdb462, #7fc97f};

int hover = pastel[0];

boolean[] selectionState = {false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false};

//------------------------------------------------------------------------------------

void setup() {
  // runs once
  print(Serial.list());
  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  String maggiePort = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  newESP32 = new Serial(this, maggiePort, 9600);
  
  size(600, 600);
  background(255);// white
}//func

void draw() {
  // runs on and on
  // port processing
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  
  if ( newESP32.available() > 0) 
  {  // If data is available,
    newval = newESP32.readStringUntil('\n');   
    print(newval);
    print(newval.getClass().getName());
    
    if (newval.equals(left)) {
      print("0 is printed, yes");
    }
    //print(":");
    //input1 = int(newval);
    //print(input1);
    //print("\n");
    // read it and store it in val
  } 
  //println(val); //print it out in the console
  //println(newval);
 
  

  // The grid ---
  drawGrid();

  //
}//func

// ----------------------------------------------------------------------------------------
// Inputs


// Tools 1

void joystickMovement(int counter) {
  int temp;
  //print(input1);
  //print(newval);
 
  
   //left movement
  if (input1 == 0) {
    //print("true");
    if (counter == 0) {
      temp = 15;
    } else if (counter == 3 || counter == 7 || counter == 11) {
      temp = counter + 3;
    } else if (counter == 15) {
      temp = 2;
    } else {
      temp = counter - 1;
    } 
    
    
    selectionState[temp] = true;
    selectionState[counter] = false;
    
  } 
}

void drawGrid() {
  // vertical lines  |  |
  noFill();
  stroke(0);
  strokeWeight(1);
  int counter = 0;
  
  for(int y = 100; y <= 400; y += 100){
    for(int x = 100; x <= 400; x += 100) {
                  
      fill(hover);
      square(x, y, 100);
      
      //print("x is ", x);
      //print("\n");
      
      //print("y is ", y);
      //print("\n");
      
      int centerX = (x + x + 100)/ 2;
      int centerY = (y + y + 100)/ 2;
      square(centerX, centerY, 1);
      
      joystickMovement(counter);
      
      if (selectionState[counter]) {
        hover = pastel[2];
      } else {
        hover = pastel[0];
      }
      
      counter++;
      
      //print("centerX is ", centerX);
      //print("\n");
      
      //print("centerY is ", centerY);
      //print("\n");
      
      //print("distance is ", dist(centerX, centerY, mouseX, mouseY));
      //print("\n");
      
      
      
      
      //if (dist(centerX, centerY, mouseX, mouseY) < 50) {
      //  hover = pastel[2];
      //} else {
      //  hover = pastel[3];
      //}

    }
  }
}

void headline() {
  fill(255);
  noStroke();
  rect(0, 0, width, 65);
  fill(0);
  textAlign(CENTER);
  textSize(32);
  text("Memory",
    width/2, 33);
  textAlign(LEFT);
}//func
