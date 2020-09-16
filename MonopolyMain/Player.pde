class Player {
  int name = 0;
  int gridPos;
  IntList ownedSpaces =  new IntList ();
  int[] colour = new int[3]; 

  void Pdisplay() {
    fill(colour[0], colour[1], colour[2]);
    stroke(0);
    circle(0, 0, 50);
  }
  Player(int playerNr, int gridNr) {
    name = playerNr;
    gridPos = gridNr;
  }
  void setColor(int r, int g,int b) {
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
  }
}
