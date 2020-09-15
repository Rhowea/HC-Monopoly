int index;
int type; // 0 = space, 1 = chance, 2 = absence
int price;
int rent;
int value;
int balanceUpdates;
int numChanceCards = 2;
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

void getSpace(int index) {
  JSONObject Space = Spaces.getJSONObject(index); 
  String c = Space.getString("color");
  color rgb = unhex("FF"+c.substring(1));
  String header = Space.getString("Name");
  String flavor = Space.getString("Flavortext");
  int price = Space.getInt("Price");
  int rent = Space.getInt("Rent");
  int value = Space.getInt("Value");
  int balanceUpdates = 0;
  Boolean GOOJ = false;
  createCard(0, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ);
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
    int balanceUpdates = Chance.getInt("balanceUpdates");
    boolean GOOJ = Chance.getBoolean("Jail");
    createCard(1, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ);
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
    createCard(1, rgb, header, flavor, price, rent, value, balanceUpdates, GOOJ);
    showingCard = true;
  }
}
void createCard(int t, color c, String h, String f, int p, int r, int v, int b, boolean GOOJ) {
  type = t;
  cardColor = c;
  header = h;
  flavorText = f;
  price = p;
  rent = r;
  value = v;
  balanceUpdates = b;
  getOutOfJail = GOOJ;
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
  if (type == 0) {
    textSize(20);
    textAlign(CENTER);
    line(width/2+75, height/2+5, width/2+420, height/2+5);
    text("Pris: " + price+" kr.", width/2+150, height/2); 
    text("Leje: " + rent+" kr.", width/2+350, height/2);
    line(width/2+75, height/2+70, width/2+420, height/2+70);
    text("Pantsættelsesværdi: " + value +" kr.", width/2+250, height/2+65);
    buyFieldButton.show();
    dontBuyFieldButton.show();
    dismissCardButton.hide();
  } else {
    buyFieldButton.hide();
    dontBuyFieldButton.hide();
    dismissCardButton.show();
  }
  textAlign(CORNER);
  rectMode(CORNER);
  popMatrix();
}

void dismiss() {
  bankSystem b = banks.get(playerTurn-1); 
  b.addToBalance(balanceUpdates);
  showingCard =false;
  cp5Main.show();
  nextTurn();
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
