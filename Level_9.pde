void Level_9() {
  // Starting platform
  Wall(0, 200, 750, 800);     
  
  // Obstacle 1 platform and ceiling
  Wall(300, 500, 700, 750);  // Floor
  Wall(300, 500, 400, 550);  // Ceiling that also holds crawling enemy 2 above it
  
  // Obstacle 4 platfrom that has crawling enemy 1
  Wall(700, 820, 440, 465);
  
  // Obstacle 5 platfrom that has crawling enemy 3
  Wall(0, 200, 300, 325);
  
  // Door platform
  Wall(750, 1000, 180, 200);
  
  // Big side wall
  Wall(1000, 1200, 0, 300);
  
  // Wall above door
  Wall(900, 1000, 0, 30);

  // Render all platform grids and tech aesthetics first
  drawMapForegroundLevel9();
  
  // Obstacle 1 laser
  Laser((int)(80 * sin(frameCount / 35.0) + 390), (int)(80 * sin(frameCount / 35.0) + 410), 550, 700);
  
  // Obstacle 2 horizontally moving platform
  Wall((int)(180*sin(frameCount/20.0) + 700), (int)(180*sin(frameCount/20.0) + 900), 675, 700);
  
  // Obstacle 3 virtically moving platform  
  Wall(1000, 1200, (int)(120 * cos(frameCount / 20.0) + 650), (int)(120 * cos(frameCount / 20.0) + 680)); // the one closest to the door 
  
  // Door placed high up on the right wall
  doorLogic(900, 1000, 30, 180); 
  
  // Acid level increaser
  if (!isPaused) {
    acidY -= 0.5; 
  }
  
  noStroke();
  // Render
  Acid(0, 1200, (int)acidY, 800);
}
