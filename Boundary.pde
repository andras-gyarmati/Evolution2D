class Boundary {

  float x;
  float y;
  float w;
  float h;

  Body body;

  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.1;

    body.createFixture(fd);
    //body.createFixture(sd, 1);
  }

  void display() {
    fill(100, 0, 50);
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}