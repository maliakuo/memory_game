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

String[] vals = new String[4]; // for joystick input



void setup() {
   print(Serial.list());
  //  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  String maggiePort = Serial.list()[3];
 // myPort = new Serial(this, portName, 9600);
  newESP32 = new Serial(this, maggiePort, 9600);
  
  size(400, 400);
  // 4 x 4 grid
  cols = 4;
  rows = 4;
 // surface.setResizable(true);

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

    // if (i == 1) {
    //    if(j == 2){
    //      if(keyCode == UP) {
            
    //       fill(40, 100, 150);
    //      }
    //    }
    //    else {
    //      fill(255);
    //    }
    //  }
    //  else {
    //    fill(255);
    //}
     // fill(255);
    // joystick();
     if(keyPressed == true) {
       keyInit = true;
     }
     
     if(newval != null && !newval.isEmpty()) {
       //print("true");
       keyInit = true;
     }
     
     if(keyInit == true) {
    //   joystick(i, j);
    //// } else{
    // //fill(255);
    // }
    
    //if (i == current[0] && j == current[1]) {
    //  fill(80, 180, 200);
    //}
     
     //UP RIGHT DOWN LEFT 
      if(newval.equals("D")) {
        sqY++; 
        if(sqY == 5) {
          sqY = 1;
        }
      movePlayer(i, j, "DOWN");
    }
  if(newval.equals("U")){
    sqY--; 
    if(sqY == 0) {
      sqY = 4;
    }
    movePlayer(i, j, "UP");
  }
  if(newval.equals("L")){
    sqX--; 
    if(sqX == 0) {
      sqX = 4;
    }
    movePlayer(i, j, "LEFT");
  }
  if(newval.equals("R")){
    sqX++; 
    if(sqX == 5) {
      sqX = 1;
    }
    movePlayer(i, j, "RIGHT");
  }
    }
   // movePlayer(i, j, "DOWN");

     
     //movePlayer(i, j, keycode);

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
  if(newval.equals("D")) {
    sqY++; 
    if(sqY == 5) {
      sqY = 1;
    }
    movePlayer(i, j, "DOWN");
  }
  if(newval.equals("U")){
    sqY--; 
    if(sqY == 0) {
      sqY = 4;
    }
    movePlayer(i, j, "UP");
  }
  if(newval.equals("L")){
    sqX--; 
    if(sqX == 0) {
      sqX = 4;
    }
    movePlayer(i, j, "LEFT");
  }
  if(newval.equals("R")){
    sqX++; 
    if(sqX == 5) {
      sqX = 1;
    }
    movePlayer(i, j, "RIGHT");
   // movePlayer(i, j, "DOWN");

  }
}

void movePlayer(int x, int y, String keycode){

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

   // CALIBRATING
    if(i < 4) {
      vals[i] = newval;
      println(vals);    //print(vals);
      i++;
    }
    println("newval is ", newval);
    }
    

  
  
}
