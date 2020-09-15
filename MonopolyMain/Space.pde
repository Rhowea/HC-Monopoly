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
    }
  }
}

void moveTo(int distance) {
  Player p = Players.get(playerTurn - 1);
  for (int i = 0; i <= 10; i++) {
    for (int j = 0; j <= 10; j++) {
      if (grid[i][j].spaceNr == p.gridPos) {
        for (int k = 0; k < grid[i][j].container.size(); k++) {
          if (grid[i][j].container.get(k).name == playerTurn) {
            grid[i][j].container.remove(k);
          }
        }
      }
    }
  }
  p.gridPos += distance;
  if (p.gridPos > 39) {
    p.gridPos -= 40;
  }
  for (int i = 0; i <= 10; i++) {
    for (int j = 0; j <= 10; j++) {
      if (grid[i][j].spaceNr == p.gridPos) {
        grid[i][j].container.add(p);
      }
    }
  }
}
