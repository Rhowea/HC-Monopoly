int index;
int drawnCardIndex;
int type; // 0 = space, 1 = chance, 2 = absence 3= infoCard 4 = PrisonCards 5 =  dismissSpaces 6 = paySpaces 7 = ownedPlayerCard 8= pantsat
int simpletype;
int price;
int rent;
int value;
int moveToSpace;
int balanceUpdates;
int reBuyValue;
int numChanceCards = 12;
int numSpaces = 39;
int numAbsenceCards = 13;
int dismissSpaces []  ={9, 19};
int paySpaces [] = {39, 3, 37};
int playerOwning;
int labRent[] = {25, 50, 100, 200};
int prevCard;
int m = 0;
int prevType;


JSONArray Spaces;
JSONArray Chances;
JSONArray Absences;

boolean showingCard = false;
boolean getOutOfJail;
boolean reBuy = false;
boolean usedGOOJ = false;
boolean twoCardsStacked = false;


color cardColor;
String header;
String flavorText;


void loadJSONS() {
  Spaces = loadJSONArray("spaces.json");
  Chances = loadJSONArray("chance.json");
  Absences = loadJSONArray("absence.json");
}

void getSpace(int id, Boolean fromDropDown) {
  if (twoCardsStacked && m ==0) {
    prevCard = index;
    println(prevCard);
    twoCardsStacked = false;
    m++;
  }

  JSONObject Space = Spaces.getJSONObject(id); 
  String c = Space.getString("color"); 
  color rgb = unhex("FF"+c.substring(1)); 
  String header = Space.getString("Name"); 
  String flavor = Space.getString("Flavortext"); 
  int price = Space.getInt("Price"); 
  int rent = Space.getInt("Rent"); 
  int value = Space.getInt("Value"); 
  int moveToSpace = -2; 
  int type = 0; 
  int BalanceUpdates = 0; 
  index = id;

  Boolean GOOJ = false; 

  for (int j  = 0; j < numPl; j++) {
    if (j != playerTurn - 1) {
      Player p =  Players.get(j);
      for (int l = 0; l < p.ownedSpaces.size(); l++) {
        if (id == p.ownedSpaces.get(l)) {
          BalanceUpdates = rent;
          playerOwning = j;
        }
      }
    } else if (j == playerTurn - 1) {
      Player p = Players.get(playerTurn -1);
      for (int l = 0; l < p.ownedSpaces.size(); l++) {
        if (id == p.ownedSpaces.get(l) && !reBuy) {
          type = 7;
        }
      }
    }
    for (int k = 0; k < 3; k++) {
      if ( k < 2) {
        if (id == dismissSpaces[k]) {
          type = 5;
        }
      }
      if (id == paySpaces[k]) {
        type =6;
      }
    }
    if (id == 29 || id == 40) {
      type = 4;
    } 
    if (fromDropDown) {
      type = 3;
    } 
    if (reBuy) {
      type = 8;
      reBuyValue = int(value*1.1);
    }
    createCard(type, rgb, header, flavor, price, rent, value, BalanceUpdates, GOOJ, moveToSpace); 
    showingCard = true;
  }
}

