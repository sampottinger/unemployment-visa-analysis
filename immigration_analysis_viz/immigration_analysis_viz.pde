import java.util.*;
import java.util.stream.*;


final boolean USE_SLOPEGRAPH = false;


void setup() {
  size(775, 680);

  Dataset dataset = loadDataset("unemployment_and_counts_extended.csv");
  loadSemiconstants();

  background(#F8F8F8);
  drawTitle();
  
  drawIncreaseUnemployment(dataset);
  
  if (USE_SLOPEGRAPH) {
    drawVisaAmount(dataset);
    drawConnections(dataset);
    save("slopegraph.png");
  } else {
    drawUnemploymentBeforeAfter(dataset);
    drawHypotheticalUnemployment(dataset);
    save("before_after.png");
  }
}


void draw() {
}
