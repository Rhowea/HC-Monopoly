int index;
int type; // 0 = space, 1 = chance, 2 = absence 3 = InfoCard 4 = got to prisonCard 5 = in prison Card 
int price;
int rent;
int value;
int moveToSpace;
int balanceUpdates;
int numChanceCards = 12;
int numSpaces = 39;
int numAbsenceCards = 13;

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
  int BalanceUpdates = 0;
  int type = 0; 
  int moveToSpace = 0; 
  int price = Space.getInt("Price"); 
  int rent = Space.getInt("Rent"); 
  int value = Space.getInt("Value");
  Boolean GOOJ = false;
  for (int j  = 0; j < numPl; j++) {
    if (j != playerTurn - 1) {
      Player p =  Players.get(j);
      for (int l = 0; l < p.ownedSpaces.size(); l++) {
        if (index == p.ownedSpaces.get(l)) {
          BalanceUpdates = rent;
        }
      }
    }
  }
  if (index == 29 && Players.get(playerTurn-1).inJail == false ) {
    type = 4;
    Players.get(playerTurn-1).inJail = true;
    print("hit");
  } else if (Players.get(playerTurn-1).inJail == true) {
    Players.get(playerTurn - 1).inJail = false;
    getSpace(40, false);
    print("hi2t");
  } else if  (index ==40) {
    type = 5;
  } else  if (fromDropDown) {
    type = 3;
  }
  createCard(type, rgb, header, flavor, price, rent, value, BalanceUpdates, GOOJ, moveToSpace); 
  showingCard = true;
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
  if (type == 0 || type == 3) {
    textSize(20); 
    textAlign(CENTER); 
    line(width/2+75, height/2+5, width/2+420, height/2+5); 
    text("Pris: " + price+" kr.", width/2+150, height/2); 
    text("Leje: " + rent+" kr.", width/2+350, height/2); 
    line(width/2+75, height/2+70, width/2+420, height/2+70); 
    text("Pantsættelsesværdi: " + value +" kr.", width/2+250, height/2+65); 
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
    } else if (type == 3) {
      buyFieldButton.hide(); 
      dontBuyFieldButton.hide(); 
      dismissCardButton.hide();
      payRentButton.hide();
      dismissInfoCardButton.show();
      valueCardButton.show();
    }
  } else if (type == 1 || type == 2) {
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.show();
    payRentButton.hide();
    dismissInfoCardButton.hide();
    valueCardButton.hide();
  } else if (type == 4 && type == 5) {
    dismissInfoCardButton.show();
    buyFieldButton.hide(); 
    dontBuyFieldButton.hide(); 
    dismissCardButton.hide();
    payRentButton.hide();
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
    showingCard = false; 
    cp5Main.show();
    nextTurn();
  }
}
void dismissInfo() {
  if (type == 4) {
    moveTo(9, false);
    print("hi3t");
  } else if (type == 5) {
    moveTo(29, false);
    Players.get(playerTurn - 1).inJail = false;
    print("moved");
  }

  showingCard = false; 
  cp5Main.show();
  nextTurn();
}
void GetValue() {
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
