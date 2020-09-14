class Dice{
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  
  void move() {
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    vel.mult(0.9);
  }
  void display() {
    rect(pos.x, pos.y, 50, 50);
  }
  void animate() {
    acc.x = random(-50, 50);
    acc.y = random(-50, 50);
  }
}
