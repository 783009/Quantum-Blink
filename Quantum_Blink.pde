/* @pjs preload="data/Menu.png, data/Logo.png, data/MenuBackgroundAsset.png, data/Standing.png, data/Walking_1.png, data/Walking_2.png, data/Walking_3.png, data/Jumping.png, data/Falling.png, data/Aspid_1.png, data/Aspid_2.png, data/Deepling_1.png, data/Deepling_2.png, data/StandingF.png, data/Walking_1F.png, data/Walking_2F.png, data/Walking_3F.png, data/JumpingF.png, data/FallingF.png, data/Aspid_1F.png, data/Aspid_2F.png, data/Deepling_1F.png, data/Deepling_2F.png, data/dash.png, data/YouEscaped.png"; */
/*
  Authors: Almir Meridu & Mohamed Lahkim
  Date: June, 2, 2026
  Title: Quantum Blink
  Description: A scientist is going through a contaminated lab trying to find the source of the infection and eradicate it.
  The scientist is equipped with a short-range teleporter that he uses to phase through walls and eliminate enemies.
*/

//import processing.sound.*;

// Define the sound variables
Object woosh, hit, crawl, damage, walk, spit, fly, wall, music;

// Define the image variables
PImage Menu, logo, MenuAsset, savedFrame, Escaped;
PImage standing[] = new PImage[2];
PImage jumping[] = new PImage[2];
PImage falling[] = new PImage[2];
PImage aspid[] = new PImage[4];
PImage deepling[] = new PImage[4];
PImage walking[] = new PImage[6];
PImage afterImage, dash;
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

int speedX, currentDeaths, startTime, elapsed, shakeEnd, Alpha, phase, startElapsed, pauseStartTime, bestDeaths, bestElapsed;
float speedY, distX1, distX2, distY1, distY2, smallest, ranX, ranY, afterImageX, afterImageY, acidY;

int currentLevel = 1;
int frame = 0;
float SX, SY;

// Creates an array version of the enemy variable classes
DeeplingClass[] Deepling;
AspidClass[] Aspid;



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
  Menu = loadImage("data/Menu.png");
  logo = loadImage("data/Logo.png");
  MenuAsset = loadImage("data/MenuBackgroundAsset.png");
  standing[0] = loadImage("data/Standing.png");
  walking[0] = loadImage("data/Walking_1.png");
  walking[1] = loadImage("data/Walking_2.png");
  walking[2] = loadImage("data/Walking_3.png");
  jumping[0] = loadImage("data/Jumping.png");
  falling[0] = loadImage("data/Falling.png");
  aspid[0] = loadImage("data/Aspid_1.png");
  aspid[1] = loadImage("data/Aspid_2.png");
  deepling[0] = loadImage("data/Deepling_1.png");
  deepling[1] = loadImage("data/Deepling_2.png");
  standing[1] = loadImage("data/StandingF.png");
  walking[3] = loadImage("data/Walking_1F.png");
  walking[4] = loadImage("data/Walking_2F.png");
  walking[5] = loadImage("data/Walking_3F.png");
  jumping[1] = loadImage("data/JumpingF.png");
  falling[1] = loadImage("data/FallingF.png");
  aspid[2] = loadImage("data/Aspid_1F.png");
  aspid[3] = loadImage("data/Aspid_2F.png");
  deepling[2] = loadImage("data/Deepling_1F.png");
  deepling[3] = loadImage("data/Deepling_2F.png");
  dash = loadImage("data/dash.png");
  Escaped = loadImage("data/YouEscaped.png");
  
  
  // --- CLEAN, LIGHTWEIGHT WEB AUDIO LOAD ---
  woosh  = window.eval("new Audio('data/enderman.wav')");
  hit    = window.eval("new Audio('data/enemy damage.wav')");
  crawl  = window.eval("new Audio('data/spider mini run loop.wav')");
  damage = window.eval("new Audio('data/damage.wav')");
  walk   = window.eval("new Audio('data/Walk.wav')");
  fly    = window.eval("new Audio('data/fly.wav')");
  spit   = window.eval("new Audio('data/spit.wav')");
  wall   = window.eval("new Audio('data/false knight.wav')");
  music  = window.eval("new Audio('data/background-Sci-Fi.mp3')");
	
  
  Font = createFont("Font.ttf", 32);
  textFont(Font);
  
  SX = 400;
  SY = 200;


  // --- WEB LOCAL STORAGE LOAD SYSTEM ---
  String savedLevel = localStorage.getItem("qb_currentLevel");
  String savedDeaths = localStorage.getItem("qb_currentDeaths");
  String savedElapsed = localStorage.getItem("qb_elapsed");

  if (savedLevel != null && savedDeaths != null && savedElapsed != null) {
    hasSave = true;
    currentLevel = int(savedLevel);
    currentDeaths = int(savedDeaths);
    startElapsed = int(savedElapsed);
    elapsed = startElapsed; // Sync the live elapsed counter immediately
  } else {
    hasSave = false;
    currentLevel = 1;
    currentDeaths = 0;
    startElapsed = 0;
    elapsed = 0;
  }
  
  String savedBestDeaths = localStorage.getItem("qb_bestDeaths");
  String savedBestElapsed = localStorage.getItem("qb_bestElapsed");

  if (savedBestDeaths != null && savedBestElapsed != null) {
    hasBestSave = true;
    bestDeaths = int(savedBestDeaths);
    bestElapsed = int(savedBestElapsed);
  } else {
    hasBestSave = false;
  }
}

