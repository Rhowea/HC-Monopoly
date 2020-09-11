class Space {
  int x, y, w, h;
  Space(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  void display() {
    rect(x, y, w, h);
  }
}
