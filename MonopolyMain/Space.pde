class Space {
  int x, y, w, h;
  ArrayList<Player> container = new ArrayList<Player>();
  Space(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  void display() {
    fill(255);
    //rect(x, y, w, h);
    for (Player p : container) {
      pushMatrix();
      translate(x + w/2, y + h/2);
      p.Pdisplay();
      popMatrix();
    }
  }
}
