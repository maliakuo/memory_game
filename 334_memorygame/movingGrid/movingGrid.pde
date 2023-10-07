
// Example 16-6: Drawing a grid of squares
import processing.serial.*;
import processing.sound.*;

// sounds initialization
SoundFile boop;


// Size of each cell in the grid, ratio of window size to video size

int videoScale = height;

// Number of columns and rows in our system
int cols, rows;
int[] current = new int[2];
int sqX;
int sqY;
int i; // for keeping track of button movements


Serial player1;  // Create object from Serial class
Serial player2;
Serial newESP32;
String val;     // Data received from the serial port
String newval;
String changedVal;
String left;
int input1;

String[] vals = new String[1]; // for joystick input

boolean moveRight;
boolean moveLeft;
boolean moveUp;
boolean moveDown;

boolean button;

int buttonPress;
boolean dead;
int arraySize;


// booleans for player turns - blue is always player 1 // composer is true if making a pattern
boolean blueTurn;
boolean composer;

// initializing coordinate array
ArrayList <Coordinates> coords = new ArrayList<Coordinates>();;

void setup() {
   print(Serial.list());
  //  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  
 // myPort = new Serial(this, portName, 9600);
  
  
  size(400, 400);
  // 4 x 4 grid
  cols = 4;
  rows = 4;
  surface.setResizable(true);
  
  boop = new SoundFile(this, "boop.wav");
  reset();
  String port1 = Serial.list()[4];
  player1 = new Serial(this, port1, 9600);

 
  String port2 = Serial.list()[5];
  player2 = new Serial(this, port2, 9600);
  
  
}

void reset() {
  // Number of columns and rows in our system  
  sqX = 1;
  sqY = 2;
  i = 0; // for keeping track of button movements
  
  // initial array size is always 1
  arraySize = 1;
  
  left = "0";
  
  moveRight = false;
  moveLeft = false;
  moveUp = false;
  moveDown = false;
  
  button = false;
  
  buttonPress = 0;
  dead = false;
  
  
  // booleans for player turns - blue is always player 1 // composer is true if making a pattern
  blueTurn = true;
  composer = true;
}

void draw() {
  int x;
  int y;
  Boolean keyInit = false;
  if (blueTurn) {
    newESP32 = player1;
    player1.write('1');

  } else {
    newESP32 = player2;
    player2.write('1');

  }
  
  
  if (buttonPress == arraySize) {
    if (composer) {
      composer = !composer;
      blueTurn =!blueTurn;     
      buttonPress = 0;
    } else {
      composer = !composer;
      arraySize++;
    }
  } else {
    

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
     if (composer) {
       readButton();
     } else {
       comparePattern(coords);
       if (dead) {
         endSequence();
       }
     }
     

      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
      readData();
      //writeData();
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

void movePlayer(int x, int y, int sqX, int sqY){ 
    for(int i = 0; i < sqX; i++) {
      for(int j = 0; j < sqY; j++) {
          if (i == x && j == y) {
             fill(80, 180, 200);   
         } else {
             fill(255);
         }
      }
    }
}

void comparePattern(ArrayList <Coordinates> coords) {
  if(newval != null) {
    if(newval.equals("BP") && button == false) {
      
      print("x: ");
      print(sqX);
      print("y: ");
      println(sqY);
       
      Coordinates prevSel = coords.get(buttonPress);
      int prevX = prevSel.x;
      int prevY = prevSel.y;
      
      if (prevX != sqX || prevY != sqY) {
        dead = true;
      } else {
        buttonPress++;
        boop.play();
      }
      
            
      //int size = coords.size();
  
      //Coordinates coord = coords.get(size - 1);
      //int selX = coord.x;
      //int selY = coord.y;
      
      //movePlayer(selX, selY, sqX, sqY, true);

    
      }
      button = true;
    }
  } 
void readButton() {
  if(newval != null) {
    

  if(newval.equals("BP") && button == false) {
      buttonPress++;
 
       print("x: ");
       print(sqX);
       print("y: ");
       println(sqY);
       
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
      
      boop.play();
      //dead = true;
      
      //int size = coords.size();
  
      //Coordinates coord = coords.get(size - 1);
      //int selX = coord.x;
      //int selY = coord.y;
      
      //movePlayer(selX, selY, sqX, sqY, true);

    
      }
      button = true;
    }
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
  
//  button = true;

//  }
  
//}

void readData(){

    if (newESP32.available() > 0) {  
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
  //if (mousePressed == true) {                           
  //     //if we clicked in the window
  //      newESP32.write('1');        
  //      //send a 1
  //      //println("1");
  //    } 
}

void endSequence() {
  String level = "level: " + buttonPress;

  background(25);
  textSize(25);
  text("game over", 40, 40);
  text(level, 40, 140);
  text("better luck next time", 40, 240);
}
