class DeeplingClass{
  // variables that belong to THIS deepling
  float DX, DY;
  int targetX1, targetX2, frame;
  boolean dRight, dead;

  DeeplingClass(int startX, int startY, int targetX1, int targetX2) {
    this.targetX1 = targetX1;
    this.targetX2 = targetX2;
    DX = startX;
    DY = startY;
  }
  
  // Moves the crawling enemy and flips his direction if he reaches the targetX1 or targetX2
  void move() {
    if (!dead) {
      doorClosed = true;
      //if (!crawl.isPlaying()) {
      //  crawl.play();
      //}
      //rect(DX+20, DY+30, DX+60, DY+90);
      if (dRight) {
        DX += 1;
        if (DX+80 >= targetX2){
          dRight = false;
        }
        image(deepling[frame+2], DX, DY, 80, 100);
      } else {
        DX -= 1;
        if (DX <= targetX1){
          dRight = true;
        }
        image(deepling[frame], DX, DY, 80, 100);
      }
      if (frameCount % 4 == 0){
        frame++;
      }
      if (frame == 2){
        frame = 0;
      }
    }
  }
  
  // Checks if the enemy is dead
  void die(float x1, float x2, float y1, float y2) {
    if (DX+40 >= x1 && DX+40 <= x2 && DY+50 >= y1 && DY+50 <= y2 && !dead) {
      //hit.play();
      //hit.amp(5);
      dead = true;
      doorClosed = false;
    }
  }
  
  // Checks if the enemy is touching the scientists then resets the scientist
  void attack() {
    if (!dead) {
      //rect(DX+20, DY+30, DX+60, DY+90);
      float x1 = DX+20;
      float x2 = DX+60;
      float y1 = DY+30;
      float y2 = DY+90;
      if (SX+70 >= x1 && SX+30 <= x2 && SY+150 >= y1 && SY <= y2) {
        reset();
      }
    }
  }
}

class Aspid {
  // variables that belong to THIS aspid class
  int frame, AX, AY;
  boolean aRight, dead, ballActive;
  float speedX[] = new float[3];
  float speedY[] = new float[3];
  float projectileSpeed = 7.0; 
  float ballX[] = new float[3];
  float ballY[] = new float[3];
  float deltaX[] = new float[3];
  float deltaY[] = new float[3];
  float angle[] = new float[3];
  
  
  Aspid(int startX, int startY) {
    AX = startX;
    AY = startY;
  }
  
  void exist(){
    if(!dead){
      //if (!fly.isPlaying()) {
      //  fly.play();
      //}
      
      // Aspid hitbox that kills the player
      if (SX+70 >= AX+15 && SX+30 <= AX+40 && SY+150 >= AY+40 && SY <= AY+100) {
        reset(); //kills the player
      }
      // Aspid hitbox visual
      //rect(AX+15, AY+40, AX+75, AY+100);
      
      doorClosed = true;
      
      // facing direction for the images  and the animations
      if (SX > AX) {
        aRight = true;
        image(aspid[frame+2], AX, AY, 96, 120);
      } else {
        aRight = false;
        image(aspid[frame], AX, AY, 96, 120);
      }
      
      // Animation logic
      if (frameCount % 2 == 0) {
        frame++;
      }
      if (frame == 2) {
        frame = 0;
      }
    }
  }
  void attack(){
    if (!dead){
      // every 200 frames shoot LAVA
      if (frameCount % 200 == 0) {
        //spit.play();
        
        // Spawn from the middle of the Aspid sprite
        for(int i = 0; i<3; i++){
          ballX[i] = AX + 48;
          ballY[i] = AY + 60;
        }
        // ball path
        deltaX[0] = SX+50 - ballX[0];
        deltaY[0] = SY+75 - ballY[0];
        
        
        // Calculate the trajectory angle
        angle[0] = atan2(deltaY[0], deltaX[0]);
        angle[1] = angle[0]-radians(20);
        angle[2] = angle[0]+radians(20);
        
        // Convert the angle into speed
        for(int i = 0; i < 3; i++){
          speedX[i] = cos(angle[i]) * projectileSpeed;
          speedY[i] = sin(angle[i]) * projectileSpeed;
        }
        ballActive = true;
      }
    }
    
    // Lava ball movement happens even if dead
    if(ballActive) {
      fill(255, 150, 0);
      noStroke();
      for(int i = 0; i < 3; i++){
        ballX[i] += speedX[i];
        ballY[i] += speedY[i];
        circle(ballX[i], ballY[i], 30);
        if(dist(ballX[i], ballY[i], SX+50, SY+75) < 50){
          reset();
        }
      }
    }
  }
  
  // checks if the aspid has been zapped and kills it
  void die(float x1, float x2, float y1, float y2){
    // Some testing hitbox visuals
    //rect(AX+15, AY+40, AX+75, AY+100);
    //rect(SX+30, SY,SX+70, SY+150);
    //circle(AX+48, AY+60, 10);
    
    if (AX+48 >= x1 && AX+48 <= x2 && AY+60 >= y1 && AY+60 <= y2 && !dead) {
      //hit.play();
      //hit.amp(5);
      dead = true;
      doorClosed = false;
    }
  }
}

// Makes sure the door doesnt flicker open whenever the player kills an enemy by checking if all the enemies are dead
void updateDoor(){
  boolean allDead = true;
  if(Deepling != null){
    for(int i = 0; i < Deepling.length; i++){
      if(!Deepling[i].dead) allDead = false;
    }
  }
  if(Aspid != null){
    for(int i = 0; i < Aspid.length; i++){
      if(!Aspid[i].dead) allDead = false;
    }
  }
  doorClosed = !allDead;
}
