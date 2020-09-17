ControlP5 cp5Menu;
ControlP5 cp5PlayerSelect;
ControlP5 cp5Main;
ControlP5 cp5banks;
ControlP5 cp5Cards;

Textarea cardTextarea;
Button buyFieldButton;
Button dontBuyFieldButton;
Button dismissCardButton;
Button dismissInfoCardButton;
Button valueCardButton;
Button payRentButton;

void guiSetup() {
  cp5Menu = new ControlP5(this);
  cp5Main = new ControlP5(this);
  cp5PlayerSelect = new ControlP5(this);
  cp5banks = new ControlP5(this);

  cp5PlayerSelect.addButton("plSelect")
    .setPosition(width/2-100, height/2+100)
    .setSize(200, 75)
    .setCaptionLabel("Videre")
    ;
  cp5PlayerSelect.addSlider("NumPL")
    .setPosition(width/2-100, height/2-100)
    .setSize(200, 75)
    .setMax(4)
    .setMin(2)
    .setNumberOfTickMarks(3)
    .setCaptionLabel("Antal elever")
    ;
  cp5Menu.addButton("Start")
    .setPosition(width/2-100, height/2+100)
    .setSize(200, 75)
    ;
  cp5Menu.addTextfield("Pl1")
    .setPosition(width/2-100, height/2+20)
    .setSize(200, 30)
    .setAutoClear(false)
    .setCaptionLabel("Elev 1's navn")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    .setValue("")
    ;
  cp5Menu.addTextfield("Pl2")
    .setPosition(width/2-100, height/2-60)
    .setSize(200, 30)
    .setAutoClear(false)
    .setCaptionLabel("Elev 2's navn")
    .setColorForeground(color(#02CE18))
    .setColorBackground(color(#009D11))
    .setColorActive(color(0, 255, 0))
    .setValue("")
    ;
  cp5Menu.addTextfield("Pl3")
    .setPosition(width/2-100, height/2-140)
    .setSize(200, 30)
    .setAutoClear(false)
    .setCaptionLabel("Elev 3's navn")
    .setValue("")
    ;
  cp5Menu.addTextfield("Pl4")
    .setPosition(width/2-100, height/2-220)
    .setSize(200, 30)
    .setAutoClear(false)
    .setCaptionLabel("Elev 4's navn")
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorActive(color(255))
    .setValue("")
    ;
  cp5Main.addButton("backToMenu")
    .setPosition(5, height-55)
    .setSize(100, 50)
    .setCaptionLabel("Back to Menu")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    ;
  cp5Main.addButton("Roll")
    .setPosition(110, height-55)
    .setSize(100, 50)
    .setCaptionLabel("Rul med terningen")
    ;
  cp5banks.addButton("dropDown")
    .setPosition(260, 20)
    .setSize(20, 70)
    .setLabelVisible(false)
    ;
  cp5banks.setAutoDraw(false);
  cp5Cards = new ControlP5(this);

  cardTextarea = cp5Cards.addTextarea("txt")
    .setPosition(width/2, height/2-150)
    .setSize(350, 100)
    .setFont(createFont("arial", 20))
    .setLineHeight(22)
    .setColor(color(0))
    .setColorBackground(color(255, 0))
    .setColorForeground(color(255, 0))
    .hideScrollbar()
    ;

  buyFieldButton = cp5Cards.addButton("buy")
    .setPosition(width/2-5, height/2+90)
    .setSize(350, 50)
    .setCaptionLabel("Invester")
    .setColorForeground(color(#02CE18))
    .setColorBackground(color(#009D11))
    .setColorActive(color(0, 255, 0))
    ;
  dontBuyFieldButton = cp5Cards.addButton("dontBuy")
    .setPosition(width/2-5, height/2+145)
    .setSize(350, 50)
    .setCaptionLabel("Invester ikke")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    ;
  dismissCardButton = cp5Cards.addButton("dismiss")
    .setPosition(width/2-5, height/2+145)
    .setSize(350, 50)
    .setCaptionLabel("Okay")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    ;
  payRentButton = cp5Cards.addButton("payRent")
    .setPosition(width/2-5, height/2+145)
    .setSize(350, 50)
    .setCaptionLabel("Betal leje")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    ;
  valueCardButton = cp5Cards.addButton("GetValue")
    .setPosition(width/2-5, height/2+90)
    .setSize(350, 50)
    .setCaptionLabel("Pant")
    .setColorForeground(color(#02CE18))
    .setColorBackground(color(#009D11))
    .setColorActive(color(0, 255, 0))
    ;
  dismissInfoCardButton = cp5Cards.addButton("dismissInfo")
    .setPosition(width/2-5, height/2+145)
    .setSize(350, 50)
    .setCaptionLabel("Luk")
    .setColorForeground(color(#DE0000))
    .setColorBackground(color(#AF0000))
    .setColorActive(color(255, 0, 0))
    ;

  cp5Cards.setAutoDraw(false);

  initialized = true;
  cp5Main.hide();
  cp5Menu.hide();
}
public void Start() {
  cp5Main.show();
  cp5Menu.hide();
  for (int i=0; i < numPl; i++) {
    String temp = cp5Menu.get(Textfield.class, "Pl"+(i+1)).getText();
    if (temp.length() < 1) {
      temp = "Elev #" +(i+1);
    }
    names.add(temp);
  }
  onMenu = false;
  setup();
}

public void backToMenu() {
  cp5PlayerSelect.show();
  cp5Main.hide();

  onMenu = true;
  setup();
}
public void plSelect() {
  numPl = int(cp5PlayerSelect.getController("NumPL").getValue());
  cp5PlayerSelect.hide();
  cp5Menu.show();

  for (int i = 1; i < 5; i++) {
    cp5Menu.getController("Pl"+i).show();
  }
  for (int i = 4; i > numPl; i--) {
    cp5Menu.getController("Pl"+i).hide();
  }

  setup();
}

public void Roll() {
  for (Dice d : dices) {
    d.animate();
  }
}
