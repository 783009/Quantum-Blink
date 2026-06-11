/*
  Authors: Almir Meridu & Mohamed Lahkim
  Date: June, 2, 2026
  Title: Quantum Blink
  Description: A scientist is going through a contaminated lab trying to find the source of the infection and eradicate it.
  The scientist is equipped with a short-range teleporter that he uses to phase through walls and eliminate enemies.
*/

//import processing.sound.*;

// Define the sound variables
//SoundFile woosh, hit, crawl, damage, walk, spit, fly, wall, music;

// Define the image variables
PImage Menu, logo, MenuAsset, savedFrame, Escaped;
PImage standing[] = new PImage[2];
PImage jumping[] = new PImage[2];
PImage falling[] = new PImage[2];
PImage aspid[] = new PImage[4];
PImage deepling[] = new PImage[4];
PImage walking[] = new PImage[6];
PImage afterImage, blink;
PFont Font;

//Global Variables
color WALL_DARK_BLUE = color(25, 38, 52);
color NEON_CYAN      = color(0, 240, 255);
color HAZARD_ORANGE  = color(255, 120, 0);
color GRID_DARK      = color(22, 32, 45);
color TOXIC_GREEN    = color(100, 255, 100);

// Define all the global variables
boolean Right, Left, Up, Down, dRight, dLeft, touchingGround, canBlink, doorClosed, shakeScreen, nextLevel, hasSave, isPaused, showDataLog, hasBestSave;
String gameState = "Menu";
String lastClicked = "";

int speedX, currentLevel, currentDeaths, startTime, elapsed, shakeEnd, Alpha, phase, startElapsed, pauseStartTime, bestDeaths, bestElapsed;
float speedY, distX1, distX2, distY1, distY2, smallest, ranX, ranY, afterImageX, afterImageY, acidY;

int frame = 0;
float SX, SY;

// Creates an array version of the enemy variable classes
Deepling[] Deepling;
Aspid[] Aspid;



// Escape Screen UI Variables
float escapeUiY = -600;      // Starts way off-screen
float escapeTargetY = 200;   // Where the panel stops dropping
float escapePulseAngle = 0;
boolean checkedRecords = false;
boolean isNewBestDeaths = false;
boolean isNewBestTime = false;

// Tutorial Variables
boolean showTutorial = false;
int tutorialIndex = 0;
String[] tutorialLines = {
  "Bill Nylon the science guy is trapped in this contaminated lab with these mutated enemies.",
  "He has to eradicate them using his teleportation device to override the lockdown doors and escape. SCIENCE RULES!",
  "Use WASD or Arrow keys to move and Z or SPACE to teleport. You must teleport through enemies to kill them."
};


void setup(){
  size(1200, 800);
  
  // Load in all the images and sounds
  Menu = loadImage("Menu.png");
  logo = loadImage("Logo.png");
  MenuAsset = loadImage("MenuBackgroundAsset.png");
  standing[0] = loadImage("Standing.png");
  walking[0] = loadImage("Walking_1.png");
  walking[1] = loadImage("Walking_2.png");
  walking[2] = loadImage("Walking_3.png");
  jumping[0] = loadImage("Jumping.png");
  falling[0] = loadImage("Falling.png");
  aspid[0] = loadImage("Aspid_1.png");
  aspid[1] = loadImage("Aspid_2.png");
  deepling[0] = loadImage("Deepling_1.png");
  deepling[1] = loadImage("Deepling_2.png");
  standing[1] = loadImage("StandingF.png");
  walking[3] = loadImage("Walking_1F.png");
  walking[4] = loadImage("Walking_2F.png");
  walking[5] = loadImage("Walking_3F.png");
  jumping[1] = loadImage("JumpingF.png");
  falling[1] = loadImage("FallingF.png");
  aspid[2] = loadImage("Aspid_1F.png");
  aspid[3] = loadImage("Aspid_2F.png");
  deepling[2] = loadImage("Deepling_1F.png");
  deepling[3] = loadImage("Deepling_2F.png");
  blink = loadImage("dash.png");
  Escaped = loadImage("YouEscaped.png");
  
  
  //woosh = new SoundFile(this, "enderman.wav");
  //hit = new SoundFile(this, "enemy damage.wav");
  //crawl = new SoundFile(this, "spider mini run loop.wav");
  //damage = new SoundFile(this, "damage.wav");
  //walk = new SoundFile(this, "Walk.wav");
  //fly = new SoundFile(this, "fly.wav");
  //spit = new SoundFile(this, "spit.wav");
  //wall = new SoundFile(this, "false knight.wav");
  //music = new SoundFile(this, "background-Sci-Fi.mp3");
  
  Font = createFont("Font.ttf", 32);
  textFont(Font);
  
  SX = 400;
  SY = 200;
  
  // Read "save.txt" to get the saved game
  String line = "";
  try {
    BufferedReader read = createReader("save.txt"); // Read the file
    if (read == null) {       // If the file doesn't exist
      hasSave = false;
      throw new IOException("file does not exist");      // Prevents the NullPointerException error by throwing the error
    }
    hasSave = true;
    line = read.readLine();        // Reads the file for the current level
    currentLevel = int(line);      // Sets the current level
    line = read.readLine();        // Reads for the current deaths
    currentDeaths = int(line);     // Sets the current deaths
    line = read.readLine();        // Reads for the current time
    startElapsed = int(line);      // Sets the current time
    read.close();  
  }
  catch(IOException e) {
    // just doesnt do anything if there is an error
  }
  
  try {
    BufferedReader readBest = createReader("best.txt");
    if (readBest != null) {
      hasBestSave = true;
      bestDeaths = int(readBest.readLine());
      bestElapsed = int(readBest.readLine());
      readBest.close();
    } else {
      hasBestSave = false;
    }
  }
  catch(IOException e) {
    hasBestSave = false;
  }
  
}

