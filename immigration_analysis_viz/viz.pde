public void drawVisaAmount(Dataset dataset) {
  pushMatrix();
  pushStyle();
  
  strokeWeight(1);
  
  int y = 15;
  
  // Title
  translate(VISA_AMOUNT_ANCHOR_X, VISA_AMOUNT_ANCHOR_Y);
  textAlign(RIGHT, BOTTOM);
  noStroke();
  fill(BLACK);
  textFont(REGULAR_FONT);
  text("% of Occupation on Visa", 0, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, -REGULAR_SECTION_WIDTH, y);
  
  y += 16;
  noStroke();
  fill(DARK_GRAY);
  textFont(SMALL_FONT);
  
  textAlign(LEFT, BOTTOM);
  text(formatPercent(dataset.getMaxPercentVisa()), -REGULAR_SECTION_WIDTH, y);
  
  textAlign(CENTER, BOTTOM);
  text("Active in 05/2020", -REGULAR_SECTION_WIDTH/2, y);
  
  textAlign(RIGHT, BOTTOM);
  text("0.0%", 0, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, -REGULAR_SECTION_WIDTH, y);
  
  // Body
  y = START_RECORDS_Y;
  
  textAlign(RIGHT, BOTTOM);
  textFont(SMALL_FONT);
  rectMode(CORNER);
  for (RankedOccupation rankedOccupation : dataset.getOccupationsByVisaRank()) {
    Occupation occupation = rankedOccupation.getOccupation();
    
    noFill();
    stroke(DARK_GRAY);
    dottedRuler(-REGULAR_SECTION_WIDTH, -1, y);
    
    fill(DARK_GRAY);
    noStroke();
    float visaPercent = occupation.getPercentVisa();
    String label = occupation.getName() + " (" + formatPercent(visaPercent) + ")";
    text(label, 0, y - 5);
    
    fill(VISA_AMOUNT_COLOR);
    noStroke();
    float barWidth = getVisaWidth(occupation, dataset, REGULAR_SECTION_WIDTH);
    rect(0, y - 3, -barWidth, 4);
    
    y += RECORD_HEIGHT;
  }
  
  popStyle();
  popMatrix();
}


public void drawConnections(Dataset dataset) {
  pushMatrix();
  pushStyle();
  
  translate(VISA_AMOUNT_ANCHOR_X, VISA_AMOUNT_ANCHOR_Y);
  translate(0, START_RECORDS_Y);
  
  float startY = 0;
  strokeWeight(2);
  noFill(); 
  for (RankedOccupation rankedOccupation : dataset.getOccupationsByVisaRank()) {
    float endY = RECORD_HEIGHT * rankedOccupation.getChangeUnemploymentRank();
    stroke(startY < endY ? VISA_AMOUNT_COLOR_TRANSPARENT : NEW_UNEMPLOYMENT_COLOR_TRANSPARENT);
    line(3, startY, CONNECTION_WIDTH - 3, endY);
    startY += RECORD_HEIGHT;
  }
  
  popStyle();
  popMatrix();
}


