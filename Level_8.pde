void Level_8(){
  // Walls
  Wall(0, 50, 0, 800);        // Left edge wall
  Wall(1150, 1200, 0, 650);     // Right edge wall above exit
  
  // Big central dividing pillar
  Wall(300, 500, 0, 200);       
  
  // Platforms
  Wall(50, 500, 200, 250);      // Spawn floor
  Wall(700, 1150, 350, 400);    // Platform below the bigger laser
  Wall(50, 450, 450, 500);      // Platform below the smaller laser
  Wall(900, 1200, 700, 800);    // Exit door platform

  drawMapForegroundLevel8();
  
  // Big laser
  Laser((int)(180 * sin(frameCount / 30.0) + 910), (int)(180 * sin(frameCount / 30.0) + 940), 0, 350);
  
  // Smaller laser
  Laser((int)(160 * sin(frameCount / 35.0) + 240), (int)(160 * sin(frameCount / 35.0) + 270), 250, 450);

  // Virticaly moving platforms
  Wall(600, 750, (int)(120 * sin(frameCount / 20.0) + 650), (int)(120 * sin(frameCount / 20.0) + 680)); // the one closest to the door 
  Wall(350, 500, (int)(50 * sin(frameCount / 20.0) + 750), (int)(50 * sin(frameCount / 20.0) + 780)); // the one second closest to the door 
  Wall(100, 250, (int)(50 * sin(frameCount / 20.0 +400) + 750), (int)(50 * sin(frameCount / 20.0 +400) + 780)); // the one farthest from the door 
  
  //Acid Floor
  Acid(50, 900, 760, 800);
  // Wall above door
  Wall(1100, 1200, 400, 550);
  // Door
  doorLogic(1100, 1200, 550, 700);
}