void draw(){
  //frameRate(20);
  // Looping background music
  //if(!music.isPlaying()){
  //  music.play();
  //  music.amp(0.3);
  //}
  if(gameState.equals("Menu")){
    menuScreen();
  }
  else{
    if(gameState.equals("LEVEL 10")){
      Level_10();
    }
    else{
      // Calculate live running time if the game is active
      if (!isPaused) {
        elapsed = millis() - startTime + startElapsed;
      }
      // Draw the pause menu over everything if paused
      if(isPaused){
        image(savedFrame, 0, 0);
        drawPauseMenu();
      }
      else{
        background(12, 20, 28);
        drawLabBackground();
        Gravity();
        borders();
        applyWallStyle();
        if(shakeScreen){
          screenShake();
        }
        
        
        // Enemies
        if(Deepling != null){
          for(int i = 0; i < Deepling.length; i++){
            Deepling[i].move();
            Deepling[i].attack();
          }
        }
        if(Aspid != null){
          for(int i = 0; i < Aspid.length; i++){
            Aspid[i].exist();
          }
        }
        noStroke();
        // Run all the levels
        if(gameState.equals("LEVEL 1")){
          Level_1();
        }
        else if(gameState.equals("LEVEL 2")){
          Level_2();
        }
        else if(gameState.equals("LEVEL 3")){
          Level_3();
        }
        else if(gameState.equals("LEVEL 4")){
          Level_4();
        }
        else if(gameState.equals("LEVEL 5")){
          Level_5();
        }
        else if(gameState.equals("LEVEL 6")){
          Level_6();
        }
        else if(gameState.equals("LEVEL 7")){
          Level_7();
        }
        else if(gameState.equals("LEVEL 8")){
          Level_8();
        }
        else if(gameState.equals("LEVEL 9")){
          Level_9();
        }
        drawScientist();
        // The after image uses the same frame counting as the screen shaking but it needs to be drawn over the level
        if(shakeScreen){
          afterImage();
        }
        
        // Make sure the attack is drawn above the level
        if(Aspid != null){
          for(int i = 0; i < Aspid.length; i++){
            Aspid[i].attack();
          }
        }
        
        if(gameState.equals("LEVEL 1")){
          tutorial();
        }
        
        drawHUD();
        // make sure to draw the transition after everything else
        if(nextLevel){
          nextLevelTransition();
        }
      
      }
    }
  }
}


void menuScreen(){
  //startTime = millis();
  //gameState = "LEVEL 8";
  //currentLevel = 8;
  //levelSetup();
  background(10, 20, 35);
  drawMainMenu();
  
  if (showDataLog) {
    drawDataLog();
  }
}

