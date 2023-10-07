# memory_game
Task2 for CPSC334: interactive memory game for two players, using 2 esp32 controllers and processing

## how does it work?
this game is played using 2 esp32 controllers - one for each player. 
the players switch off being the "composer" - the one who creates the pattern, and the "student," who repeats the pattern back.
the pattern is created and repeated via a Processing GUI - a 4x4 grid
- you navigate through this grid via joystick, and select a square using a button.
the game starts with player1(composer) hitting one square, then player2(student) has to hit the same square.
Player2 then becomes the composer and adds an additional square to the pattern.
then, Player1 becomes the student and repeats that 2 square pattern, and so on, until someone in the student role misremembers.

click here to watch a demo recording: https://youtu.be/ZUUsOlhkIS0

good luck!

## install instructions
want to play? 

### baseline 
have the arduino IDE and Processing installed 
within Processing - import sound and serial libraries

#### esp32 installation
navigate to the game controller folder and upload code to your esp32s (board: ESP32 Dev Module)
connect both esp32 to your computer that has the processing code installed
open movingGrid in Processing and press play (if dead, just replay the Processing code)
