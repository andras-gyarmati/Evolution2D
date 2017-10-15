class Terrain { //<>//

  ArrayList<Boundary> boundaries;
  Population population;
  int popCount;
  
  Terrain(int populationSize) {
    boundaries = new ArrayList<Boundary>();
    boundaries.add(new Boundary(width/2, height-45, width * 10, 90));
    PVector minSpawnPos = new PVector(width / 5, boundaries.get(0).y - height/3); 
    PVector maxSpawnPos = new PVector(width / 3, boundaries.get(0).y - boundaries.get(0).h);
    population = new Population(populationSize, minSpawnPos, maxSpawnPos);
    popCount = 0;
  }

  void display() { //TODO kamera mozog, kis hosszjelzesek mutatjak hol jarunk
    for (Boundary b : boundaries) {
      b.display();
    }
    displayPopCount();
    population.display();
  }

  void displayPopCount() {
    textSize(30);
    fill(0);
    text("population: #" + popCount, 100, 200);
  }

  void step() {
    population.step();
    if (population.creatureCount == population.creatures.size()) {
      population = population.reproduce();
      popCount++;
    }
  }
}