public void drawIncreaseUnemployment(Dataset dataset) {
  pushMatrix();
  pushStyle();
  
  translate(INCREASE_UNEMPLOYEMENT_ANCHOR_X, INCREASE_UNEMPLOYEMENT_ANCHOR_Y);
  strokeWeight(1);
  
  int y = 15;
  
  // Title
  textAlign(LEFT, BOTTOM);
  noStroke();
  fill(BLACK);
  textFont(REGULAR_FONT);
  text("Unemployment Increase in COVID", 0, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  y += 16;
  noStroke();
  fill(DARK_GRAY);
  textFont(SMALL_FONT);
  
  textAlign(LEFT, BOTTOM);
  text("0.0%", 0, y);
  
  textAlign(CENTER, BOTTOM);
  text("05/2020 Minus 05/2019", REGULAR_SECTION_WIDTH/2, y);
  
  textAlign(RIGHT, BOTTOM);
  text(formatPercent(dataset.getMaxUnemploymentRate()), REGULAR_SECTION_WIDTH, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  // Body
  y = START_RECORDS_Y;
  
  textAlign(LEFT, BOTTOM);
  textFont(SMALL_FONT);
  rectMode(CORNER);
  for (RankedOccupation rankedOccupation : dataset.getOccupationsByUnemploymentRank()) {
    Occupation occupation = rankedOccupation.getOccupation();
    
    noFill();
    stroke(DARK_GRAY);
    dottedRuler(0, REGULAR_SECTION_WIDTH, y);
    
    fill(DARK_GRAY);
    noStroke();
    float rateChange = occupation.getObservedUnemployedRateChange();
    String label = occupation.getName() + " (" + formatPercent(rateChange) + ")";
    text(label, 0, y - 5);
    
    fill(NEW_UNEMPLOYMENT_COLOR);
    noStroke();
    float barWidth = getUnemploymentRateWidth(
      occupation.getObservedUnemployedRateChange(),
      dataset,
      REGULAR_SECTION_WIDTH
    );
    rect(0, y - 3, barWidth, 4);
    
    y += RECORD_HEIGHT;
  }
  
  popStyle();
  popMatrix();
}


public void drawUnemploymentBeforeAfter(Dataset dataset) {
  pushMatrix();
  pushStyle();
  
  translate(UNEMPLOYEMENT_BEFORE_AFTER_ANCHOR_X, UNEMPLOYEMENT_BEFORE_AFTER_ANCHOR_Y);
  strokeWeight(1);
  
  int y = 15;
  
  // Title
  textAlign(LEFT, BOTTOM);
  noStroke();
  fill(BLACK);
  textFont(REGULAR_FONT);
  text("May 2020 vs 2019 Unemployment", 0, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  y += 16;
  noStroke();
  fill(DARK_GRAY);
  textFont(SMALL_FONT);
  
  textAlign(LEFT, BOTTOM);
  text("0.0%", 0, y);
  
  textAlign(RIGHT, BOTTOM);
  fill(OLD_UNEMPLOYMENT_COLOR);
  text("05/2019", REGULAR_SECTION_WIDTH/2 - 2, y);
  
  textAlign(LEFT, BOTTOM);
  fill(NEW_UNEMPLOYMENT_COLOR);
  text("05/2020", REGULAR_SECTION_WIDTH/2 + 2, y);
  
  textAlign(RIGHT, BOTTOM);
  fill(DARK_GRAY);
  text(formatPercent(dataset.getMaxUnemploymentRate()), REGULAR_SECTION_WIDTH, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  // Body
  y = START_RECORDS_Y;
  
  textAlign(LEFT, BOTTOM);
  textFont(SMALL_FONT);
  rectMode(CORNER);
  for (RankedOccupation rankedOccupation : dataset.getOccupationsByUnemploymentRank()) {
    Occupation occupation = rankedOccupation.getOccupation();
    float midY = y - 10;
    
    noFill();
    stroke(DARK_GRAY);
    dottedRuler(0, REGULAR_SECTION_WIDTH, y);
    
    float priorRate = occupation.getMay2019UnemployedRate();
    float newRate = occupation.getMay2020UnemployedRate();
    float priorRateX = getUnemploymentRateWidth(priorRate, dataset, REGULAR_SECTION_WIDTH);
    float newRateX = getUnemploymentRateWidth(newRate, dataset, REGULAR_SECTION_WIDTH);
    
    noFill();
    stroke(LIGHT_GRAY);
    line(priorRateX, midY, newRateX, midY);
    
    ellipseMode(RADIUS);
    noStroke();
    
    fill(OLD_UNEMPLOYMENT_COLOR);
    textAlign(RIGHT, CENTER);
    text(formatPercentInt(priorRate), priorRateX - 4, midY);
    ellipse(priorRateX, midY, 2, 2);
    
    fill(NEW_UNEMPLOYMENT_COLOR);
    textAlign(LEFT, CENTER);
    text(formatPercentInt(newRate), newRateX + 4, midY);
    ellipse(newRateX, midY, 2, 2);
    
    y += RECORD_HEIGHT;
  }
  
  popStyle();
  popMatrix();
}

public void drawHypotheticalUnemployment(Dataset dataset) {
  pushMatrix();
  pushStyle();
  
  translate(HYPOTHETICAL_UNEMPLOYMENT_ANCHOR_X, HYPOTHETICAL_UNEMPLOYMENT_ANCHOR_Y);
  strokeWeight(1);
  
  int y = 15;
  
  // Title
  textAlign(LEFT, BOTTOM);
  noStroke();
  fill(BLACK);
  textFont(REGULAR_FONT);
  text("Hypothetical Change", 0, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  y += 16;
  noStroke();
  fill(DARK_GRAY);
  textFont(SMALL_FONT);
  
  textAlign(LEFT, BOTTOM);
  text("0.0%", 0, y);
  
  textAlign(RIGHT, BOTTOM);
  fill(VISA_AMOUNT_COLOR);
  text("Minimum", REGULAR_SECTION_WIDTH/2 - 2, y);
  
  textAlign(LEFT, BOTTOM);
  fill(NEW_UNEMPLOYMENT_COLOR);
  text("05/2020", REGULAR_SECTION_WIDTH/2 + 2, y);
  
  textAlign(RIGHT, BOTTOM);
  fill(DARK_GRAY);
  text(formatPercent(dataset.getMaxUnemploymentRate()), REGULAR_SECTION_WIDTH, y);
  
  y += 3;
  noFill();
  stroke(DARK_GRAY);
  line(0, y, REGULAR_SECTION_WIDTH, y);
  
  // Body
  y = START_RECORDS_Y;
  
  textAlign(LEFT, BOTTOM);
  textFont(SMALL_FONT);
  rectMode(CORNER);
  for (RankedOccupation rankedOccupation : dataset.getOccupationsByUnemploymentRank()) {
    Occupation occupation = rankedOccupation.getOccupation();
    float midY = y - 10;
    
    noFill();
    stroke(DARK_GRAY);
    dottedRuler(0, REGULAR_SECTION_WIDTH, y);
    
    float priorRate = occupation.getMay2020UnemployedRate();
    float newRate = occupation.getHypotheticalUnemployment();
    float priorRateX = getUnemploymentRateWidth(priorRate, dataset, REGULAR_SECTION_WIDTH);
    float newRateX = getUnemploymentRateWidth(newRate, dataset, REGULAR_SECTION_WIDTH);
    
    noFill();
    stroke(LIGHT_GRAY);
    line(priorRateX, midY, newRateX, midY);
    
    ellipseMode(RADIUS);
    noStroke();
    
    fill(VISA_AMOUNT_COLOR);
    textAlign(RIGHT, CENTER);
    text(formatPercentInt(newRate), newRateX - 4, midY);
    ellipse(newRateX, midY, 2, 2);
    
    fill(NEW_UNEMPLOYMENT_COLOR);
    textAlign(LEFT, CENTER);
    text(formatPercentInt(priorRate), priorRateX + 4, midY);
    ellipse(priorRateX, midY, 2, 2);
    
    y += RECORD_HEIGHT;
  }
  
  popStyle();
  popMatrix();
}
