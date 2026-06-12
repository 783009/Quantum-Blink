void Level_10(){
  image(Escaped, 0 , 0);
  drawEscapedScreen();
  
}


void drawEscapedScreen() {
  
  // 2. Check for new records only once
  if (!checkedRecords) {
    elapsed = millis() - startTime + startElapsed;
    
    if (!hasBestSave || currentDeaths < bestDeaths){
      isNewBestDeaths = true;
      bestDeaths = currentDeaths; // Update the record
    }
    if (!hasBestSave || elapsed < bestElapsed){
      isNewBestTime = true;
      bestElapsed = elapsed; // Update the record
    }
    
    // --- WEB LOCAL STORAGE BEST RUNS SYSTEM ---
    localStorage.setItem("qb_bestDeaths", "" + bestDeaths);
    localStorage.setItem("qb_bestElapsed", "" + bestElapsed);
    
    // --- RESET THE CHOSEN CURRENT SAVE IN STORAGE ---
    localStorage.setItem("qb_currentLevel", "1");
    localStorage.setItem("qb_currentDeaths", "0");
    localStorage.setItem("qb_elapsed", "0");
    
    hasSave = false;
    
    hasBestSave = true;    
    checkedRecords = true;
  }
  
  // 3. Animate the UI Drop
  escapeUiY += (escapeTargetY - escapeUiY) / 40.0;
  escapePulseAngle += 0.08;
  
  // 4. Draw the Panel
  pushMatrix();
  translate(width / 2 - 250, escapeUiY); // Center horizontally
  
  fill(WALL_DARK_BLUE, 230); 
  stroke(NEON_CYAN);
  strokeWeight(3);
  rect(0, 0, 500, 400, 15);
  
  // Title
  textAlign(CENTER, TOP);
  fill(NEON_CYAN);
  textSize(40);
  text("YOU ESCAPED!", 250, 30);
  
  // Divider
  stroke(NEON_CYAN, 100);
  line(50, 85, 450, 85);
  
  // Stats
  textAlign(LEFT, CENTER);
  textSize(24);
  
  // Deaths
  fill(255);
  text("TOTAL DEATHS: " + currentDeaths, 60, 150);
  if (isNewBestDeaths){
    drawPulsingText("NEW BEST!", 380, 150, TOXIC_GREEN);
  }
  
  // Time
  fill(255);
  textAlign(LEFT, CENTER);
  text("TOTAL TIME: " + formatTime(elapsed), 60, 230);
  if (isNewBestTime){
    drawPulsingText("NEW BEST!", 380, 230, HAZARD_ORANGE);
  }
  // Menu Button
  float btnW = 160;
  float btnH = 50;
  float btnX = 170;
  float btnY = 310;
  
  float realBtnY = escapeUiY + btnY;
  
  if (mouseX > 520 && mouseX < 520 + btnW && mouseY > realBtnY && mouseY < realBtnY + btnH) {
    fill(0, 150, 180, 180); // Hover fill
  } else {
    fill(15, 22, 30); // Standard fill
  }
  
  stroke(NEON_CYAN);
  strokeWeight(2);
  rect(btnX, btnY, btnW, btnH, 8);
  
  textAlign(CENTER, CENTER);
  fill(255);
  text("MENU", btnX + btnW / 2, btnY + btnH / 2 - 3);
  
  popMatrix();
}

// Helper for the growing/shrinking text
void drawPulsingText(String txt, float x, float y, color c) {
  pushMatrix();
  translate(x, y);
  float scaleFactor = 1.0 + sin(escapePulseAngle) * 0.15;
  scale(scaleFactor);
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(c);
  text(txt, 0, 0);
  popMatrix();
}