void getChance() {
  simpletype = 1;
  int cardIndex = int(random(0, numChanceCards)); 
  JSONObject Chance = Chances.getJSONObject(cardIndex); 
  if (Chance.getBoolean("Drawn") == false) {
    String c = Chance.getString("color"); 
    color rgb = unhex("FF"+c.substring(1)); 
    String header = Chance.getString("Name"); 
    String flavor = Chance.getString("Flavortext"); 
    int price = 0; 
    int rent = 0; 
    int value = 0; 
    int moveToSpace = Chance.getInt("MoveToSpace"); 
    int balanceUpdates = Chance.getInt("balanceUpdates"); 
    boolean GOOJ = Chance.getBoolean("Jail");
    if (GOOJ == true) {
      Players.get(playerTurn - 1).hasGOOJ = true;
    }
    createCard(1, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ, moveToSpace); 
    showingCard = true;
  }
}
void getAbsence() {
  simpletype = 2;
  int cardIndex = int(random(0, numAbsenceCards)); 
  JSONObject Absence = Absences.getJSONObject(cardIndex); 
  if (Absence.getBoolean("Drawn") == false) {
    String c = Absence.getString("color"); 
    color rgb = unhex("FF"+c.substring(1)); 
    String header = Absence.getString("Name"); 
    String flavor = Absence.getString("Flavortext"); 
    int price = 0; 
    int rent = 0; 
    int value = 0; 
    int balanceUpdates = Absence.getInt("balanceUpdates"); 
    boolean GOOJ = false; 
    int moveToSpace = -2; 
    createCard(1, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ, moveToSpace); 
    showingCard = true;
  }
}
void createCard(int t, color c, String h, String f, int p, int r, int v, int b, boolean GOOJ, int MTS) {
  type = t; 
  cardColor = c; 
  header = h; 
  flavorText = f; 
  price = p; 
  rent = r; 
  value = v; 
  balanceUpdates = b; 
  getOutOfJail = GOOJ; 
  moveToSpace = MTS;
}
void displayCard() {
  println(type);
  cp5Main.hide(); 
  pushMatrix(); 
  translate(-80, 0); 
  cp5Cards.show(); 
  rectMode(CENTER); 
  fill(#FFF3D6); 
  rect(width/2+250, height/2-25, 400, 450, 15); 
  strokeWeight(2); 
  stroke(0); 
  fill(cardColor); 
  rect(width/2+250, height/2-200, 375, 75, 6); 
  fill(255); 
  textAlign(CENTER); 
  textSize(32); 
  text(header, width/2+250, height/2-185); 
  fill(0); 
  cardTextarea.setText(flavorText);
  if (type == 0 || type == 3) {
    textSize(20); 
    textAlign(CENTER); 
    line(width/2+75, height/2+5, width/2+420, height/2+5); 
    text("Pris: " + price+" kr.", width/2+150, height/2);
    if (rent != -2) {
      text("Leje: " + rent+" kr.", width/2+350, height/2);
    } else {
      text("Leje: 4 gange dit terningsslag.", width/2+320, height/2);
    }
    line(width/2+75, height/2+70, width/2+420, height/2+70); 
    text("Pantsættelsesværdi: " + value +" kr.", width/2+250, height/2+65);
  } else if (type == 8) {
    textSize(20); 
    textAlign(CENTER); 
    line(width/2+75, height/2+5, width/2+420, height/2+5); 
    text("Genkøbsværdi: " + reBuyValue+" kr.", width/2+170, height/2); 
    text("Leje: " + rent+" kr.", width/2+350, height/2); 
    line(width/2+75, height/2+70, width/2+420, height/2+70); 
    text("Pantsættelsesværdi: " + value +" kr.", width/2+250, height/2+65);
  }
  if (type == 0 && balanceUpdates == 0) {
    buyFieldButton.show(); 
    dontBuyFieldButton.show(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.hide();
    valueCardButton.hide();
  } else if (type == 0 && balanceUpdates != 0) {
    payRentButton.show();
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    dismissInfoCardButton.hide();
    valueCardButton.hide();
  } else if (type == 1 || type == 2) {
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.show();
    payRentButton.hide();
    dismissInfoCardButton.hide();
    valueCardButton.hide();
  } else if (type == 3 || type == 7) {
    if (type != 7) {
      valueCardButton.show();
    } else {
      valueCardButton.hide();
    }
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.show();
  } else if (type == 4 || type == 5 || type == 6) {
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.show();
    valueCardButton.hide();
  } 
  if (type == 8) {
    buyFieldButton.show(); 
    dontBuyFieldButton.show(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.hide();
    valueCardButton.hide();
    reBuy = false;
  }
  if (Players.get(playerTurn -1).hasGOOJ == true) {
    hideGOOJCardButton.show();
  } else {
    hideGOOJCardButton.hide();
  }
  textAlign(CORNER); 
  rectMode(CORNER); 
  popMatrix();
}

void dismiss() {
  bankSystem b = banks.get(playerTurn-1); 
  b.addToBalance(balanceUpdates); 

  if (moveToSpace != -2) {
    moveTo(moveToSpace, false);
  } else {
    cp5Main.show();
    nextTurn(); 
    showingCard =false;
  }
}

void dontBuy() {
  if (type == 8) {
    getSpace(prevCard, false);
    m = 0;
    println("hit2");
  } else {
    showingCard = false; 
    cp5Main.show();
    if (type != 8) {
      nextTurn();
    }
  }
}


void dismissInfo() {
  if (type == 4 && Players.get(playerTurn-1).inJail == true && !usedGOOJ) {
    Players.get(playerTurn-1).inJail = false;
    moveTo(29, false);
    println("player moved back && jail is now false");
  } else if (type == 4 && Players.get(playerTurn-1).inJail == false && !usedGOOJ) {
    Players.get(playerTurn-1).inJail = true;
    moveTo(9, false);
    println("player moved && jail is now true");
  } else if (type == 5 || type == 7) {
  } else if (type  == 6) {
    banks.get(playerTurn-1).addToBalance(price);
  } else if (usedGOOJ) {
    moveTo(29, true);
    moveTo(lastPlayerRoll, false);
  }
  if (type == 8 || type == 3) {
    getSpace(prevCard, false);
    m = 0;
    println("hit");
  } else {
    if (!usedGOOJ) {
      nextTurn();
    }
    showingCard = false; 
    cp5Main.show();
  }
}
void GetValue() {
  Player p = Players.get(playerTurn - 1);
  p.ownedSpacesValued.set(drawnCardIndex, 1);
  banks.get(playerTurn - 1).addToBalance(value);
  if (type == 8 || type == 3) {
    getSpace(prevCard, false);
    m = 0;
    println("hit");
  } else {
    showingCard = false; 
    cp5Main.show();
  }
}
