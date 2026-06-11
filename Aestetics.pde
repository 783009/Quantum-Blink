

//Main Menu Screen
void drawMainMenu() {
  if (MenuAsset != null) {
    image(MenuAsset, 0, 0, width, height);
  } else {
    background(10, 24, 42); // Fallback changed to a dark sci-fi blue
  }
  
  textAlign(CENTER, CENTER);
  
  if (logo != null) {
    imageMode(CENTER);
    image(logo, width / 2, 230, 400, 400);
    imageMode(CORNER);
  } else {
    textSize(75);
    fill(10, 20, 30); 
    text("QUANTUM BLINK", (width / 2) + 4, 230 + 4);
    fill(NEON_CYAN);
    text("QUANTUM BLINK", width / 2, 230);
  }
  if(hasSave){
    drawMenuButton(width / 2, 480, "[Continue]");
    drawMenuButton(width / 2, 570, "[New Game]");
    drawMenuButton(width / 2, 660, "[Data Log]");
    drawMenuButton(width / 2, 750, "[Quit Game]");
  }
  else{
    drawMenuButton(width / 2, 480, "[New Game]");
    drawMenuButton(width / 2, 570, "[Data Log]");
    drawMenuButton(width / 2, 660, "[Quit Game]");
  }
}

void drawMenuButton(int x, int y, String label) {
  rectMode(CENTER);
  
  boolean isHovering = (mouseX > x - 150 && mouseX < x + 150 && mouseY > y - 35 && mouseY < y + 35);
  
  if (isHovering) {
    fill(0, 150, 180, 180); 
    stroke(NEON_CYAN);
  } else {
    fill(WALL_DARK_BLUE);   
    stroke(0, 150, 180);    
  }
  
  strokeWeight(3);
  rect(x, y, 300, 70, 10);
  
  textAlign(CENTER, CENTER);
  textSize(32);
  if (isHovering) {
    fill(255); 
  } else {
    fill(NEON_CYAN); 
  }
  text(label, x, y - 5);
  
  rectMode(CORNER); 
}


//Core Background
void applyWallStyle() {
  fill(WALL_DARK_BLUE);
  stroke(NEON_CYAN);
  strokeWeight(3);
}

void drawLabBackground() {
  rectMode(CORNERS);
  
  //Background Grid Lines 
  stroke(GRID_DARK);
  strokeWeight(1);
  for (int i = 0; i < width; i = i + 40) {
    line(i, 0, i, height); // Vertical lines
  }
  for (int j = 0; j < height; j = j + 40) {
    line(0, j, width, j);  // Horizontal lines
  }
  
  //Large Liquid Tube Tanks 
  noStroke();
  // Right Tank Outer Glass & Liquid
  fill(NEON_CYAN, 15);
  rect(920, 80, 1040, 520);
  fill(0, 200, 180, 40);
  rect(930, 100, 1030, 500);
  
  //Left Tank Outer Glass and Liquid
  fill(NEON_CYAN, 15);
  rect(160, 50, 260, 360);
  fill(0, 200, 180, 40);
  rect(170, 70, 250, 340);
  
  // Floating Fluid Bubbles 
  fill(200, 255, 250, 120);
  
  //Right Tank Bubbles 
  float rightBubble1 = 500 - (frameCount % 400);
  float rightBubble2 = 500 - ((frameCount + 200) % 400);
  if (rightBubble1 > 100) ellipse(980, rightBubble1, 6, 6);
  if (rightBubble2 > 100) ellipse(1005, rightBubble2, 5, 5);
  
  //Left Tank Bubbles 
  float leftBubble1 = 340 - (frameCount % 270);
  float leftBubble2 = 340 - ((frameCount + 130) % 270);
  if (leftBubble1 > 70) ellipse(210, leftBubble1, 5, 5);
  if (leftBubble2 > 70) ellipse(235, leftBubble2, 6, 6);
  
  //Metal Caps on the Tanks 
  fill(40, 52, 68);
  rect(925, 80, 1035, 105);   // Right top cap
  rect(925, 495, 1035, 520);  // Right bottom cap
  rect(165, 50, 255, 75);     // Left top cap
  rect(165, 335, 255, 360);   // Left bottom cap

  //Background Ceiling Lines
  stroke(32, 45, 60);
  strokeWeight(12);
  line(0, 30, width, 30); 
  strokeWeight(6);
  line(520, 30, 520, 250); 
  
  //Background Wires 
  noFill();
  stroke(45, 75, 60); 
  strokeWeight(3);
  // Wire 1: Dips down in the middle
  line(0, 40, 400, 110);    
  line(400, 110, 800, 60);  
  // Wire 2: Dips down right
  line(400, 30, 800, 130);   
  line(800, 130, width, 40);  
  
  
  rectMode(CORNER);
}