void draw(){
  //frameRate(20);
  // Looping background music
  if (frameCount == 1) {
    loopSound(music); 
  }
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
          drawAfterImage();
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
  playSound(damage);
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
  // Using "" + variable automatically forces the numbers into pure text strings
  localStorage.setItem("qb_currentLevel", "" + currentLevel);
  localStorage.setItem("qb_currentDeaths", "" + currentDeaths);
  localStorage.setItem("qb_elapsed", "" + elapsed);
}

// IMPRTANT METHOD: sets the spawn for the enemies and the scientist for each level
void levelSetup(){
  switch(currentLevel){
    case 1:
      SY = 200;
      SX = 100;
      Aspid = new AspidClass[0];
      Deepling = new DeeplingClass[1];
      Deepling[0] = new DeeplingClass(440, 700, 400, 1200);
      break;
    case 2:
      SY = 400;
      SX = 50;
      Deepling = new DeeplingClass[0];
      Aspid = new AspidClass[1];
      Aspid[0] = new AspidClass(550, 90);
      break;
    case 3:
      SY = 600;
      SX = 20;
      Deepling = new DeeplingClass[2];
      Deepling[0] = new DeeplingClass(860, 300, 800, 900);  // patrols platform
      Deepling[1] = new DeeplingClass(460, 300, 400, 600);  // patrols platform
      Aspid = new AspidClass[1];
      Aspid[0] = new AspidClass(1100, 0);                   // floats above everything and shoots
      break;
    case 4:
      SY = 600;
      SX = 20;
      Deepling = new DeeplingClass[1];
      Deepling[0] = new DeeplingClass(700, 650, 100, 1100);  // patrols the main floor
      Aspid = new AspidClass[2];
      Aspid[0] = new AspidClass(350, 100);                   // Floats above
      Aspid[1] = new AspidClass(750, 100);
      break;
    case 5:
      SY = 600;
      SX = 20;
      Deepling = new DeeplingClass[2];
      Deepling[0] = new DeeplingClass(320, 455, 300, 450);  // patrols Platform A
      Deepling[1] = new DeeplingClass(770, 455, 750, 900);  // patrols Platform C
      Aspid = new AspidClass[2];
      Aspid[0] = new AspidClass(300, 150);   // shoots from Platform D left
      Aspid[1] = new AspidClass(900, 150);   // shoots from Platform D right
      break;
    case 6:
      SY = 0;
      SX = 0;
      Aspid = new AspidClass[0];
      Deepling = new DeeplingClass[4];
      Deepling[0] = new DeeplingClass((int)random(600)+100, 50, 100, 700);  // patrols floor 1
      Deepling[1] = new DeeplingClass((int)random(600)+100, 250, 100, 700);  // patrols floor 2
      Deepling[2] = new DeeplingClass((int)random(600)+100, 450, 100, 700);  // patrols floor 3
      Deepling[3] = new DeeplingClass((int)random(600)+100, 650, 100, 700);  // patrols floor 4
      break;
    case 7:
      SY = 600;
      SX = 20;
      Deepling = new DeeplingClass[0];
      Aspid = new AspidClass[5];
      for(int i = 0; i < 5; i++){
        Aspid[i] = new AspidClass(i*180 + 100, 100);
      }
      break;
    case 8:
      SY = 100; // Starts the scientist on the top-left safe platform
      SX = 50;
      
      // A mix of both enemy types guarding the descent
      Deepling = new DeeplingClass[2];
      Deepling[0] = new DeeplingClass(350, 355, 50, 450);  // Patrols top platform
      Deepling[1] = new DeeplingClass(750, 255, 700, 1150);  // Patrols right middle platform
      
      Aspid = new AspidClass[2];
      Aspid[0] = new AspidClass(800, 100);                  // Floats right in the central dropping gap
      Aspid[1] = new AspidClass(125, 600);                  // Snipes from below the left ledge
      break;   
    case 9:
      SY = 650; // Start at the absolute bottom center
      SX = 20;
      acidY = 820; 
      Wall(0, 200, 300, 325); 
      // Ground enemies patrolling small floating stepping stones
      Deepling = new DeeplingClass[3];
      Deepling[0] = new DeeplingClass(750, 350, 700, 800);  // Patrolling Obstacle 4
      Deepling[1] = new DeeplingClass(300, 300, 300, 500);  // Patrolling ceiling above the laser
      Deepling[2] = new DeeplingClass(100, 200, 0, 200);    // Patrolling Obstacle 4
      
      // Flying enemies blocking the central vertical climbing path
      Aspid = new AspidClass[2];
      Aspid[0] = new AspidClass(550, 200);  // Floating directly above your start position
      Aspid[1] = new AspidClass(200, 150);  // Floating near the final stretch
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
    drawStanding();
  }
}

