void Gravity(){
  speedY += 0.5;
  SY += speedY;
}

// Draws a wall and handles all collisions
void Wall(int x1, int x2, int y1, int y2){
  rectMode(CORNERS);
  fill(0, 0, 10);
  noStroke();
  rect(x1, y1, x2, y2);
  // First check if the player teleported into the wall using the player's middle point
  if(checkCollision(50, 50, 75, 75, x1, x2, y1, y2)){
    reset();
  }
  // Check if inside the wall
  else if(checkCollision(100, 0, 150, 0, x1, x2, y1, y2)){
    // Check which side is closest to push the player to
    distX1 = SX+100-x1;
    distX2 = x2-SX;
    distY1 = SY+150-y1;
    distY2 = y2-SY;
    float[] array = {distX1, distX2, distY1, distY2};
    smallest = min(array);
    
    // Pushes the player to the closest side
    if(smallest == distY1){
      SY = y1 - 150;
      speedY = 0;
      canBlink = true;
      touchingGround = true;
    }
    else if(smallest == distY2){
      SY = y2;
      speedY = 0;
    }
    else if(smallest == distX1){
      SX = x1 - 100;
    }
    else if(smallest == distX2){
      SX = x2;
    }
  }
}


// Teleport mechanic checks for a enemy colliding and then increases the X or Y value
void blink(){
  //woosh.play();
  if(Up){
    checkKill(-20, 120, -20, 170);
    SY -= 150;
  }
  else if(Down){
    checkKill(-20, 120, -20, 170);
    SY += 150;
  }
  else if(lastClicked.equals("Right")){
    checkKill(-20, 170, -20, 170);
    SX += 150;
  }
  else if(lastClicked.equals("Left")){
    checkKill(-70, 120, -20, 170);
    SX -= 150;
  }
}



// Draws an acid which instantly vaporises the player
void Acid(int x1, int x2, int y1, int y2){
  rectMode(CORNERS);
  fill(100, 255, 100);
  rect(x1, y1, x2, y2);
  
  // dynamic rising acid particles
  strokeWeight(2);
  for (int i = x1; i < x2; i += 40) {
    // Uses frame offsets to generate small, organic spitting heat bubbles on the surface
    int bubbleY = (int)(y1 - ( (frameCount + i) % 15 )); 
    stroke(TOXIC_GREEN, 180 - ((frameCount + i) % 15) * 10); 
    line(i + ((frameCount) % 10), bubbleY, i + ((frameCount) % 10) + 4, bubbleY);
  }
  
  // Check if inside the acid then resets the player
  if(SX+100 >= x1 && SX <= x2 && SY+150 >= y1 && SY <= y2){
    reset();
  }
}

// Draws a laser which instantly vaporises the player
void Laser(int x1, int x2, int y1, int y2){
  rectMode(CORNERS);
  fill(255, 0, 0);
  rect(x1, y1, x2, y2);
  
  // Check if inside the laser then resets the player
  if(SX+70 >= x1 && SX+30 <= x2 && SY+150 >= y1 && SY <= y2){
    reset();
  }
}

// Checks if the teleport hitbox collides with any of the enemy hitboxes
void checkKill(int x1, int x2, int y1,int y2){
  //rect(SX-x1, SY-y1, SX+x2, SY+y2);
    try{
      for(int i = 0; i < Deepling.length; i++){
        Deepling[i].die(SX+x1, SX+x2, SY+y1, SY+y2);
      }
    } catch(Exception e){
      
    }
    try{
      for(int i = 0; i < Aspid.length; i++){
        Aspid[i].die(SX+x1, SX+x2, SY+y1, SY+y2);
      }
    } catch(Exception e){
      
    }
}

// Simplifies the amount of code needed per level by putting all the door logic in a function
void doorLogic(int x1, int x2, int y1,int y2){
  updateDoor();
  if(doorClosed){
    applyWallStyle();
    Wall(x1, x2, y1, y2);
  }
  else{
    drawExitSign(x1, y1, x2-x1, y2-y1);
    door(x1, x2, y1, y2);
  }
}


boolean checkCollision(int bx1, int bx2, int by1, int by2, int x1, int x2, int y1,int y2){
  if(SX+bx1 >= x1 && SX+bx2 <= x2 && SY+by1 >= y1 && SY+by2 <= y2){
    return(true);
  }
  else{
  return(false);
  }
}