void drawExitSign(int x, int y, int w, int h) {
  rectMode(CORNER);
  
  fill(15, 22, 30);
  stroke(NEON_CYAN);
  strokeWeight(3);
  rect(x, y, w, h);
  
  // Screen Blinking Effect 
  if (frameCount % 40 < 20) {
    fill(0, 180, 230, 70); 
  } else {
    fill(0, 180, 230, 20); 
  }
  noStroke();
  rect(x + 6, y + 6, w - 12, h - 12);
  
  // Moving Scanline
  stroke(NEON_CYAN, 180);
  strokeWeight(2);
  int scanLineY = y + 6 + (frameCount % (h - 16));
  line(x + 10, scanLineY, x + w - 10, scanLineY);
  
  textAlign(CENTER, CENTER);
  textSize(18);
  fill(10, 20, 30);
  text("EXIT", x + (w / 2) + 1, y + (h / 2) + 1); // Shadow
  fill(HAZARD_ORANGE);
  text("EXIT", x + (w / 2), y + (h / 2));         // Main text
}

void drawMapForegroundLevel1() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  //Hazard Caution Stripes on Left Platform Ledge
  for (int i = 0; i < 400; i = i + 20) {
    stroke(HAZARD_ORANGE, 180);
    line(i, 400, i + 10, 410);
  }
  
  // Hazard Caution Stripes on Center Platform Ledge
  for (int i = 600; i < 800; i = i + 20) {
    stroke(HAZARD_ORANGE, 180);
    line(i, 600, i + 10, 610);
  }

  // Structural 
  noStroke();
  fill(16, 26, 36);
  rect(180, 400, 220, 800); // Left wall foundation column
  rect(680, 600, 720, 800); // Right wall foundation column
  
  // Decorative 
  fill(NEON_CYAN, 80);
  ellipse(190, 430, 4, 4);
  ellipse(210, 430, 4, 4);
  ellipse(690, 630, 4, 4);
  ellipse(710, 630, 4, 4);

  // Exhaust Wall 
  stroke(10, 15, 22);
  strokeWeight(3);
  fill(20, 32, 45);
  rect(40, 450, 120, 510);
  rect(880, 620, 960, 680);
  
  //Vents
  stroke(12, 20, 28);
  strokeWeight(2);
  // Left 
  line(50, 460, 110, 460);
  line(50, 470, 110, 470);
  line(50, 480, 110, 480);
  line(50, 490, 110, 490);
  line(50, 500, 110, 500);
  
  // Right 
  line(890, 630, 950, 630);
  line(890, 640, 950, 640);
  line(890, 650, 950, 650);
  line(890, 660, 950, 660);
  line(890, 670, 950, 670);

  // Box Station
  noStroke();
  fill(35, 50, 68);
  rect(320, 360, 350, 400);
  
  // Flashing Indicator Light 
  if (frameCount % 60 < 30) {
    fill(NEON_CYAN);
  } else {
    fill(0, 80, 100);
  }
  rect(327, 370, 333, 376);
  
  // Flashing Indicator Light 2 
  if (frameCount % 40 < 20) {
    fill(HAZARD_ORANGE);
  } else {
    fill(100, 50, 0);
  }
  rect(339, 370, 345, 376);
  
  rectMode(CORNER);
}

void drawMapForegroundLevel2() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left top corner wall design
  noStroke();
  fill(14, 22, 33);
  rect(15, 40, 85, 380);
  
  fill(22, 32, 45);
  rect(25, 60, 75, 180);   
  rect(25, 200, 75, 360);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(35, 80, 45, 90);
  rect(35, 110, 45, 120);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(65, 220, 70, 235);

  // right top corner wall design
  noStroke();
  fill(14, 22, 33);
  rect(1115, 40, 1185, 380);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 60; y < 360; y += 25) {
    line(1130, y, 1170, y);
  }

  // stationary platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Top left platform
  line(115, 365, 285, 365);
  line(115, 385, 285, 385);
  
  // Bottom left platform
  line(15, 615, 185, 615);
  line(15, 635, 185, 635);
  
  // Top right platform
  line(915, 365, 1085, 365);
  line(915, 385, 1085, 385);

  // moving platform tracking rails
  stroke(22, 32, 45);
  strokeWeight(4);
  line(350, 375, 850, 375); 
  line(250, 625, 1000, 625); 

  // moving platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Top slider platform
  int movePlat1X1 = (int)(200 * sin(frameCount / 30.0) + 500);
  int movePlat1X2 = (int)(200 * sin(frameCount / 30.0) + 700);
  line(movePlat1X1 + 10, 365, movePlat1X2 - 10, 365);
  line(movePlat1X1 + 10, 385, movePlat1X2 - 10, 385);
  
  // Bottom slider platform
  int movePlat2X1 = (int)(350 * sin(frameCount / 30.0) + 550);
  int movePlat2X2 = (int)(350 * sin(frameCount / 30.0) + 750);
  line(movePlat2X1 + 10, 615, movePlat2X2 - 10, 615);
  line(movePlat2X1 + 10, 635, movePlat2X2 - 10, 635);

  // hazard lines
  for (int i = 0; i < 100; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 650, i + 10, 658);
  }
  
  for (int i = 1100; i < 1200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 650, i + 10, 658);
  }

  rectMode(CORNER);
}

