/* need to






*/

// Example 16-6: Drawing a grid of squares
import processing.serial.*;

// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480
int videoScale = height;

// Number of columns and rows in our system
int cols, rows;
int[] current = new int[2];
int sqX = 1;
int sqY = 2;

Serial myPort;  // Create object from Serial class
Serial newESP32;
String val;     // Data received from the serial port
String newval;
String changedVal;
String left = "0";
int input1;

String[] vals = new String[1]; // for joystick input

boolean moveRight = false;
boolean moveLeft = false;
boolean moveUp = false;
boolean moveDown = false;

void setup() {
  // print(Serial.list());
  //  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  String maggiePort = Serial.list()[3];
 // myPort = new Serial(this, portName, 9600);
  newESP32 = new Serial(this, maggiePort, 9600);
  
  size(400, 400);
  // 4 x 4 grid
  cols = 4;
  rows = 4;
  surface.setResizable(true);

}

void draw() {
  int x;
  int y;
  Boolean keyInit = false;

  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {

      // Scaling up to draw a rectangle at (x,y)
      x = i*videoScale;
      y = j*videoScale;

     if(keyPressed == true) {
       keyInit = true;
       movePlayer(i, j, sqX, sqY);
     }
     

     joystick(i, j);
    // moveRight = false;
    // moveLeft = false;
     print("sqX:");
     println(sqX);
     print("sqY:");

     println(sqY);

      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
    readData();
    }
  }
  
}

void keyPressed() {
  if(keyCode == DOWN){
    sqY++; 
    if(sqY == 5) {
      sqY = 1;
    }
  }
  if(keyCode == UP){
    sqY--; 
    if(sqY == 0) {
      sqY = 4;
    }
  }
  if(keyCode == LEFT){
    sqX--; 
    if(sqX == 0) {
      sqX = 4;
    }
  }
  if(keyCode == RIGHT){
    sqX++; 
    if(sqX == 5) {
      sqX = 1;
    }
  }
}

void joystick(int i, int j) {
  if(newval != null) {
    
   //if(newval.equals(vals[0]) == true){
   ////   println("true");
   // }
   // else {
   //  //println("false"); 
   // }
    //rintln(newval);

   
    print("newval: ");
    println(newval);
   // print(" vals[0]: ");
  //  println(vals[0]);
  if(newval.equals("U") && moveUp == false){
    sqY--; 
    //print("case1: ");
    //println(newval);
    if(sqY == 0) {
      sqY = 4;
    }
    moveUp = true;
 //  movePlayer(i, j, sqX, sqY);
   } else if(newval.equals("R") && moveRight == false){
   //  if(hasBeenPressed){
     sqX++; 
   // print("case2: ");
    //println(newval);
    if(sqX == 5) {
      sqX = 1;
    }
    moveRight = true;
   }
    
  // println(sqX);
//   movePlayer(i, j, sqX, sqY);
   else if(newval.equals("D") && moveDown == false){
    sqY++; 
   // print("case3: ");
   // println(newval);
    if(sqY == 5) {
      sqY = 1;
    } 
    moveDown = true;
  } else if(newval.equals("L") && moveLeft == false){
    sqX--; 
  //  print("case4: ");
  //  println(newval);
    if(sqX == 0) {
      sqX = 4;
    }
 //  movePlayer(i, j, sqX, sqY);
    moveLeft = true;
  }
     movePlayer(i, j, sqX, sqY);
  //println(sqX);
  //println(sqY);
  
  }

}

void movePlayer(int x, int y, int sqX, int sqY){

    for(int i = 0; i < sqX; i++) {
      for(int j = 0; j < sqY; j++) {
  //    if(keyCode == DOWN) {
         if(i == x && j == y) {
             fill(80, 180, 200);
         int[] current = {x, y}; // current square hovering over
   //    }
        }
      else {
      fill(255);
      }
    
   // println(sqY);
  }
}
}
int i = 0;
void readData(){
    if ( newESP32.available() > 0) 
  {  // If data is available,
//
    newval = newESP32.readString(); 

   // resetting booleans
    //if(i < 20) {
    //  vals[i] = newval;
    vals = append(vals, newval);
    if(i > 0) {
      if(!(newval.equals(vals[i - 1])) && newval.equals("R")) {
        moveRight = false;
      }
      if(!(newval.equals(vals[i - 1])) && newval.equals("L")) {
        moveLeft = false;
      }
      if(!(newval.equals(vals[i - 1])) && newval.equals("U")) {
        moveUp = false;
      }
      if(!(newval.equals(vals[i - 1])) && newval.equals("D")) {
        moveDown = false;
      }
    }
      i++;
    //}
    //println(newval);    //print(vals);

   // println(vals[1]);
    }

    

  
  
}
