class bankSystem {
  int balance = 0;
  int startBalance = int(random(100, 200));
  int offset = 95;
  int bankNum;
  PFont BankFont; 

  float x = 10, y =20 ;

  bankSystem(int num) {
    bankNum=num+1;
  }

  void bankSetup() {
    balance = balance + startBalance;
    BankFont = createFont("arial", 20);
  }

  void display() {
    textFont(BankFont);
    fill(200);
    rect(x, y, 250, 70);
    fill(0);
    textSize(32);
    text("$" + balance + " Kr.", x, y + 50);
    fill(255);
    textSize(12);
    text("Spiller " +bankNum + " bank", x+2, 15);
  }

  void dropDownDisplay(int num) {
    textFont(BankFont);
    fill(200);
    rect(x, y+offset*num, 250, 70);
    fill(0);
    textSize(32);
    text("$"  + balance + " Kr.", x, y + 50 + offset*num);
    fill(255);
    textSize(12);
    text("Spiller " +bankNum + " bank", x+2, 15 + offset*num);
  }
  
  void addToBalance(int money){
    balance += money;
  }
}