// The following are movement functions for the scientist
void moveRight(){
  SX += 5;
    lastClicked = "Right";
    if(touchingGround){
      if (!isSoundPlaying(walk)) {
        loopSoundClean(walk);
      }
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
      if (!isSoundPlaying(walk)) {
        loopSoundClean(walk);
      }
      image(walking[frame+3], SX, SY, 100, 150);
      nextFrame();
    }
    else{
      jumpingOrFalling(1);
    }
}

void drawStanding(){
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
void drawAfterImage(){
  if(shakeEnd > frameCount){
    pushStyle();
    tint(255, 0, 0, 100);
    image(afterImage, afterImageX, afterImageY, 100, 150);
    popStyle();
  }
}






// --- FIX: ULTRA-STABLE NATIVE WEB AUDIO HELPERS ---
void playSound(Object sound) {
  if (sound != null) {
    // We bind a native anonymous execution directly to the object pipeline
    window.setTimeout(new Runnable() {
      public void run() {
        window.eval("arguments[0].currentTime = 0; arguments[0].play();");
      }
    }, 0);
  }
}

void loopSound(Object sound) {
  if (sound != null) {
    // Forces the native HTML5 property to true and fires the audio stream
    window.setTimeout(new Runnable() {
      public void run() {
        window.eval("arguments[0].loop = true; arguments[0].play();");
      }
    }, 0);
  }
}

void loopSoundClean(Object sound) {
  if (sound != null) {
    window.setTimeout(new Runnable() {
      public void run() {
        window.eval("arguments[0].loop = true; arguments[0].play();");
      }
    }, 0);
  }
}

void stopSound(Object sound) {
  if (sound != null) {
    window.setTimeout(new Runnable() {
      public void run() {
        window.eval("arguments[0].pause(); arguments[0].currentTime = 0;");
      }
    }, 0);
  }
}

boolean isSoundPlaying(Object sound) {
  if (sound == null) return false;
  
  // Directly reads the boolean property without string concatenation
  Object state = window.eval("!(arguments[0].paused);");
  return boolean("" + state);
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
