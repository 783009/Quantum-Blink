// Draws the overlay that shows your current level deaths and time
void drawHUD(){
  // Calculate current time
  elapsed = millis() - startTime + startElapsed;
  
  // Store the converted time as a string
  String timeText = formatTime(elapsed);
  String levelText = "LEVEL " + currentLevel + "/10";
  String deathText = "DEATHS  " + currentDeaths;
  
  if(canBlink)
    image(blink, 440, 5, 50, 50);
  else{
    pushStyle();
    tint(150, 150, 150, 100);
    image(blink, 440, 5, 50, 50);
    popStyle();
  }
  rectMode(CORNER);
  
  // Background panel
  fill(#192634, 220);
  stroke(#00F0FF);
  strokeWeight(2);
  rect(0, 0, 430, 55);
  
  // Scanline effect
  stroke(#00F0FF, 40);
  strokeWeight(1);
  int scanY = (frameCount % 50);
  line(0, scanY, 420, scanY);
  
  // Divider lines
  stroke(#00F0FF, 100);
  strokeWeight(1);
  line(140, 8, 140, 47);
  line(280, 8, 280, 47);
  
  // Text formating
  textAlign(CENTER, CENTER);
  textSize(18);
  
  // Level - cyan
  fill(#00F0FF);
  text(levelText, 70, 27);
  
  // Deaths - orange
  fill(#FF7800);
  text(deathText, 210, 27);
  
  // Time - white
  fill(220);
  text(timeText, 355, 27);
  
  // Pause Button (Top Right)
  fill(#192634, 220);
  stroke(#00F0FF);
  strokeWeight(2);
  rect(1120, 10, 60, 40, 5);
  
  fill(#00F0FF);
  rect(1142, 20, 3, 20);
  rect(1155, 20, 3, 20);
  textAlign(LEFT);
}


void drawPauseMenu(){
  // Darkened background
  rectMode(CORNER);
  fill(0, 180); // Black with opacity
  noStroke();
  rect(0, 0, width, height);
  
  // PAUSED Title
  textAlign(CENTER, CENTER);
  textSize(80);
  fill(10, 20, 30); 
  text("PAUSED", (width / 2) + 4, 200 + 4); // Shadow
  fill(NEON_CYAN);
  text("PAUSED", width / 2, 200);
  
  // Buttons
  drawMenuButton(width / 2, 350, "[Continue]");
  drawMenuButton(width / 2, 450, "[Menu]");
  drawMenuButton(width / 2, 550, "[Quit]");
}



void drawDataLog(){
  // Semi-transparent overlay backdrop
  fill(5, 10, 20, 220);
  noStroke();
  rect(0, 0, width, height);
  
  // Draw Center Card Window Box
  fill(18, 30, 48);
  stroke(0, 180, 255);
  strokeWeight(3);
  rect(width/2 - 250, height/2 - 250, 500, 500, 15);
  
  // Content Layout Text
  textAlign(CENTER, TOP);
  fill(0, 220, 255);
  textSize(36);
  text("QUANTUM DATA LOG", width/2, height/2 - 220);
  
  // CURRENT SAVE STATS BLOCK
  textAlign(LEFT, TOP);
  fill(255);
  textSize(24);
  int startY = height/2 - 140;
  
  fill(0, 255, 150);
  text("CURRENT SAVE:", width/2 - 200, startY);
  if (hasSave) {
    fill(NEON_CYAN);
    text("Level: " + currentLevel + "/10", width/2 - 180, startY + 35);
    fill(HAZARD_ORANGE);
    text("Deaths: " + currentDeaths, width/2 - 180, startY + 65);
    fill(250);
    text("Time: " + formatTime(startElapsed), width/2 - 180, startY + 95);
  } else {
    fill(NEON_CYAN);
    text("Level: -/10", width/2 - 180, startY + 35);
    fill(HAZARD_ORANGE);
    text("Deaths: -", width/2 - 180, startY + 65);
    fill(250);
    text("Time: --:--:--", width/2 - 180, startY + 95);
  }
  
  // ALL TIME BEST RECORDS BLOCK
  int bestY = height/2 + 20;
  fill(0, 255, 150);
  text("ALL-TIME BEST:", width/2 - 200, bestY);
  
  fill(255);
  if (hasBestSave) {
    fill(HAZARD_ORANGE);
    text("Deaths: " + bestDeaths, width/2 - 180, bestY + 35);
    fill(250);
    text("Time: " + formatTime(bestElapsed), width/2 - 180, bestY + 65);
  } else {
    fill(HAZARD_ORANGE);
    text("Deaths: -", width/2 - 180, bestY + 35);
    fill(250);
    text("Time: --:--:--", width/2 - 180, bestY + 65);
  }
  
  // DRAW CLOSE BUTTON BUTTON
  if (mouseX > 520 && mouseX < 680 && mouseY > 555 && mouseY < 605) {
    fill(200, 50, 50); // Hover state
  } else {
    fill(150, 30, 30);
  }
  stroke(255, 100, 100);
  rect(520, 555, 160, 50, 8);
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(22);
  text("CLOSE", 600, 580);
}

String formatTime(int ms) {
  int totalSecs = ms / 1000;
  int hours = totalSecs / 3600;
  int minutes = (totalSecs % 3600) / 60;
  int seconds = totalSecs % 60;
  return nf(hours, 2) + ":" + nf(minutes, 2) + ":" + nf(seconds, 2);
}
