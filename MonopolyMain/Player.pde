class Player {
  int name = 0;
  int gridPos;
  void Pdisplay() {
    fill(255);
    circle(0, 0, 50);
  }
  Player(int playerNr, int gridNr) {
    name = playerNr;
    gridPos = gridNr;
  }
}
