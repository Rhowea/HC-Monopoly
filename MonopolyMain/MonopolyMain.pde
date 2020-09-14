ArrayList <bankSystem> banks  = new ArrayList();
ArrayList <String> names  = new ArrayList();
ArrayList <Dice> dices = new ArrayList();

import controlP5.*;

//Laver 2D-Array med den mængde rows og collums
Space[][] grid;
int sCols = 11;
int sRows = 11;
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

  //første gang vi er i setup laver vi de initialisere vi en masse så det senere bare kan loades
  if (onMenu && !initialized) {
    guiSetup();
    loadJSONS();
    Arrow = requestImage("dropDownArrow.png");
    Board = requestImage("Board.png");
  } 


  //initialiser arrayet og fylder den med spaces
  if (!onMenu) {
    grid = new Space[sCols][sRows];
    for (int i = 0; i < sCols; i++) {
      for (int j = 0; j < sRows; j++) {
        grid[i][j] = new Space(i*60 + 395, j*60 + 45, 60, 60);
      }
    }
  }
  //laver banksystemer og spillebrikker
  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem(i));
    Player playerToken = new Player(i + 1, 10, 10);
    println("PLAYER " + playerToken.name);
    grid[10][10].container.add(playerToken);
  }
  if (!onMenu) {
    for (int j = 0; j < banks.size(); j++) {
      bankSystem b = banks.get(j);
      b.bankSetup();
    }
  }
  //laver to terninger
  if (!onMenu) {
    for (int i = 0; i < 2; i++) {
      dices.add(new Dice());
    }
  }
}

void settings() {
  size (1100, 750);
}

void draw() {
  if (!onMenu) { // Draw for alt der skal være imens der spilles
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
        }
      }
    }
    counter = 0;
    //kalder display() for alle spaces i arrayet
    for (int i = 0; i < sCols; i++) {
      for (int j = 0; j < sRows; j++) {
        grid[i][j].display();
        /*for (int k = 0; j < grid[i][j].container.size(); k++) {
         grid[i][j].container.get(k).Pdisplay();
         }*/
      }
    }
    pushMatrix();
    translate(460, 110);
    fill(255);
    for (Dice d : dices) {
      d.move();
      d.display();
    }
    popMatrix();
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
  //if (!onMenu) {
  //}
}

void moveXAxis(Player p, int distance, int x, int y) {
  grid[x + distance][y].container.add(p);
  grid[x][y].container.remove(p);
  grid[x + distance][y].display();
}

void moveYAxis(Player p, int distance, int x, int y) {
  grid[x][y + distance].container.add(p);
  grid[x][y].container.remove(p);
  grid[x][y + distance].display();
}

void keyPressed() {
  if (keyCode == 32) {
    nextTurn();
  }
  getSpace(1);
}
