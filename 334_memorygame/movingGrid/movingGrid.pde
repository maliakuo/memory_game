/* need to






*/

// Example 16-6: Drawing a grid of squares

// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480
int videoScale = height;

// Number of columns and rows in our system
int cols, rows;
int[] squares = new int[15];
int sqX = 3;
int sqY = 2;

void setup() {
  size(400, 400);
  // 4 x 4 grid
  cols = 4;
  rows = 4;

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
     if(keyPressed == true) {
       keyInit = true;
     }
     
     if(keyInit == true) {
       movePlayer(i, j, "DOWN");
    // } else{
     //fill(255);
     }
     
     //movePlayer(i, j, keycode);

      stroke(0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
    
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

void movePlayer(int x, int y, String keycode){

    for(int i = 0; i < sqX; i++) {
      for(int j = 0; j < sqY; j++) {
  //    if(keyCode == DOWN) {
         if(i == x && j == y) {
             fill(40, 150, 200);
   //    }
        }
      else {
      fill(255);
      }
    
   // println(sqY);
  }
}
}
