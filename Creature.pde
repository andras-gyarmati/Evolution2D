class Creature {

  ArrayList<Knob> knobs;
  ArrayList<Muscle> muscles;
  String name;
  float fitness;
  float relProb;

  Creature() {
    fitness = 0;
    relProb = 0;
    knobs = new ArrayList<Knob>();
    muscles = new ArrayList<Muscle>();
    for (int i = 0; i < 5; i++) {
      knobs.add(new Knob(random(210, 400), random(410, 600), random(1), random(1), random(1)));
    }
    for (int i = 0; i < 10; i++) {
      Knob k1 = knobs.get(floor(random(knobs.size())));
      Knob k2 = null;
      while (k2 == null) {
        Knob knob = knobs.get(floor(random(knobs.size())));
        if (k1 != knob && !k1.pairs.contains(knob)) {
          k2 = knob;
        }
      }
      muscles.add(new Muscle(k1, k2, random(1), random(1)));
    }
  }

  void destroy() {
    for (Knob k : knobs) {
      k.destroy();
    }
    for (Muscle m : muscles) {
      m.destroy();
    }
  }

  void display() {
    for (Knob k : knobs) {
      k.display();
    }
    for (Muscle m : muscles) {
      m.display();
    }
  }

  Creature newOffspring() {
    Creature offspring = this;
    //mutation
    return offspring;
  }

  Creature newOffspring(Creature creature) {
    Creature offspring = this;
    //mixing the genes
    //mutation
    return offspring;
  }
}