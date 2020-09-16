class Player {
  int name = 0;
  int gridPos;
  IntList ownedSpaces =  new IntList ();

  void Pdisplay() {
    fill(255);
    stroke(0);
    circle(0, 0, 50);
  }
  Player(int playerNr, int gridNr) {
    name = playerNr;
    gridPos = gridNr;
  }
}