void reset(){
  
  // Save the current player image to a different image variable
  if(touchingGround){
    if(lastClicked.equals("Right"))
      afterImage = walking[frame];
    else
      afterImage = walking[frame+3];
  } else {
    if(speedY > 3){
      if(lastClicked.equals("Right"))
        afterImage = falling[0];
      else
        afterImage = falling[1];
    } else {
      if(lastClicked.equals("Right"))
        afterImage = jumping[0];
      else
        afterImage = jumping[1];
    }
  }
  //frameCount = 0;
  // Death logic
  //damage.play();
  //damage.amp(5);
  currentDeaths++;
  shakeScreen = true;
  shakeEnd = frameCount + 10;
  afterImageX = SX;
  afterImageY = SY;
  levelSetup();
}

// Draws the invisible door collison and triggers the next level
void door(int x1, int x2, int y1, int y2){
  if(SX+100 >= x1 && SX <= x2 && SY+150 >= y1 && SY <= y2){
    nextLevel = true;
    //saveProgress();
  }
}

void saveProgress(){
  PrintWriter write = createWriter("save.txt");
  //elapsed = startElapsed + (pauseStartTime - startTime);
  write.println(currentLevel);
  write.println(currentDeaths);
  write.println(elapsed);
  //write.flush();  // this forces processing to save to the file
  write.close();
}

// IMPRTANT METHOD: sets the spawn for the enemies and the scientist for each level
void levelSetup(){
  switch(currentLevel){
    case 1:
      SY = 200;
      SX = 100;
      Aspid = new Aspid[0];
      Deepling = new Deepling[1];
      Deepling[0] = new Deepling(440, 700, 400, 1200);
      break;
    case 2:
      SY = 400;
      SX = 50;
      Deepling = new Deepling[0];
      Aspid = new Aspid[1];
      Aspid[0] = new Aspid(550, 90);
      break;
    case 3:
      SY = 600;
      SX = 20;
      Deepling = new Deepling[2];
      Deepling[0] = new Deepling(860, 300, 800, 900);  // patrols platform
      Deepling[1] = new Deepling(460, 300, 400, 600);  // patrols platform
      Aspid = new Aspid[1];
      Aspid[0] = new Aspid(1100, 0);                   // floats above everything and shoots
      break;
    case 4:
      SY = 600;
      SX = 20;
      Deepling = new Deepling[1];
      Deepling[0] = new Deepling(700, 650, 100, 1100);  // patrols the main floor
      Aspid = new Aspid[2];
      Aspid[0] = new Aspid(350, 100);                   // Floats above
      Aspid[1] = new Aspid(750, 100);
      break;
    case 5:
      SY = 600;
      SX = 20;
      Deepling = new Deepling[2];
      Deepling[0] = new Deepling(320, 455, 300, 450);  // patrols Platform A
      Deepling[1] = new Deepling(770, 455, 750, 900);  // patrols Platform C
      Aspid = new Aspid[2];
      Aspid[0] = new Aspid(300, 150);   // shoots from Platform D left
      Aspid[1] = new Aspid(900, 150);   // shoots from Platform D right
      break;
    case 6:
      SY = 0;
      SX = 0;
      Aspid = new Aspid[0];
      Deepling = new Deepling[4];
      Deepling[0] = new Deepling((int)random(600)+100, 50, 100, 700);  // patrols floor 1
      Deepling[1] = new Deepling((int)random(600)+100, 250, 100, 700);  // patrols floor 2
      Deepling[2] = new Deepling((int)random(600)+100, 450, 100, 700);  // patrols floor 3
      Deepling[3] = new Deepling((int)random(600)+100, 650, 100, 700);  // patrols floor 4
      break;
    case 7:
      SY = 600;
      SX = 20;
      Deepling = new Deepling[0];
      Aspid = new Aspid[5];
      for(int i = 0; i < 5; i++){
        Aspid[i] = new Aspid(i*180 + 100, 100);
      }
      break;
    case 8:
      SY = 100; // Starts the scientist on the top-left safe platform
      SX = 50;
      
      // A mix of both enemy types guarding the descent
      Deepling = new Deepling[2];
      Deepling[0] = new Deepling(350, 355, 50, 450);  // Patrols top platform
      Deepling[1] = new Deepling(750, 255, 700, 1150);  // Patrols right middle platform
      
      Aspid = new Aspid[2];
      Aspid[0] = new Aspid(800, 100);                  // Floats right in the central dropping gap
      Aspid[1] = new Aspid(125, 600);                  // Snipes from below the left ledge
      break;   
    case 9:
      SY = 650; // Start at the absolute bottom center
      SX = 20;
      acidY = 820; 
      Wall(0, 200, 300, 325); 
      // Ground enemies patrolling small floating stepping stones
      Deepling = new Deepling[3];
      Deepling[0] = new Deepling(750, 350, 700, 800);  // Patrolling Obstacle 4
      Deepling[1] = new Deepling(300, 300, 300, 500);  // Patrolling ceiling above the laser
      Deepling[2] = new Deepling(100, 200, 0, 200);    // Patrolling Obstacle 4
      
      // Flying enemies blocking the central vertical climbing path
      Aspid = new Aspid[2];
      Aspid[0] = new Aspid(550, 200);  // Floating directly above your start position
      Aspid[1] = new Aspid(200, 150);  // Floating near the final stretch
      break;
  }
}

