void Level_1(){
  Wall(0, 400, 400, 800);
  Wall(350, 400, 0, 400);
  Wall(600, 800, 0, 600);
  Wall(800, 1200, 550, 600);
  Wall(1100, 1200, 0, 375);
  
  drawMapForegroundLevel1();
  
  doorLogic(1100, 1200, 375, 550);
}

void tutorial() {
  pushStyle();   
  
  // Text box
  rectMode(CORNER);
  fill(12, 22, 36, 240);       // Deep space dark blue backdrop (High contrast matching the walls)
  stroke(0, 240, 255);         // Vibrant Neon Cyan outline
  strokeWeight(3);
  if(inTutorialRange()){
    rect(150, 75, 900, 125, 15);
  }
  else{
    rect(150, 75, 900, 80, 15);
  }
  // 3. Render the main dialogue lines with a clean internal padding wrapper
  textAlign(CENTER, TOP);
  fill(255);
  textSize(22);
  
  // Writing the tutorial text and specifying the bounds
  text(tutorialLines[tutorialIndex], 180, 95, 840, 100); 

  // Press [ENTER] text
  textAlign(CENTER, CENTER);
  fill(100, 255, 100);         // Vibrant Toxic Green matching the acid floor
  textSize(14);
  if(inTutorialRange()){
    text("Press [ENTER] to continue", 600, 175);
  }
  
  popStyle();
}

boolean inTutorialRange(){
  if(tutorialIndex != tutorialLines.length - 1){
    return true;
  }
  return false;
}
