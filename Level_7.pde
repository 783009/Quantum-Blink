void Level_7(){
  //Right edge wall
  Wall(0, 50, 0, 600);
  
  // Left edge wall
  Wall(1100, 1200, 200, 800);
  // Wall above door
  Wall(1100, 1200, 0, 50);
  
  
  //Acid floor
  Acid(200, 1100, 775, 800);
  
  //Starting platform
  Wall(0, 200, 750, 800);
  
  // Fast moving platform - only safe crossing over acid mid-level
  for(int i = 0; i < 5; i++){
    Wall(i*180 + 200, i*180 + 280, (int)(250*sin(frameCount/30.0 + i*500) + 410), (int)(250*sin(frameCount/30.0 + i*500) + 440));
  }
  
  drawMapForegroundLevel7();
  
  // Door
  doorLogic(1100, 1200, 50, 200);
}
