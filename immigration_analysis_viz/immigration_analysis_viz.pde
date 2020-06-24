import java.util.*;
import java.util.stream.*;


final Mode MODE = Mode.WORKFORCE_SHARE;


void setup() {
  size(680, 680);
  Dataset dataset = loadDataset("unemployment_and_counts_extended.csv");
  loadSemiconstants();

  background(#F8F8F8);
  drawTitle();
  
  drawIncreaseUnemployment(dataset);
  
  if (MODE == Mode.WORKFORCE_SHARE) {
    drawVisaAmount(dataset);
    drawConnections(dataset);
    save("slopegraph.png");
  } else if (MODE == Mode.CHANGE_UNEMPLOYMENT) {
    drawUnemploymentBeforeAfter(dataset);
    save("before_after.png");
  } else if (MODE == Mode.PROJECTIONS) {
    drawHypotheticalUnemployment(dataset);
    save("hypothetical.png");
  }
}


void draw() {
}
