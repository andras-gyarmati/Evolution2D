class Population {

  ArrayList<Creature> creatures;

  Population() {
    creatures = new ArrayList<Creature>();
  }

  Population(int size) {
    creatures = new ArrayList<Creature>();
    for (int i = 0; i < size; i++) {
      creatures.add(new Creature());
    }
  }

  Population reproduce() {
    Population nextPopulation = new Population(creatures.size());
    for (int i = 0; i < creatures.size(); i++) {
      nextPopulation.creatures.add(creatures.get(i).newOffspring());
    }
    return nextPopulation;
  }
}