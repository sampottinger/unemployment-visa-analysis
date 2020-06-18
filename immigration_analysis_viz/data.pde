Dataset loadDataset(String filename) {
  List<Occupation> occupations = new ArrayList<>();
  
  for (TableRow row : loadTable(filename, "header").rows()) {
    String newName = row.getString("occupationShort");
    float newPercentVisa = row.getFloat("percentVisa");
    float newMay2020UnemployedRate = row.getFloat("may2020UnemployedRate");
    float newMay2019UnemployedRate = row.getFloat("may2019UnemployedRate");
    float newHypotheticalUnemployment = row.getFloat("hypotheticalUnemployment");
    occupations.add(new Occupation(
      newName,
      newPercentVisa,
      newMay2020UnemployedRate,
      newMay2019UnemployedRate,
      newHypotheticalUnemployment
    ));
  }
  
  return new Dataset(occupations);
}


class Dataset {
  private final List<RankedOccupation> occupations;
  private final float maxVisaAmt;
  private final float maxUnemploymentAmt;

  public Dataset(List<Occupation> newOccupations) {
    List<RankedOccupationBuilder> builders = new ArrayList<>();

    // Change unemployment rank
    Collections.sort(newOccupations, (a, b) -> {
      Float aValue = a.getObservedUnemployedRateChange();
      Float bValue = b.getObservedUnemployedRateChange();
      return bValue.compareTo(aValue);
    });

    float newMaxUnemployment = 0;
    int i = 0;
    for (Occupation occupation : newOccupations) {
      RankedOccupationBuilder builder = new RankedOccupationBuilder();
      builder.setOccupation(occupation);
      builder.setChangeUnemploymentRank(i);
      builders.add(builder);
      newMaxUnemployment = max(newMaxUnemployment, occupation.getMaxUnemployment());
      i++;
    }
    
    maxUnemploymentAmt = ceil(newMaxUnemployment);

    // Visa amount rank
    Collections.sort(builders, (a, b) -> {
      Float aValue = a.getOccupationMaybe().get().getPercentVisa();
      Float bValue = b.getOccupationMaybe().get().getPercentVisa();
      return bValue.compareTo(aValue);
    });

    i = 0;
    for (RankedOccupationBuilder builder : builders) {
      builder.setVisaAmountRank(i);
      i++;
    }
    
    maxVisaAmt = ceil(builders.get(0).getOccupationMaybe().get().getPercentVisa());

    // Finalize
    occupations = builders.stream()
      .map((x) -> x.build())
      .collect(Collectors.toList());
  }
  
  public List<RankedOccupation> getOccupationsByVisaRank() {
    Collections.sort(
      occupations,
      (a, b) -> {
        Integer aVal = a.getVisaAmountRank();
        Integer bVal = b.getVisaAmountRank();
        return aVal.compareTo(bVal);
      }
    );
    
    return occupations;
  }
  
  public List<RankedOccupation> getOccupationsByUnemploymentRank() {
    Collections.sort(
      occupations,
      (a, b) -> {
        Integer aVal = a.getChangeUnemploymentRank();
        Integer bVal = b.getChangeUnemploymentRank();
        return aVal.compareTo(bVal);
      }
    );
    
    return occupations;
  }
  
  public float getMaxPercentVisa() {
    return maxVisaAmt;
  }
  
  public float getMaxUnemploymentRate() {
    return maxUnemploymentAmt;
  }
  
}


class Occupation {

  private final String name;
  private final float percentVisa;
  private final float may2020UnemployedRate;
  private final float may2019UnemployedRate;
  private final float hypotheticalUnemployment;

  public Occupation(String newName, float newPercentVisa,
      float newMay2020UnemployedRate, float newMay2019UnemployedRate,
      float newHypotheticalUnemployment) {

    name = newName;
    percentVisa = newPercentVisa;
    may2020UnemployedRate = newMay2020UnemployedRate;
    may2019UnemployedRate = newMay2019UnemployedRate;
    hypotheticalUnemployment = newHypotheticalUnemployment;
  }

  public String getName() {
    return name;
  }

  public float getPercentVisa() {
    return percentVisa;
  }

  public float getMay2020UnemployedRate() {
    return may2020UnemployedRate;
  }

  public float getMay2019UnemployedRate() {
    return may2019UnemployedRate;
  }

  public float getObservedUnemployedRateChange() {
    return may2020UnemployedRate - may2019UnemployedRate;
  }

  public float getHypotheticalUnemployment() {
    return hypotheticalUnemployment;
  }
  
  public float getMaxUnemployment() {
    return max(may2020UnemployedRate, may2019UnemployedRate);
  }

}


class RankedOccupation {

  private final int visaAmountRank;
  private final int changeUnemploymentRank;
  private final Occupation occupation;

  public RankedOccupation(int newVisaAmountRank, int newChangeUnemploymentRank,
      Occupation newOccupation) {

    visaAmountRank = newVisaAmountRank;
    changeUnemploymentRank = newChangeUnemploymentRank;
    occupation = newOccupation;
  }

  public int getVisaAmountRank() {
    return visaAmountRank;
  }

  public int getChangeUnemploymentRank() {
    return changeUnemploymentRank;
  }

  public Occupation getOccupation() {
    return occupation;
  }

}


class RankedOccupationBuilder {

  private Optional<Integer> visaAmountRank;
  private Optional<Integer> changeUnemploymentRank;
  private Optional<Occupation> occupation;

  public RankedOccupationBuilder() {
    visaAmountRank = Optional.empty();
    changeUnemploymentRank = Optional.empty();
    occupation = Optional.empty();
  }

  public void setVisaAmountRank(int newValue) {
    visaAmountRank = Optional.of(newValue);
  }

  public void setChangeUnemploymentRank(int newValue) {
    changeUnemploymentRank = Optional.of(newValue);
  }

  public void setOccupation(Occupation newValue) {
    occupation = Optional.of(newValue);
  }

  public Optional<Integer> getVisaAmountRankMaybe() {
    return visaAmountRank;
  }

  public Optional<Integer> getChangeUnemploymentRankMaybe() {
    return changeUnemploymentRank;
  }

  public Optional<Occupation> getOccupationMaybe() {
    return occupation;
  }

  public boolean isReady() {
    boolean isReady = true;
    isReady = isReady && visaAmountRank.isPresent();
    isReady = isReady && changeUnemploymentRank.isPresent();
    isReady = isReady && occupation.isPresent();
    return isReady;
  }

  public RankedOccupation build() {
    if (!isReady()) {
      throw new RuntimeException("Tried building incomplete ranked occupation");
    }
    return new RankedOccupation(
      visaAmountRank.get(),
      changeUnemploymentRank.get(),
      occupation.get()
    );
  }

}
