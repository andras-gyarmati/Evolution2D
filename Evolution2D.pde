import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Terrain terrain;
float mutationRate;
int populationSize;
float time;

void setup() {
  size(1280, 720, P2D);
  colorMode(HSB);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  populationSize = 1;
  mutationRate = 0.01;
  terrain = new Terrain(populationSize);
  time = 0;
}

void draw() {
  background(156, 189, 255);
  box2d.step();
  time+= 0.1;
  terrain.display();
}