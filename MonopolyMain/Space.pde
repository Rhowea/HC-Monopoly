class Space {
  int x, y, w, h;
  ArrayList<Player> container = new ArrayList<Player>();
  int spaceNr = -1;
  Space(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  void display() {
    /*fill(255);
    rect(x, y, w, h);
    fill(0);
    text(spaceNr, x, y + h);*/
    for (int i = 0; i < container.size(); i++) {
      Player p = container.get(i);
      pushMatrix();
      translate(x + w/2, y + h/2);
      p.Pdisplay();
      popMatrix();
      //println(p.name, p.gridPos);
    }
  }
}
