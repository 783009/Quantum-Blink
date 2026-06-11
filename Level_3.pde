void Level_3(){
  Acid(200, 1200, 775, 800);
  Wall(0, 200, 750, 800); //Starting floor
  Wall((int)(200*sin(frameCount/30.0)+500), (int)(200*sin(frameCount/30.0)+700), 750, 800); // lowest moving plat
  Wall((int)(50*sin(frameCount/10.0)+800), (int)(50*sin(frameCount/10.0)+900), 450, 500); // Middle moving plat #1
  Wall(1000, 1200, 670, 720); //Right edge wall
  Wall(800, 900, 400, 450);
  Wall(400, 600, 400, 450);
  Wall(950, 1050, 200, 250);
  
  // Door surrounding walls
  Wall(0, 100, 400, 450);
  Wall(0, 100, 0, 250);
  
  drawMapForegroundLevel3();
  
  doorLogic(0, 100, 250, 400);
}
