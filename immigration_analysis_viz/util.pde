String formatPercent(float percent) {
  return nf(percent, 0, 1) + "%";
}

String formatPercentInt(float percent) {
  return round(percent) + "%";
}

float getVisaWidth(Occupation occupation, Dataset dataset, float maxWidth) {
  return map(occupation.getPercentVisa(), 0, dataset.getMaxPercentVisa(), 0, maxWidth);
}

float getUnemploymentRateWidth(float unemploymentRate, Dataset dataset, float maxWidth) {
  return map(unemploymentRate, 0, dataset.getMaxUnemploymentRate(), 0, maxWidth);
}

void dottedRuler(int startX, int endX, int y) {
  pushMatrix();
  pushStyle();
  
  for (int x = startX; x <= endX; x += 2) {
    point(x, y);
  }
  
  popStyle();
  popMatrix();
}
