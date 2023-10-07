/* need to






*/

// Example 16-6: Drawing a grid of squares
import processing.serial.*;

// Size of each cell in the grid, ratio of window size to video size

int videoScale = height;

// Number of columns and rows in our system
int cols, rows;
int[] current = new int[2];
int sqX = 1;
int sqY = 1;
int i = 0; // for keeping track of button movements


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

boolean button = false;

boolean selectMode = true;
boolean patternDrawn = false;

boolean player1Turn = true;

boolean turnOver = false;


int patternLength = 0; // tracking each round

int l = 0; // tracks how many times button has been clicked

int[] xTracker = new int[0];
int[] yTracker = new int[0];


void setup() {
  // print(Serial.list());
  //  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  String maggiePort = Serial.list()[3];
 // myPort = new Serial(this, portName, 9600);
  newESP32 = new Serial(this, maggiePort, 9600);
  
  size(400, 400);
  fill(50);
  // 4 x 4 grid
  cols = 4;
  rows = 4;
  surface.setResizable(true);

}

void draw() {
  int x;
  int y;
  Boolean keyInit = false;
  
  if(turnOver == false) {

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
     //if(selectMode == true) {
     //    joystick(i, j);
     //} else if(patternDrawn == false) {
     //    for(int k = 0; k < (xTracker.length - 1); k++) {
     //      movePlayer(xTracker[k], yTracker[k], rows, cols);
     //      println(xTracker[k]);
     //    //  drawPattern();
     //      delay(500);
     //      }
     //      patternDrawn = true;
     //      turnOver = true;
     //}
     
     readButton();
     // println("x");
     // println("still running");

      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
    readData();
    }
    }
  }
}

// function to alternatively play game with keyboard
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

// move through grid with joystick
void joystick(int i, int j) {
  if(newval != null) {
   
   
    //print("newval: ");
    //println(newval);

  if(newval.equals("U") && moveUp == false){
    sqY--; 
    if(sqY == 0) {
      sqY = 4;
    }
    moveUp = true;
   } else if(newval.equals("R") && moveRight == false){
   //  if(hasBeenPressed){
     sqX++; 
    if(sqX == 5) {
      sqX = 1;
    }
    moveRight = true;
   }
   else if(newval.equals("D") && moveDown == false){
    sqY++; 
    if(sqY == 5) {
      sqY = 1;
    } 
    moveDown = true;
  } else if(newval.equals("L") && moveLeft == false){
    sqX--; 
    if(sqX == 0) {
      sqX = 4;
    }
    moveLeft = true;
  }
  movePlayer(i, j, sqX, sqY);

 }

}

void movePlayer(int x, int y, int sqx, int sqy){

    for(int i = 0; i < sqx; i++) { // columns
      for(int j = 0; j < sqy; j++) { // rows
         if(i == x && j == y) {
           if(player1Turn == true) {
             fill(110, 180, 200);
         //    println("true");
           } else {
             fill(240, 170, 170);
           }
        
   //    }
        }
      else {
      fill(50);
      }
    
   // println(sqY);
  }
}
//print("test");
}

void readButton() {
  if(newval != null) {
    

  if(newval.equals("BP") && button == false) {
       if(xTracker.length == 2){
         selectMode = false;
       }

       xTracker = append(xTracker, sqX);
       yTracker = append(yTracker, sqY);
       
       print("x: ");
       println(xTracker[l]);
       print("y: ");
       println(yTracker[l]);
       
       l++;
       

  }
  button = true;

  }
  
}

void readData(){

    if ( newESP32.available() > 0) {  
      // If data is available,
    newval = newESP32.readString(); 


   // resetting booleans for joystick()
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
      if(!(newval.equals(vals[i - 1])) && newval.equals("BP")) {
        button = false;
      }
    }
      i++;
    }
 //   println(newval);
}

void drawPattern(){
    for(int i = 0; i < cols; i++) { // columns
      for(int j = 0; j < rows; j++) { // rows
         if(i == 1 && j == 1) {
             fill(110, 180, 200);
           } else {
             println("test");
          }
      }
    }
}


//void drawPattern(int x, int y, int sqx, int sqy){

//    for(int i = 0; i < sqx; i++) { // columns
//      for(int j = 0; j < sqy; j++) { // rows
//         if(i == x && j == y) {
//           if(player1Turn == true) {
//             println("case1");
//             fill(110, 180, 200);
//           } else {
//             println("case2");

//             fill(240, 170, 170);
//           }
        
//   //    }
//        }
//      else {
//      println("case3");

//      fill(50);
//      }
    
//   // println(sqY);
//  }
//}
////print("test");
//}


  
  
