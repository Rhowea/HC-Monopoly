ArrayList <bankSystem> banks  = new ArrayList();
//Laver 2D-Array med den mængde rows og collums
Space[][] grid;
int sCols = 11;
int sRows = 11;
import controlP5.*;

int numPl;
int playerTurn = 1;

PImage Arrow;
PImage Board;

boolean showDropDown = false;
boolean onMenu = true;
boolean initialized = false;


void setup() {
  background(0);
  banks.clear();

  Arrow = requestImage("dropDownArrow.png");
  Board = requestImage("Board.png");

  if (onMenu && !initialized) {
    guiSetup();
  }

  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem(i));
  }
  if (!onMenu) {
    for (int j = 0; j < banks.size(); j++) {
      bankSystem b = banks.get(j);
      b.bankSetup();
    }
    //initialiser arrayet og fylder den med spaces
    grid = new Space[sCols][sRows];
    for (int i = 0; i < sCols; i++) {
      for (int j = 0; j < sRows; j++) {
        grid[i][j] = new Space(i*60 + 395, j*60 + 45, 60, 60);
      }
    }
    //laver banksystemer og spillebrikker
    for (int i = 0; i < numPl; i++) {
      banks.add(new bankSystem(i));
      Player playerToken = new Player(i + 1, 10, 10);
      println("PLAYER " + playerToken.name);
      grid[10][10].container.add(playerToken);
    }
  }
}
void settings() {
  size (1100, 750);
}

void draw() {
  if (!onMenu) {
    background(0);
    bankSystem b = banks.get(playerTurn-1);
    b.display();

    cp5banks.draw();
    image(Arrow, 260, 35, 20, 20);
    image(Board, 350, 0);

    int counter = 1;
    if (showDropDown) {
      for (int i = 0; i < numPl; i++) {
        if (i != playerTurn-1) {
          bankSystem d = banks.get(i);
          d.dropDownDisplay(counter);
          counter++;
        } else {
        }
      }
    }
    counter = 0;
  }
  //kalder display() for alle spaces i arrayet
  if (!onMenu) {
    for (int i = 0; i < sCols; i++) {
      for (int j = 0; j < sRows; j++) {
        grid[i][j].display();
        /*for (int k = 0; j < grid[i][j].container.size(); k++) {
         grid[i][j].container.get(k).Pdisplay();
         }*/
      }
    }
  }
}

void nextTurn() {
  if (playerTurn == numPl) {
    playerTurn = 1;
  } else {
    playerTurn++;
  }
}  
void dropDown() {
  showDropDown  ^= true;
}

void mouseReleased() {
  //nextTurn();
  if (!onMenu) {
    boolean skip = false;
    for (int i = 10; i > 0; i--) {
      for (int k = 0; k < grid[i][10].container.size(); k++) {
        if (grid[i][10].container.get(k).name == playerTurn && skip == false) {
          moveXAxis(grid[i][10].container.get(k), -1, i, 10);
          skip = true;
        }
      }
      for (int k = 0; k < grid[0][i].container.size(); k++) {
        if (grid[0][i].container.get(k).name == playerTurn && skip == false) {
          moveYAxis(grid[0][i].container.get(k), -1, 0, i);
          skip = true;
        }
      }
    }
    for (int i = 0; i < 11; i++) {
      for (int k = 0; k < grid[i][0].container.size(); k++) {
        if (grid[i][0].container.get(k).name == playerTurn && skip == false) {
          moveXAxis(grid[i][0].container.get(k), 1, i, 0);
          skip = true;
        }
      }
      for (int k = 0; k < grid[10][i].container.size(); k++) {
        if (grid[10][i].container.get(k).name == playerTurn && skip == false) {
          moveYAxis(grid[10][i].container.get(k), 1, 10, i);
          skip = true;
        }
      }
    }
    skip = false;
  }
}

void moveXAxis(Player p, int distance, int x, int y) {
  grid[x + distance][y].container.add(p);
  grid[x][y].container.remove(p);
}

void moveYAxis(Player p, int distance, int x, int y) {
  grid[x][y + distance].container.add(p);
  grid[x][y].container.remove(p);
}

void keyPressed() {
  if (keyCode == 32) {
    nextTurn();
  }
}