void nextLevelTransition(){
  // Start by making the screen black
  if(phase == 0){
    Alpha += 20;
    fill(0, Alpha);
    rect(0, 0, width, height);
    if(Alpha >= 255){
      phase = 1;
    }
  }
  // Then go to the next level
  if (phase == 1){
    currentLevel++;
    saveProgress();
    gameState = "LEVEL "+ currentLevel;
    doorClosed = true;
    levelSetup();
    phase = 2;
    rect(0, 0, width, height);
  }
  // then fade out from the black back to the level
  if (phase == 2){
    Alpha -= 20;
    fill(0, Alpha);
    rect(0, 0, width, height);
    if(Alpha <= 0){
      nextLevel = false;
      phase = 0;
    }
  }
}

void drawScientist(){
  if(Right){
    moveRight();
  }
  else if(Left){
    moveLeft();
  }
  else{
    standing();
  }
}

// The following are movement functions for the scientist
void moveRight(){
  SX += 5;
    lastClicked = "Right";
    if(touchingGround){
      //if(!walk.isPlaying()){
      //  walk.play();
      //  walk.amp(0.2);
      //}
      image(walking[frame], SX, SY, 100, 150);
      nextFrame();
    }
    else{
      jumpingOrFalling(0);
    }
}

void moveLeft(){
  SX -= 5;
    lastClicked = "Left";
    if(touchingGround){
      //if(!walk.isPlaying()){
      //  walk.play();
      //  walk.amp(0.2);
      //}
      image(walking[frame+3], SX, SY, 100, 150);
      nextFrame();
    }
    else{
      jumpingOrFalling(1);
    }
}

void standing(){
  frame = 0;
    if(lastClicked.equals("Right")){
      if(touchingGround){
        image(standing[0], SX, SY, 100, 150);
      }
      else{
        jumpingOrFalling(0);
      }
    }
    else{
      if(touchingGround){
        image(standing[1], SX, SY, 100, 150);
      }
      else{
        jumpingOrFalling(1);
      }
    }
}

// Prevents the player from leaving the screen
void borders(){
  if(SX < 0){
    SX = 0;
  }
  if (SX+100 > width){
    SX = width-100;
  }
  if(SY < 0){
    SY = 0;
  }
  if(SY+150 > height){
    SY = height-150;
  }
  
  // this allows the player to be able to jump of the floor
  Wall(0, width, height, 801);
}


void jumpingOrFalling(int i){
  if(speedY >3){
    image(falling[i], SX, SY, 115, 150);
  }
  if(speedY <3){
    image(jumping[i], SX, SY, 100, 150);
  }
}

// handles which frame the scientists walking animation should be on
void nextFrame(){
  if(frameCount % 6 == 0){
    frame++;
  }
  if(frame == 3){
    frame = 0;
  }
}


void screenShake(){
  if(shakeEnd > frameCount){
    if(frameCount % 2 == 0){
      ranX = random(-5, 5);
      ranY = random(-5, 5);
      translate(ranX, ranY);
    }
    else{
      translate(ranX*-1, ranY*-1);
    }
  }
}

// Draws the red after image left behind after the player dies
void afterImage(){
  if(shakeEnd > frameCount){
    pushStyle();
    tint(255, 0, 0, 100);
    image(afterImage, afterImageX, afterImageY, 100, 150);
    popStyle();
  }
}



