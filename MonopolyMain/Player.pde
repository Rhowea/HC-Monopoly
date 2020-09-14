class Player {
  int name = 0;
  int gridPosX;
  int gridPosY;
  void Pdisplay() {
    fill(255);
    circle(0, 0, 50);
  }
  Player(int playerNr, int gridx, int gridy) {
    name = playerNr;
    gridPosX = gridx;
    gridPosY = gridy;
  }
}
