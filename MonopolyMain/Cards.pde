int index;
int type; // 0 = space, 1 = chance, 2 = absence 3= infoCard 4 = PrisonCards 5 =  dismissSpaces 6 = paySpaces 7 = ownedPlayerCard
int price;
int rent;
int value;
int moveToSpace;
int balanceUpdates;
int numChanceCards = 12;
int numSpaces = 39;
int numAbsenceCards = 13;
int dismissSpaces []  ={9, 19};
int paySpaces [] = {39, 2, 37};

JSONArray Spaces;
JSONArray Chances;
JSONArray Absences;

boolean showingCard = false;
boolean getOutOfJail;

color cardColor;
String header;
String flavorText;

void loadJSONS() {
  Spaces = loadJSONArray("spaces.json");
  Chances = loadJSONArray("chance.json");
  Absences = loadJSONArray("absence.json");
}

void getSpace(int index, Boolean fromDropDown) {

  JSONObject Space = Spaces.getJSONObject(index); 
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

  Boolean GOOJ = false; 

  for (int j  = 0; j < numPl; j++) {
    if (j != playerTurn - 1) {
      Player p =  Players.get(j);
      for (int l = 0; l < p.ownedSpaces.size(); l++) {
        if (index == p.ownedSpaces.get(l)) {
          BalanceUpdates = rent;
        }
      }
    } else if (j == playerTurn - 1) {
      Player p = Players.get(playerTurn -1);
      for (int l = 0; l < p.ownedSpaces.size(); l++) {
        if (index == p.ownedSpaces.get(l)) {
          type = 7;
        }
      }
    }
    for (int k = 0; k < 3; k++) {
      if ( k < 2) {
        if (index == dismissSpaces[k]) {
          type = 5;
        }
      }
      if (index ==paySpaces[k]) {
        type =6;
      }
    }
    if (index == 29 || index == 40) {
      type = 4;
    } else if (fromDropDown) {
      type = 3;
    }
    createCard(type, rgb, header, flavor, price, rent, value, BalanceUpdates, GOOJ, moveToSpace); 
    showingCard = true;
  }
}
void getChance() {
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
    createCard(1, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ, moveToSpace); 
    showingCard = true;
  }
}
void getAbsence() {
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
  cp5Cards.show();
  if (type == 0 || type == 3) {
    textSize(20); 
    textAlign(CENTER); 
    line(width/2+75, height/2+5, width/2+420, height/2+5); 
    text("Pris: " + price+" kr.", width/2+150, height/2); 
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
    valueCardButton.show();
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.show();
    println("hit");
  } else if (type == 4 || type == 5 || type == 6) {
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    payRentButton.hide();
    dismissInfoCardButton.show();
    valueCardButton.hide();
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
  }
  cp5Main.show();
  nextTurn(); 
  showingCard =false;
}

void dontBuy() {
  showingCard = false; 
  cp5Main.show();
  nextTurn();
}
void buy() {
  bankSystem b = banks.get(playerTurn-1); 
  int haveFunds = b.balance - price; 
  if (haveFunds >= 0) {
    b.addToBalance(-price); 
    Player p = Players.get(playerTurn-1); 
    p.ownedSpaces.append(p.gridPos); 
    p.ownedSpacesValued.append(0);
    showingCard = false; 
    cp5Main.show();
    nextTurn();
  }
}
void dismissInfo() {
  if (type == 4 && Players.get(playerTurn-1).inJail == true) {
    Players.get(playerTurn-1).inJail = false;
    moveTo(29, false);
    println("player moved back && jail is now false");
    nextTurn();
  } else if (type == 4 && Players.get(playerTurn-1).inJail == false) {
    Players.get(playerTurn-1).inJail = true;
    moveTo(9, false);
    println("player moved && jail is now true");
    nextTurn();
  } else if (type == 5 || type == 7) {
    nextTurn();
  } else if (type  == 6) {
    banks.get(playerTurn-1).addToBalance(price); 
    nextTurn();
  }
  showingCard = false; 
  cp5Main.show();
}
void GetValue() {
  Player p = Players.get(playerTurn - 1);
  p.ownedSpacesValued.set(index, 1);
  banks.get(playerTurn - 1).addToBalance(value);
  showingCard = false; 
  cp5Main.show();
}
void payRent() {
  bankSystem b = banks.get(playerTurn-1); 
  int haveFunds = b.balance - rent; 
  if (haveFunds >= 0) {
    b.addToBalance(-rent);
    showingCard = false; 
    cp5Main.show();
  }
  nextTurn();
}
