ArrayList <bankSystem> banks  = new ArrayList();
//Laver 2D-Array med den mængde rows og collums
Space[][] grid;
int sCols = 11;
int sRows = 11;
import controlP5.*;
ControlP5 cp5banks;

bankSystem b;

int numPl = 4;
int playerTurn = 2;

PImage Arrow;
PImage Board;
boolean showDropDown = false;


void setup() {
  cp5banks = new ControlP5(this);
  size (1100, 750);
  background(0);
  Arrow = loadImage("dropDownArrow.png");
  Board = loadImage("Board.png");

  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem(i));
  }
  for (int j = 0; j < banks.size(); j++) {
    bankSystem b = banks.get(j);
    b.bankSetup();
  }

  cp5banks.addButton("dropDown")
    .setPosition(260, 20)
    .setSize(20, 70)
    .setLabelVisible(false);
  ;
  cp5banks.setAutoDraw(false);
  //initialiser arrayet og fylder den med spaces
  grid = new Space[sCols][sRows];
  for (int i = 0; i < sCols; i++) {
    for (int j = 0; j < sRows; j++) {
      grid[i][j] = new Space(i*60 + 395, j*60 + 45, 60, 60);
    }
  }
}

void draw() {
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
  //kalder display() for alle spaces i arrayet
  /*for (int i = 0; i < sCols; i++) {
   for (int j = 0; j < sRows; j++) {
   grid[i][j].display();
   }
   }*/
}

void nextTurn() {
  if (playerTurn == 4) {
    playerTurn = 1;
  } else {
    playerTurn++;
  }
}  
void dropDown() {
  showDropDown  ^= true;
}
void mouseReleased() {
  nextTurn();
}