void drawMapForegroundLevel3() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left side walls design
  noStroke();
  fill(14, 22, 33);
  rect(15, 20, 85, 230);
  rect(15, 415, 85, 445);
  
  fill(22, 32, 45);
  rect(25, 40, 75, 130);   
  rect(25, 150, 75, 210);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(35, 60, 45, 70);
  rect(35, 90, 45, 100);

  // stationary platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Center-Left Fixed Platform (Y: 400 to 450)
  line(415, 415, 585, 415);
  line(415, 435, 585, 435);
  
  // Center-Right Fixed Platform (Y: 400 to 450)
  line(815, 415, 885, 415);
  line(815, 435, 885, 435);
  
  // High Floating Platform (Y: 200 to 250)
  line(965, 215, 1035, 215);
  line(965, 235, 1035, 235);

  // middle moving platform tracking rail (scooched right by +25)
  stroke(22, 32, 45);
  strokeWeight(4);
  line(775, 475, 875, 475);

  // middle moving platform design
  int movePlat2X1 = (int)(50 * sin(frameCount / 10.0) + 800);
  int movePlat2X2 = (int)(50 * sin(frameCount / 10.0) + 900);
  stroke(24, 34, 48);
  strokeWeight(3);
  line(movePlat2X1 + 10, 465, movePlat2X2 - 10, 465);
  line(movePlat2X1 + 10, 485, movePlat2X2 - 10, 485);

  // lowest moving platform design (track completely removed)
  int movePlat1X1 = (int)(200 * sin(frameCount / 30.0) + 500);
  int movePlat1X2 = (int)(200 * sin(frameCount / 30.0) + 700);
  stroke(24, 34, 48);
  strokeWeight(3);
  line(movePlat1X1 + 10, 765, movePlat1X2 - 10, 765);
  line(movePlat1X1 + 10, 785, movePlat1X2 - 10, 785);

  // spawn hazard lines
  for (int i = 0; i < 200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 750, i + 10, 758);
  }

  // right platform hazard lines
  for (int i = 1000; i < 1200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 670, i + 10, 678);
  }

  rectMode(CORNER);
}


void drawMapForegroundLevel4() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left wall design
  noStroke();
  fill(14, 22, 33);
  rect(15, 40, 85, 560);
  
  fill(22, 32, 45);
  rect(25, 60, 75, 200);   
  rect(25, 220, 75, 380);  
  rect(25, 400, 75, 540);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(35, 80, 45, 90);
  rect(35, 110, 45, 120);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(65, 240, 70, 255);

  // right wall design
  noStroke();
  fill(14, 22, 33);
  rect(1115, 30, 1185, 470);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 60; y < 450; y += 25) {
    line(1130, y, 1170, y);
  }

  // platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Platform 1
  line(315, 515, 485, 515);
  line(315, 535, 485, 535);
  
  // Platform 2
  line(715, 515, 885, 515);
  line(715, 535, 885, 535);
  
  // Platform 3
  line(315, 315, 485, 315);
  line(315, 335, 485, 335);
  
  // Platform 4
  line(715, 315, 885, 315);
  line(715, 335, 885, 335);

  // hazard lines
  for (int i = 0; i < 100; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 750, i + 10, 758);
  }
  
  for (int i = 1100; i < 1200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 750, i + 10, 758);
  }

  rectMode(CORNER);
}



