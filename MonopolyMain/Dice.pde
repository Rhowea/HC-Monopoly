class Dice {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  int wide = 50;
  boolean anim = false;
  int side = 0;

  void move() {
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    vel.mult(0.9);
    if (pos.x > 532 - wide) {
      pos.x = 532 - wide;
      vel.x *= -1;
    }
    if (pos.y > 532 - wide) {
      pos.y = 532 - wide;
      vel.y *= -1;
    }
    if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    }
    if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -1;
    }
  }

  void display() {
    fill(255);
    rect(pos.x, pos.y, wide, wide, wide/5);
    fill(50);
    pushMatrix();
    translate(pos.x, pos.y);
    if (side == 1 || side == 3 || side == 5)
      ellipse(wide/2, wide/2, wide/5, wide/5); 
    if (side == 2 || side == 3 || side == 4 || side == 5 || side == 6) { 
      ellipse(wide/2 - wide/4, wide/2 - wide/4, wide/5, wide/5);
      ellipse(wide/2 + wide/4, wide/2 + wide/4, wide/5, wide/5);
    }
    if (side == 4 || side == 5 || side == 6) {
      ellipse(wide/2 - wide/4, wide/2 + wide/4, wide/5, wide/5);
      ellipse(wide/2 + wide/4, wide/2 - wide/4, wide/5, wide/5);
    }
    if (side == 6) {
      ellipse(wide/2, wide/2 - wide/4, wide/5, wide/5);
      ellipse(wide/2, wide/2 + wide/4, wide/5, wide/5);
    }
    popMatrix();
  }

  void animate() {
    acc.x = random(-50, 50);
    acc.y = random(-50, 50);
    anim = true;
  }
}
