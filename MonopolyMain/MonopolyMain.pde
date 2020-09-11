ArrayList <bankSystem> banks  = new ArrayList();

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
  
  Arrow = loadImage("dropDownArrow.png");
  Board = loadImage("Board.png");
  
  if (onMenu && !initialized) {
    guiSetup();
  }
  if (!onMenu) {
    for (int i = 0; i < numPl; i++) {
      banks.add(new bankSystem(i));
    }
    for (int j = 0; j < banks.size(); j++) {
      bankSystem b = banks.get(j);
      b.bankSetup();
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

//void mouseReleased() {
//  nextTurn();
//}