void drawMapForegroundLevel5() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left wall design
  noStroke();
  fill(14, 22, 33);
  rect(15, 40, 135, 280);
  
  fill(22, 32, 45);
  rect(25, 60, 125, 150);   
  rect(25, 170, 125, 260);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(35, 80, 45, 90);
  rect(35, 110, 45, 120);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(65, 190, 70, 205);

  // right walls design
  noStroke();
  fill(14, 22, 33);
  rect(1065, 30, 1185, 270);
  rect(1065, 580, 1185, 770);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 55; y < 250; y += 25) {
    line(1080, y, 1170, y);
  }
  for (int y = 605; y < 750; y += 25) {
    line(1080, y, 1170, y);
  }

  // stationary platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Platform A
  line(315, 565, 435, 565);
  line(315, 585, 435, 585);
  
  // Platform B
  line(565, 485, 635, 485);
  line(565, 505, 635, 505);
  
  // Platform C
  line(765, 565, 885, 565);
  line(765, 585, 885, 585);

  // moving platform tracking rail
  stroke(22, 32, 45);
  strokeWeight(4);
  line(370, 275, 870, 275);

  // moving platform design
  int movePlatX1 = (int)(250 * sin(frameCount / 20.0) + 520);
  int movePlatX2 = (int)(250 * sin(frameCount / 20.0) + 680);
  
  stroke(24, 34, 48);
  strokeWeight(3);
  line(movePlatX1 + 10, 260, movePlatX2 - 10, 260);
  line(movePlatX1 + 10, 290, movePlatX2 - 10, 290);

  // hazard lines
  for (int i = 0; i < 150; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 700, i + 10, 708);
  }
  rectMode(CORNER);
}

void drawMapForegroundLevel6() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left wall design
  noStroke();
  fill(14, 22, 33);
  rect(15, 190, 85, 760);
  
  fill(22, 32, 45);
  rect(25, 210, 75, 350);   
  rect(25, 380, 75, 520);  
  rect(25, 550, 75, 700);  
  
  // Beep Boop
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(35, 230, 45, 240);
  rect(35, 260, 45, 270);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(65, 400, 70, 415);

  // right wall design
  noStroke();
  fill(14, 22, 33);
  rect(1115, 30, 1185, 570);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 60; y < 550; y += 25) {
    line(1130, y, 1170, y);
  }

  // platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Platform 4
  line(115, 765, 1185, 765);
  line(115, 785, 1185, 785);

  // hazard lines
  for (int i = 1100; i < 1200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 750, i + 10, 758);
  }

  rectMode(CORNER);
}


void drawMapForegroundLevel7() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left wall design
  noStroke();
  fill(14, 22, 33);
  rect(10, 40, 40, 560);
  
  fill(22, 32, 45);
  rect(15, 60, 35, 200);   
  rect(15, 220, 35, 380);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(20, 80, 30, 90);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(20, 240, 30, 255);

  // right wall design
  noStroke();
  fill(14, 22, 33);
  rect(1115, 220, 1185, 770);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 245; y < 750; y += 25) {
    line(1130, y, 1170, y);
  }

  // starting platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  line(15, 765, 185, 765);
  line(15, 785, 185, 785);

  // small moving platforms design (Matches physics loop math)
  stroke(24, 34, 48);
  strokeWeight(3);
  for (int i = 0; i < 5; i++) {
    int platX1 = i * 180 + 200;
    int platX2 = i * 180 + 280;
    int platY1 = (int)(250 * sin(frameCount / 30.0 + i * 500) + 410);
    
    // Single centered tech-line inside the small moving platform
    line(platX1 + 10, platY1 + 15, platX2 - 10, platY1 + 15);
  }

  // hazard lines
  for (int i = 0; i < 200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 750, i + 10, 758);
  }

  rectMode(CORNER);
}

