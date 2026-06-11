void Level_2(){
  Wall(0, 100, 0, 400);        //Top left
  Wall(100, 300, 350, 400);    //Top left platform
  Wall(0, 200, 600, 650);      //Bottom Left platform
  Wall(0, 100, 650, 800);      //Bottom left base
  
  Wall(1100, 1200, 0, 400);    //Top right
  Wall(900, 1100, 350, 400);   //Top right platform
  Wall(1100, 1200, 650, 800);  //Bottom right base
  
  // Moving platforms
  Wall((int)(200*sin(frameCount/30.0)+500), (int)(200*sin(frameCount/30.0)+700), 350, 400);
  Wall((int)(350*sin(frameCount/30.0)+550), (int)(350*sin(frameCount/30.0)+750), 600, 650);
  
  drawMapForegroundLevel2();

  Acid(100, 1100, 700, 800);
  
  doorLogic(1100, 1200, 400, 650);
}
