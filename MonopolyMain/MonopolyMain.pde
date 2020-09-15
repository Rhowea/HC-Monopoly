ArrayList <bankSystem> banks  = new ArrayList();
ArrayList <String> names  = new ArrayList();
ArrayList <Dice> dices = new ArrayList();
int SpecialFields []= {2, 7, 17, 22, 33, 36};


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
  }
  //laver banksystemer og spillebrikker
  for (int i = 0; i < numPl; i++) {
    banks.add(new bankSystem(i)); 
    Player playerToken = new Player(i + 1, 39); 
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
      println("Dice");
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
    if (showingCard) {
      displayCard();
      cp5Cards.draw();
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
  //if (!onMenu) {
  //}
}

void moveXAxis(Player p, int distance, int x, int y) {
  grid[x + distance][y].container.add(p); 
  grid[x][y].container.remove(p); 
  grid[x + distance][y].display();
  if (p.gridPos == 39) {
    p.gridPos = 0;
  }
  p.gridPos++;
}

void moveYAxis(Player p, int distance, int x, int y) {
  grid[x][y + distance].container.add(p); 
  grid[x][y].container.remove(p); 
  grid[x][y + distance].display();
  if (p.gridPos == 39) {
    p.gridPos = 0;
  }
  p.gridPos++;
}

void keyPressed() {
  if (keyCode == 32) {
    nextTurn();
  } else if (key == '1') {
    getAbsence();
  } else if (key == '2') {
    getChance();
  } else if (key == '3') {
    getSpace(int(random(0, numSpaces)));
  }
}

void diceResult(Dice d) {
  int roll = 0; 
  d.side = int(random(1, 7)); 
  roll += d.side; 
  println("You rolled a " + roll); 
  boolean skip = false; 
  for (int r = 0; r < roll; r++) {
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
  drawCard();
  roll = 0;
}

void drawCard() {
  for (int i = 0; i <= 10; i++) {
    for (int j = 0; j <= 10; j++) {
      for (int k = 0; k < grid[i][j].container.size(); k++) {
        if (grid[i][j].container.get(k).name == playerTurn) {
          /*/
           Hvis det ikke er et specielt kort
           hent spaces
           //container.get(k).gridPos)
           ellers hent specielt kort.
          /*/
        }
      }
    }
  }
}
