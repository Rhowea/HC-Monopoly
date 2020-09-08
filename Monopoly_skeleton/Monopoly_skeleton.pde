ArrayList <bankSystem> banks  = new ArrayList();

import controlP5.*;
ControlP5 cp5session1;

bankSystem b;

int numPl = 4;
int playerTurn = 1;

void setup() {
  cp5session1 = new ControlP5(this);
  size (1000, 800);
  background(0);

  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem());
  }
  for (int j = 0; j < banks.size(); j++) {
    bankSystem b = banks.get(j);
    b.bankSetup();
  }
}

void draw() {
  bankSystem b = banks.get(playerTurn-1);
  b.display();
  
  if(mousePressed){
    nextTurn();
  }
}

void nextTurn() {
  if (playerTurn == 4) {
    playerTurn = 1;
  } else {
    playerTurn++;
  }
}
