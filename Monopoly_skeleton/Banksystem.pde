class bankSystem {

  float x = 10, y = 10;
  int balance = 0;
  int startBalance = int(random(100, 200));


  void bankSetup() {
    balance = balance + startBalance;
  }


  void display() {
    background(0);
    fill(255);
    fill(200);
    rect(x, y, 250, 70);
    fill(0);
    textSize(32);
    text("$ " + balance + " Kr.", x, y + 50);
  }


}
