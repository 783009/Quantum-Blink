void Level_6(){
  //Right edge wall
  Wall(0, 100, 150, 800); 
  //Left edge wall
  Wall(1100, 1200, 0, 600);
  
  // blocking wall to stop instant deaths on respawn
  Wall(100, 110, 0, 150);
  
  //Platform 1
  Wall(100, 1100, 150, 200);
  //Platform 2
  Wall(100, 1100, 350, 400);
  //Platform 3
  Wall(100, 1100, 550, 600);
  //Platform 4
  Wall(100, 1200, 750, 800);
  
  drawMapForegroundLevel6();
  
  //Lasers
  Laser((int)(475*sin(frameCount/40.0) + 590), (int)(475*sin(frameCount/40.0) + 610), 0, 750);
  Laser(100, 1100, (int)(300*sin(frameCount/65.0) + 460), (int)(300*sin(frameCount/65.0) + 480));
  
  // Door
  doorLogic(1100, 1200, 600, 750);
}
