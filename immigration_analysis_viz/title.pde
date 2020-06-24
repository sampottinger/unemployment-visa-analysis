void drawTitle() {
  pushMatrix();
  pushStyle();
  
  rectMode(CORNER);
  noStroke();
  fill(#E0E0E0);
  rect(0, 0, width, HEADER_HEIGHT);
  
  textFont(HEADER_FONT);
  textAlign(LEFT, BOTTOM);
  fill(BLACK);
  
  String title;
  if (MODE == Mode.WORKFORCE_SHARE) {
    title = "Visas and the US Workforce During COVID-19";
  } else if (MODE == Mode.CHANGE_UNEMPLOYMENT) {
    title =  "Change in Unemployment During COVID";
  } else if (MODE == Mode.PROJECTIONS) {
    title = "Hypothetical Unemployment During COVID-19";
  } else {
    title = "";
  }
  
  text(title, 5, HEADER_HEIGHT - 5);
  
  textFont(SMALL_FONT);
  textAlign(RIGHT, BOTTOM);
  text("May 2020 BLS\nOFLC 2020 Q2", width - 5, HEADER_HEIGHT - 5);
  
  popStyle();
  popMatrix();
}
