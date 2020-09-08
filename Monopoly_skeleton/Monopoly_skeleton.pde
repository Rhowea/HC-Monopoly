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
  if (showDropDown && playerTurn == 1) {
    bankSystem a = banks.get(playerTurn);
    bankSystem d = banks.get(playerTurn+1);
    bankSystem c = banks.get(playerTurn+2);
    a.dropDownDisplay(1);
    c.dropDownDisplay(2);
    d.dropDownDisplay(3);
  } else if (showDropDown && playerTurn == 2) {
    bankSystem a = banks.get(playerTurn);
    bankSystem d = banks.get(playerTurn+1);
    bankSystem c = banks.get(playerTurn-2);
    a.dropDownDisplay(1);
    c.dropDownDisplay(2);
    d.dropDownDisplay(3);
  }
  else if (showDropDown && playerTurn == 3) {
    bankSystem a = banks.get(playerTurn);
    bankSystem d = banks.get(playerTurn-2);
    bankSystem c = banks.get(playerTurn-3);
    a.dropDownDisplay(1);
    c.dropDownDisplay(2);
    d.dropDownDisplay(3);
  }
  else if (showDropDown && playerTurn == 4) {
    bankSystem a = banks.get(playerTurn-4);
    bankSystem d = banks.get(playerTurn-3);
    bankSystem c = banks.get(playerTurn-2);
    a.dropDownDisplay(1);
    c.dropDownDisplay(2);
    d.dropDownDisplay(3);
  }
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
