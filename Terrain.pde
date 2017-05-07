class Terrain {

  ArrayList<Boundary> boundaries;
  Population population;
  Population nextPopulation;

  Terrain(int populationSize) {
    boundaries = new ArrayList<Boundary>();
    boundaries.add(new Boundary(width/2, height-45, width * 10, 90));
    population = new Population(populationSize);
    nextPopulation = new Population(populationSize);
  }

  void newPopulation() {
    nextPopulation = population.reproduce();
  }

  void display() {
    for (Boundary b : boundaries) {
      b.display();
    }
    for (Creature c : population.creatures) {
      c.display();
    }
  }
}