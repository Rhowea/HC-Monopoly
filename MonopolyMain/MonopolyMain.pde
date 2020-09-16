ArrayList <bankSystem> banks  = new ArrayList();
ArrayList <String> names  = new ArrayList();
ArrayList <Dice> dices = new ArrayList();
ArrayList <Player> Players = new ArrayList();

int ChanceFields [] = {6, 21, 35};
int AbsenceFields [] = {1, 16, 32};


import controlP5.*;

//Laver 2D-Array med den mængde rows og collums
Space[][] grid;
int sCols = 11;
int sRows = 11;
int numPl;
int playerTurn = 1;
int counter  = 0;
int roll = 0;

int[][] colors = {{255, 0, 0}, {0, 255, 0}, {0, 0, 255}, {255, 255, 255}};

PImage Arrow;
PImage Board;

boolean showDropDown = false;
boolean onMenu = true;
boolean initialized = false;

void setup() {
  background(0);
  banks.clear();
  Players.clear();
  dices.clear();

  //første gang vi er i setup laver vi de initialisere vi en masse så det senere bare kan loades
  if (onMenu && !initialized) {
    guiSetup();
    loadJSONS();
    Arrow = requestImage("dropDownArrow.png");
    Board = requestImage("Board.png");
  } 
  //laver banksystemer og spillebrikker
  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem(i)); 
    Players.add(new Player(i + 1, 39));
    Players.get(i).setColor(colors[i][0], colors[i][1], colors[i][2]);
  }

  //initialiser arrayet og fylder den med spaces
  if (!onMenu) {
    grid = new Space[sCols][sRows];
    for (int i = 0; i < sCols; i++) {
      for (int j = 0; j < sRows; j++) {
        grid[i][j] = new Space(i*60 + 395, j*60 + 45, 60, 60);
      }
    }
    for (int i = 0; i <= 9; i++) {
      grid[9 - i][10].spaceNr = i;
    }
    for (int i = 10; i <= 19; i++) {
      grid[0][10 - (i - 9)].spaceNr = i;
    }
    for (int i = 20; i <= 29; i++) {
      grid[i - 19][0].spaceNr = i;
    }
    for (int i = 30; i <= 39; i++) {
      grid[10][i - 29].spaceNr = i;
    }
    for (int j = 0; j < banks.size(); j++) {
      bankSystem b = banks.get(j); 
      b.bankSetup();
      Player p = Players.get(j);
      grid[10][10].container.add(p);
    }
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
    OwnedPlayerCards();
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
      }
    }

    pushMatrix(); 
    translate(460, 110); 
    fill(255); 
    for (Dice d : dices) {
      d.move(); 
      d.display(); 
      if (d.vel.mag() < 0.5) {
        d.vel.mult(0);
      }
      if (d.vel.mag() == 0 && d.anim == true) {
        diceResult(d); 
        d.anim = false;
      }
    }
    popMatrix();
  }

  if (showingCard) {
    displayCard();
    cp5Cards.draw();
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


void diceResult(Dice d) {
  boolean reset = false;
  d.side = int(random(1, 7)); 
  roll += d.side; 
  if (counter == 1) {
    moveTo(roll, true);
    roll = 0;
    counter = 0;
    reset = true;
  }
  counter++;
  if (reset) {
    counter = 0;
  }
}

void drawCard() {
  Player p = Players.get(playerTurn-1);
  int temp = p.gridPos;
  boolean Specieals = false;  
  for (int l = 0; l <= 2; l++) {
    if (temp == ChanceFields[l]) {
      getChance();
      Specieals = true;
    } else if (temp == AbsenceFields[l]) {
      getAbsence();
      Specieals = true;
    }
  }
  if (!Specieals) {
    getSpace(temp);
  }
  counter = 0;
}
void OwnedPlayerCards() {
  Player p = Players.get(playerTurn-1);
  for (int i = 0; i < p.ownedSpaces.size(); i++) {
    int FieldNumber = p.ownedSpaces.get(i);
    displayPlayerCards(i, FieldNumber);
  }
}
void displayPlayerCards(int i, int FNR) {

  int index = FNR;
  int Xpos = 10; 
  int Ypos = 100;
  int offset = 110*i;

  JSONObject Space = Spaces.getJSONObject(index); 
  String c = Space.getString("color");
  color rgb = unhex("FF"+c.substring(1));

  rectMode(CORNER);
  fill(rgb);
  stroke(255);
  strokeWeight(2);
  rect(Xpos, Ypos+offset, 200, 50, 6);
  textSize(22);
  fill(255);
  textAlign(CENTER);
  text(Space.getString("Name"), Xpos+90, Ypos+offset+35);
  //display
}
