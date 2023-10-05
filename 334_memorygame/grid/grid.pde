
// Memory Game

// hover color

color[] pastel = {#FFFFFF, #ffffb3, #bebada, #fb8072, #80b1d3, #fdb462, #7fc97f};

int hover = pastel[0];

boolean isSelected = false;
boolean[] selectionState = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true};

// Whose turn is it?
char player='X';

// Winner
boolean gameIsWin = false;
char winnerIs     = ' ';

// DRAW / TIE
boolean gameIsDraw = false;

// position data for the board
int[] x=
  {
  110, 300, 490,
  110, 300, 490,
  110, 300, 490
};
int[] y=
  {
  150, 150, 150,
  300, 300, 300,
  450, 450, 450
};

// The board: Which cells have been clicked?
char[] clicked =  
  {
  ' ', ' ', ' ',
  ' ', ' ', ' ',
  ' ', ' ', ' '
};

//------------------------------------------------------------------------------------

void setup() {
  // runs once
  size(600, 600);
  background(255);// white
}//func

void draw() {
  // runs on and on

  // The grid ---
  drawGrid();

  // Headline ---
  headline();

  // set footer text
  setFooterText();

  // Detect a Win
  if (! gameIsWin) {
    if (itIsWin('X')) {
      // AI won ...
      gameIsWin=true;
      winnerIs = 'X';
    } else if (itIsWin('O')) {
      // Human won ...
      gameIsWin=true;
      winnerIs = 'O';
    }//else if
  }//if

  // show messages
  showMessages();
  //
}//func

// ----------------------------------------------------------------------------------------
// Inputs

void mousePressed() {

  // When we have a win or a Tie
  if (gameIsWin || itIsDraw()) {
    return; // leave function
  }

  // text property
  textSize(82);
  textAlign(CENTER, CENTER);

  // color
  if ( player=='X')
    fill(255, 0, 0);
  else fill(0, 255, 0);

  for (int i=0; i<x.length; i++) {
    float distanceMouse=dist(mouseX, mouseY, x[i], y[i]);
    if ( distanceMouse < 50 && clicked[i] == ' ' ) {
      text(player, x[i], y[i]);
      clicked[i] = player;

      // change whose turn it is
      if ( player=='X')
        player='O';
      else player='X';

      //leave
      return;
    }//if
  } // for
  //
}//func

// ----------------------------------------------------------------------------------------
// Tools 1

void drawGrid() {
  // vertical lines  |  |
  noFill();
  stroke(0);
  strokeWeight(1);
  int counter = 0;
  
  for(int y = 100; y <= 400; y += 100){
    for(int x = 100; x <= 400; x += 100) {
      if (y == 100 && x == 100) {
        counter = 0;
      }
      
      fill(hover);
      square(x, y, 100);
      
      //print("x is ", x);
      //print("\n");
      
      //print("y is ", y);
      //print("\n");
      
      int centerX = (x + x + 100)/ 2;
      int centerY = (y + y + 100)/ 2;
      square(centerX, centerY, 1);
      
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

void setFooterText() {
  // When we have a win or a Tie
  if (gameIsWin || itIsDraw()) {
    return; // leave function
  }

  if (player=='X') {  
    // states what happens if it's player X's turn
    deleteFooter();  // delete Footer
    textAlign(LEFT);  // set text align left
    textSize(32);      //sets text size
    fill(0); //sets text color
    text("It's player X's turn", 100, 560);//displays it's X's turn
  } else {  
    // states what happens if its not player X's turn
    deleteFooter();    // delete Footer
    textAlign(LEFT);   // set text align left
    textSize(32);      //sets text size
    fill(0); //sets text color
    text("It’s O’s turn", 100, 560);  // displays it's O's turn
  }//else
}//func

void showMessages() {
  // show messages

  // show TIE message
  if (itIsDraw() && !gameIsWin) {
    deleteFooter();
    fill(0, 102, 153); //sets text color
    text("It's a TIE", 100, 550);
  }

  // show WIN message
  if (gameIsWin) {
    deleteFooter();
    fill(0); //sets text color
    // Messages
    if (winnerIs == 'X')
      text("X won", 100, 550);
    else
      text("O won ", 100, 550);
  }
}//func

void deleteFooter() {
  // make a rect to delete the old text "It’s 0’s turn"
  fill(255);   //fills rectangle (same color as background)
  noStroke();  //no stroke
  rect(0, 520, width, 200);//draws a rectangle to delete the old text
}//func

// -----------------------------------------------------------------------------------
// Tools 2: Detect a DRAW / TIE and WIN

boolean itIsDraw() {      /// -------------------- NEW --------------------------------
  // checks for Draw/Tie

  // count the not empty cells
  int counter  =  0;
  for (int i = 0; i < clicked.length; i++) {
    if (clicked[i] != ' ') {
      counter ++;
    }
  }//for

  // counting is finished.

  // Eval result
  if (counter == 9) {
    gameIsDraw=true;
    return true; // returns true when it is a Draw/Tie (counter == 9)
  }//if

  return
    false; // returns false
  //
} // func

boolean itIsWin(char playerToTest) {   /// -------------------- NEW --------------------------------

  // Tests for a Win
  // Needs to be called like if(itIsWin('X')) { // X won ... }
  // and if(itIsWin('O')) { // O won ... }
  //
  // The board / arrays clicked is enumerated like this:
  // 012
  // 345
  // 678
  // So lines to win are in the array clicked for example 0/1/2 and 0/3/6 etc.
  // When all 3 cells of one line contain the same player (parameter playerToTest)
  // we have a win.

  // check horizontal
  if (clicked[0]==playerToTest&&
    clicked [1]==playerToTest&&
    clicked [2]==playerToTest)
    return true; // The function returns true to say it found a win on this line

  if (clicked[3]==playerToTest&&
    clicked [4]==playerToTest&&
    clicked [5]==playerToTest)
    return true;

  if (clicked[6]==playerToTest&&
    clicked [7]==playerToTest&&
    clicked [8]==playerToTest)
    return true;

  //-------
  // vertical |||
  if (clicked[0]==playerToTest&&
    clicked [3]==playerToTest&&
    clicked [6]==playerToTest)
    return true;

  if (clicked[1]==playerToTest&&
    clicked [4]==playerToTest&&
    clicked [7]==playerToTest)
    return true;

  if (clicked[2]==playerToTest&&
    clicked [5]==playerToTest&&
    clicked [8]==playerToTest)
    return true;

  //-------
  // diagonal \ and /
  if (clicked[0]==playerToTest&&
    clicked [4]==playerToTest&&
    clicked [8]==playerToTest)
    return true;

  if (clicked[2]==playerToTest&&
    clicked [4]==playerToTest&&
    clicked [6]==playerToTest)
    return true;

  // -----------------------
  // nothing found
  return false; // NO WIN: The function returns false to say it hasn't found a win on ANY line
}//func
//