void drawMapForegroundLevel8() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // left edge wall design
  noStroke();
  fill(14, 22, 33);
  rect(5, 40, 45, 760);
  
  fill(22, 32, 45);
  rect(10, 80, 40, 300);   
  rect(10, 340, 40, 600);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(15, 100, 25, 110);
  rect(15, 130, 25, 140);

  // big central dividing pillar design (matches left wall style)
  noStroke();
  fill(14, 22, 33);
  rect(315, 20, 485, 180);
  
  fill(22, 32, 45);
  rect(325, 40, 475, 160);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(340, 60, 355, 75);

  // right edge walls design
  noStroke();
  fill(14, 22, 33);
  rect(1155, 30, 1195, 620);
  rect(1115, 410, 1195, 540);
  
  stroke(10, 15, 22);
  strokeWeight(3);
  for (int y = 60; y < 600; y += 25) {
    line(1165, y, 1185, y);
  }
  for (int y = 430; y < 520; y += 25) {
    line(1130, y, 1180, y);
  }

  // stationary platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  
  // Platform below bigger laser
  line(715, 365, 1135, 365);
  line(715, 385, 1135, 385);
  
  // Platform below smaller laser
  line(65, 465, 435, 465);
  line(65, 485, 435, 485);
  
  // Exit door platform
  line(915, 715, 1185, 715);
  line(915, 735, 1185, 735);

  // vertical moving platform tracking rails
  stroke(22, 32, 45);
  strokeWeight(4);
  line(675, 530, 675, 770); // closest to door (X: 675, spans its movement)
  line(425, 700, 425, 800); // second closest to door (X: 425)
  line(175, 700, 175, 800); // farthest from door (X: 175)

  // moving platform designs
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Platform closest to door
  int movePlat1Y1 = (int)(120 * sin(frameCount / 20.0) + 650);
  line(615, movePlat1Y1 + 10, 735, movePlat1Y1 + 10);
  line(615, movePlat1Y1 + 20, 735, movePlat1Y1 + 20);
  
  // Platform second closest to door
  int movePlat2Y1 = (int)(50 * sin(frameCount / 20.0) + 750);
  line(365, movePlat2Y1 + 10, 485, movePlat2Y1 + 10);
  line(365, movePlat2Y1 + 20, 485, movePlat2Y1 + 20);
  
  // Platform farthest from door
  int movePlat3Y1 = (int)(50 * sin(frameCount / 20.0 + 400) + 750);
  line(115, movePlat3Y1 + 10, 235, movePlat3Y1 + 10);
  line(115, movePlat3Y1 + 20, 235, movePlat3Y1 + 20);

  // hazard lines
  for (int i = 900; i < 1200; i += 20) {
    stroke(HAZARD_ORANGE, 130);
    strokeWeight(2);
    line(i, 700, i + 10, 708);
  }

  rectMode(CORNER);
}


void drawMapForegroundLevel9() {
  rectMode(CORNERS);
  strokeWeight(2);
  
  // big side wall design
  noStroke();
  fill(14, 22, 33);
  rect(1015, 20, 1185, 280);
  
  fill(22, 32, 45);
  rect(1025, 40, 1175, 140);   
  rect(1025, 160, 1175, 260);  
  
  if (frameCount % 60 < 30) {
    fill(0, 240, 255, 180); 
  } else {
    fill(0, 60, 90);
  }
  rect(1035, 60, 1055, 80);
  
  if (frameCount % 40 < 20) {
    fill(255, 100, 0, 180); 
  } else {
    fill(100, 30, 0);
  }
  rect(1035, 180, 1060, 200);

  // stationary platform design
  stroke(24, 34, 48);
  strokeWeight(3);
  
  // Starting platform
  line(15, 765, 185, 765);
  line(15, 785, 185, 785);
  
  // Obstacle 1 floor
  line(315, 715, 485, 715);
  line(315, 735, 485, 735);
  
  // Obstacle 4 platform
  line(715, 452, 805, 452);
  
  // Obstacle 5 platform
  line(15, 312, 185, 312);
  
  // Door platform
  line(765, 190, 985, 190);

  // big ceiling block design
  noStroke();
  fill(14, 22, 33);
  rect(315, 415, 485, 535); // Internal background plate
  
  fill(22, 32, 45);
  rect(330, 430, 400, 520); // Left machine bay
  rect(415, 430, 470, 520); // Right machine bay
  
  // Blinking danger node for the ceiling hazard
  if (frameCount % 30 < 15) {
    fill(255, 50, 50, 200); // Sharp flashing red
  } else {
    fill(80, 10, 10);
  }
  rect(435, 450, 450, 465);

  // horizontally moving platform tracking rail
  stroke(22, 32, 45);
  strokeWeight(4);
  line(520, 687, 1080, 687);

  // horizontally moving platform design
  int moveHorizX1 = (int)(180 * sin(frameCount / 20.0) + 700);
  int moveHorizX2 = (int)(180 * sin(frameCount / 20.0) + 900);
  
  stroke(24, 34, 48);
  strokeWeight(3);
  line(moveHorizX1 + 15, 687, moveHorizX2 - 15, 687);

  // vertically moving platform tracking rail
  stroke(22, 32, 45);
  strokeWeight(4);
  line(1100, 530, 1100, 770);

  // vertically moving platform design
  int moveVertY1 = (int)(120 * cos(frameCount / 20.0) + 650);
  
  stroke(24, 34, 48);
  strokeWeight(3);
  line(1015, moveVertY1 + 10, 1185, moveVertY1 + 10);
  line(1015, moveVertY1 + 20, 1185, moveVertY1 + 20);

  rectMode(CORNER);
}
