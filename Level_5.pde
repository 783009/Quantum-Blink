void Level_5(){
  Wall(0, 150, 0, 300);          // Left wall

  // Right wall
  Wall(1050, 1200, 0, 300);      // Top right wall
  Wall(1050, 1200, 550, 800);    // Bottom right wall

  // Mid platforms
  Wall(300, 450, 550, 600);      // Platform A (low-left)
  Wall(550, 650, 470, 520);      // Platform B (mid)
  Wall(750, 900, 550, 600);      // Platform C (low-right)

  // Acid floor
  Acid(150, 1050, 750, 800);
  Wall(0, 150, 700, 800);        // Safe floor under spawn only
  Wall(1050, 1200, 700, 800);    // Safe floor under exit only
  
  
  // Moving platform
  Wall((int)(250*sin(frameCount/20.0) + 520), (int)(250*sin(frameCount/20.0) + 680), 250, 300);

  drawMapForegroundLevel5();
  
  Laser((int)(400*sin(frameCount/80.0) + 590), (int)(400*sin(frameCount/80.0) + 610), 0, 750);
  
  
  // Door
  doorLogic(1050, 1200, 300, 550);
}