void keyPressed(){
  if (gameState.equals("LEVEL 1") && (keyCode == ENTER || keyCode == RETURN) && inTutorialRange()) {
    tutorialIndex++;
  }
  if(keyCode == RIGHT || key == 'd' || key == 'D'){
   Right = true;
  }
  if(keyCode == LEFT || key == 'a' || key == 'A'){
    Left = true;
  } 
  if(keyCode == UP || key == 'w' || key == 'W'){
    Up = true;
  }
  if(keyCode == DOWN || key == 's' || key == 'S'){
    Down = true;
  }
  if((keyCode == UP || key == 'w' || key == 'W') && touchingGround){
    speedY = -10;
    touchingGround = false;
  } 
  if((key == ' ' || key == 'z' || key == 'Z') && canBlink){
    blink();
    canBlink = false;
  } 
}

void keyReleased(){
  if(keyCode == RIGHT || key == 'd' || key == 'D'){
    Right = false;
  }
  if(keyCode == LEFT || key == 'a' || key == 'A'){
    Left = false;
  }
  if(keyCode == UP || key == 'w' || key == 'W'){
    Up = false;
  }
  if(keyCode == DOWN || key == 's' || key == 'S'){
    Down = false;
  }
}

void mousePressed(){
  if (gameState.equals("LEVEL 10")) {
    float btnY = escapeUiY + 310;         // 310 is btnY
    
    // Check if clicking the [MENU] button
    if (mouseX > 520 && mouseX < 680 && mouseY > btnY && mouseY < btnY + 50) {
      
      gameState = "Menu";
      // Reset the variables so it drops down again next time you beat the game
      escapeUiY = -600;     
      checkedRecords = false; 
      isNewBestDeaths = false;
      isNewBestTime = false;
      currentDeaths = 0;
      startElapsed = 0;
      hasSave = false;
    }
    //return; // Stop running other mouse checks
  }
  else if(gameState.equals("Menu")){
    
    if (showDataLog) {
      if (mouseX > 520 && mouseX < 680 && mouseY > 555 && mouseY < 605) {
        showDataLog = false;
      }
      return; // Absolute block: do not process any other clicks
    }
    
    // Check horizontal bounds first since all buttons share the same X area
    if (mouseX > 450 && mouseX < 750) {
      
      if(hasSave){
        // [Continue] button
        if (mouseY > 445 && mouseY < 515) {
          startTime = millis();
          gameState = "LEVEL "+ currentLevel;
          levelSetup();
        }
        // [New Game] button
        else if (mouseY > 535 && mouseY < 605) {
          startTime = millis();
          gameState = "LEVEL 1";
          currentDeaths = 0;
          elapsed = 0;
          startElapsed = 0;
          currentLevel = 1;
          tutorialIndex = 0;
          levelSetup();
        }
        // [Data Log] button
        else if (mouseY > 625 && mouseY < 695) {
          showDataLog = true;
        }
        // [Quit Game] button
        else if (mouseY > 715 && mouseY < 785) {
          exit();
        }
      }
      // No save
      else {
        // [New Game] button
        if (mouseY > 445 && mouseY < 515) {
          startTime = millis();
          gameState = "LEVEL 1";
          currentLevel = 1;
          tutorialIndex = 0;
          levelSetup();
        }
        // [Data Log] button
        else if (mouseY > 535 && mouseY < 605) {
          showDataLog = true;
        }
        // [Quit Game] button
        else if (mouseY > 625 && mouseY < 695) {
          exit();
        }
      }
      
    }
  }else {
    // Check for the pause button click
    if (!isPaused && mouseX > 1120 && mouseX < 1180 && mouseY > 10 && mouseY < 50) {
      savedFrame = get(); // TAKE SCREENSHOT
      pauseStartTime = millis(); // Save the exact time we paused
      isPaused = true;
    } 
    // If the game IS paused, check for the button clicks
    else if (isPaused) {
      
      if (mouseX > 450 && mouseX < 750) {
        if (mouseY > 315 && mouseY < 385) { // [Continue]
          isPaused = false;
          startTime += (millis() - pauseStartTime); // Fix the timer jump
        } 
        else if (mouseY > 415 && mouseY < 485) { // [Menu]
          startElapsed = elapsed;
          saveProgress();
          isPaused = false;
          gameState = "Menu";
          hasSave = true;
        } 
        else if (mouseY > 515 && mouseY < 585) { // [Quit]
          saveProgress();
          exit();
        }
      }
    }
  }
}
