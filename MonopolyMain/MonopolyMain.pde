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


  //første gang vi er i setup laver vi de initialisere vi en masse så det senere bare kan loades
  if (onMenu && !initialized) {
    guiSetup();
    Arrow = requestImage("dropDownArrow.png");
    Board = requestImage("Board.png");
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


  //initialiser arrayet og fylder den med spaces
  grid = new Space[sCols][sRows];
  for (int i = 0; i < sCols; i++) {
    for (int j = 0; j < sRows; j++) {
      grid[i][j] = new Space(i*60 + 395, j*60 + 45, 60, 60);
    }
  }
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

//void mouseReleased() {
//  nextTurn();
//}
