import controlP5.*;
ControlP5 cp5session1;

float consumption = 0;
float Savings = 100;
float x = 10, y = 10;

CheckBox checkbox;

void setup() {
  cp5session1 = new ControlP5(this);

  size (800, 800);
  
  background(0);
}

void draw() {
  background(0);
  fill(255);
  textSize(32);
  text("Welcome to our ATM", 5, 40);
  fill(200);
  rect(x, y, 250, 70);
  fill(0);
  textSize(32);
  text(consumption + " KR", x, y + 50);
  textSize(12);
  fill(255);
  text("Consumption Account", x, y-5);

  fill(200);
  rect(x, y+100, 250, 70);
  fill(0);
  textSize(32);
  text(Savings + "KR", x, y + 150);
  textSize(12);
  fill(255);
  text("Savings Account", x, y+95);
}
void Deposit() {
  boolean DepositConsumption = checkbox.getState("Deposit_Consumption");
  boolean DepositSavings = checkbox.getState("Deposit_Savings");
  String amount = cp5session1.get(Textfield.class, "Enter_amount").getText();

  if (DepositConsumption) {
    consumption = consumption + Float.parseFloat(amount);
  }
  if (DepositSavings) {
    Savings = Savings + Float.parseFloat(amount);
  }
  cp5session1.get(Textfield.class, "Enter_amount").clear();
  checkbox.deactivateAll();
}
