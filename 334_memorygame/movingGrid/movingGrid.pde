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
int sqY = 2;
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

// initializing coordinate array
ArrayList <Coordinates> coords = new ArrayList<Coordinates>();;

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
  
  //coords = new Coordinates[30];

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
     readButton();


      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
    readData();
    writeData();
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

void movePlayer(int x, int y, int sqX, int sqY){

    for(int i = 0; i < sqX; i++) {
      for(int j = 0; j < sqY; j++) {
  //    if(keyCode == DOWN) {
         if(i == x && j == y) {
             fill(80, 180, 200);
   //    }
        }
      else {
      fill(255);
      }
    
   // println(sqY);
  }
}
}

void readButton() {
  if(newval != null) {
    

  if(newval.equals("BP") && button == false) {
    print("here");
 
       print("x: ");
       print(sqX);
       print("y: ");
       println(sqY);
       
       fill(235, 64, 52);
       coords.add(new Coordinates(sqX, sqY));
      
      for (int i = 0; i < coords.size(); i++) {
        Coordinates coord = coords.get(i);
        print("xcoords");
        print(coord.x);
        print(" ");
        print("ycoords");
        print(coord.y);
        print("\n");
      }
      
      //for(int i = 0; i < sqX; i++) {
      //  for(int j = 0; j < sqY; j++) {
      //   if(i == sqX && j == sqY) {
      //       fill(235, 64, 52);
      //    } else {
      //      fill(255);
      //    }
      //  }
      //}
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

void writeData() {
  if (mousePressed == true) {                           
       //if we clicked in the window
        newESP32.write('1');        
        //send a 1
        //println("1");
      } 
}
