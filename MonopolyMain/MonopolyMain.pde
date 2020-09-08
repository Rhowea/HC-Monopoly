ArrayList <bankSystem> banks  = new ArrayList();

import controlP5.*;
ControlP5 cp5banks;

bankSystem b;

int numPl = 4;
int playerTurn = 2;

PImage Arrow;
boolean showDropDown = false;


void setup() {
  cp5banks = new ControlP5(this);
  size (1000, 800);
  background(0);
  Arrow = loadImage("dropDownArrow.png");

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
}

void draw() {
  background(0);
  bankSystem b = banks.get(playerTurn-1);
  b.display();

  cp5banks.draw();
  image(Arrow, 260, 35, 20, 20);

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
