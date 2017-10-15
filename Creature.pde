class Creature { //TODO az egeszet atgondolni ugy hogy nem a kepernyon mennyit mozog hanem a vilagban, es kovetni a kameraval

  ArrayList<Knob> knobs;
  ArrayList<Muscle> muscles;
  String name;
  float fitness;
  float relProb;
  float startPosition;
  float finishPosition;
  float mutationAmount;
  float maxPhysicsValue;
  int minKnobRadius, maxKnobRadius;

  private Creature() {
    fitness = 0;
    relProb = 0;
    mutationAmount = 0.3;
    minKnobRadius = 12;
    maxKnobRadius = 17;
    maxPhysicsValue = 1;
  }

  Creature(ArrayList<Knob> knobs, ArrayList<Muscle> muscles) {
    this();
    this.knobs = knobs;
    this.muscles = muscles;
  }

  Creature(int knobCount, PVector minSpawnPos, PVector maxSpawnPos) { //TODO szepiteni, ne lehessen olyan knob ami nem kapcsolodik
    this();
    knobs = new ArrayList<Knob>();
    muscles = new ArrayList<Muscle>();
    for (int i = 0; i < knobCount; i++) {
      knobs.add(new Knob(random(minSpawnPos.x, minSpawnPos.y), random(maxSpawnPos.x, maxSpawnPos.y), random(maxPhysicsValue), random(maxPhysicsValue), random(maxPhysicsValue), random(minKnobRadius, maxKnobRadius)));
    }
    for (int i = 0; i < random(knobCount, (knobCount * (knobCount - 1)) / 2); i++) {
      Knob k1 = null;
      Knob k2 = null;
      while (k2 == null) {
        k1 = pickRandomKnobWithLeastConnections();
        Knob knob = pickRandomKnobWithLeastConnections();
        if (k1 != knob && !k1.pairs.contains(knob)) {
          k2 = knob;
        }
      }
      muscles.add(new Muscle(k1, k2, random(1), random(1)));
      k1.addPair(k2);
    }
  }

  private float calcPosX() {
    float sumX = 0;
    for (Knob k : knobs) {
      sumX += k.getPos().x;
    }
    return sumX / knobs.size();
  }

  Knob pickRandomKnobWithLeastConnections() {
    float[] relProbs = new float[knobs.size()];
    Knob knob = null;
    boolean found = false;
    while (!found) {
      float sum = 0;
      for (Knob k : knobs) {
        sum += subFromHundred(k.pairs.size());
      }
      for (int i = 0; i < knobs.size(); i++) {
        relProbs[i] = subFromHundred(knobs.get(i).pairs.size()) / sum;
      }
      float picker = random(1);
      int i = 0;
      while (picker > 0 && i < knobs.size()) {
        picker -= relProbs[i];
        i++;
      }
      i--;
      if (picker < 0) {
        knob = knobs.get(i);
        found = true;
      }
    }
    return knob;
  }

  private float subFromHundred(float num) {
    return 100 - num;
  }

  void destroy() {
    for (Knob k : knobs) {
      k.destroy();
    }
    for (Muscle m : muscles) {
      m.destroy();
    }
  }

  void create() {
    for (Knob k : knobs) {
      k.create();
    }
    for (Muscle m : muscles) {
      m.create();
    }
    startPosition = calcPosX();    
  }

  void display() {
    for (Knob k : knobs) {
      k.display();
    }
    for (Muscle m : muscles) {
      m.display();
    }
  }

  void move() {
    for (Muscle m : muscles) {
      m.move();
    }
    calcFitness();
  }

  Creature newOffspring() {
    Creature offspring = new Creature((ArrayList<Knob>)this.knobs.clone(), (ArrayList<Muscle>)this.muscles.clone());
    mutate(offspring);
    return offspring;
  }

  Creature newOffspring(Creature creature) {
    Creature offspring = new Creature((ArrayList<Knob>)this.knobs.clone(), (ArrayList<Muscle>)this.muscles.clone());
    //TODO add mixing the genes
    mutate(offspring);
    return offspring;
  }

  //TODO knob hozzaadas elvetel, muscle hozzaadas elvetel
  void mutate(Creature offspring) { 
    for (Knob k : offspring.knobs) {
      if (random(1) < mutationRate) {
        k.density = randomMutationAmount(k.density);
      }
      if (random(1) < mutationRate) {
        k.friction = randomMutationAmount(k.friction);
      }
      if (random(1) < mutationRate) {
        k.restitution = randomMutationAmount(k.restitution);
      }
    }
    for (Muscle m : offspring.muscles) {
      if (random(1) < mutationRate) {
        m.frequencyHz = randomMutationAmount(m.frequencyHz);
      }
      if (random(1) < mutationRate) {
        m.dampingRatio = randomMutationAmount(m.dampingRatio);
      }
    }
  }

  private float randomMutationAmount(float currentAmount) {
    return max(0, min(1, currentAmount + random(-mutationAmount, mutationAmount)));
  }

  void calcFitness() { //csak az elete vegen meghivni
    //if (isFlat()) {
    fitness = calcPosX() - startPosition;
    //} else {
    //  fitness = 0;
    //}
    println("f: " + fitness);
  }

  private boolean isFlat() {
    float highestKnobHeight = 0;
    float lowestKnobHeight = height;
    float midKnobHeight;
    for (Knob k : knobs) {
      if (k.getPos().y > highestKnobHeight) {
        highestKnobHeight = k.getPos().y;
      }
      if (k.getPos().y < lowestKnobHeight) {
        lowestKnobHeight = k.getPos().y;
      }
    }
    midKnobHeight = highestKnobHeight - lowestKnobHeight;
    return midKnobHeight > maxKnobRadius - minKnobRadius;
  }
}