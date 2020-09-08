class bankSystem {

  float x = 10, y = 10;
  int balance = 0;
  int startBalance = int(random(100, 200));
  int offset = 70;

  void bankSetup() {
    balance = balance + startBalance;
  }


  void display() {

    fill(200);
    rect(x, y, 250, 70);
    fill(0);
    textSize(32);
    text("$ " + balance + " Kr.", x, y + 50);
  }
  
  void dropDownDisplay(int num){
    fill(200);
    rect(x, y+offset*num, 250, 70);
    fill(0);
    textSize(32);
    text("$ " + balance + " Kr.", x, y + 50);
  }
}
