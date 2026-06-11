void Level_4(){
  Wall(0, 1200, 750, 800);  // Floor
  Wall(0, 100, 0, 600);     // Edge wall above entrance
  Wall(1100, 1200, 0, 500); // Edge wall above the exit door
  Wall(300, 500, 500, 550); // Platform 1
  Wall(700, 900, 500, 550); // Platform 2
  Wall(300, 500, 300, 350); // Platform 3
  Wall(700, 900, 300, 350); // Platform 4
  
  drawMapForegroundLevel4();
  
  Laser((int)(400*sin(frameCount/60.0)+590), (int)(400*sin(frameCount/60.0)+610), 0, 750);
  
  
  doorLogic(1100, 1200, 500, 750);
}
