class Knob {

  Body body;
  float r;
  ArrayList<Knob> pairs;

  Knob(float x, float y, float density, float friction, float restitution) {
    pairs = new ArrayList<Knob>();
    r = 8;

    BodyDef bd = new BodyDef();
    bd.fixedRotation = true;

    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;

    body.createFixture(fd);
  }

  void destroy() {
    box2d.destroyBody(body);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(map(body.getFixtureList().getDensity(), 0, 1, 0, 255));
    stroke(map(body.getFixtureList().getFriction(), 0, 1, 255, 0));
    strokeWeight(map(body.getFixtureList().getRestitution(), 0, 1, 1, 3));
    ellipse(0, 0, r*2, r*2);
    line(0, 0, r, 0);
    popMatrix();
  }
}