ControlP5 cp5Menu;
ControlP5 cp5PlayerSelect;
ControlP5 cp5Main;
ControlP5 cp5banks;

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
    .setValue("")
    ;
  cp5Menu.addTextfield("Pl2")
    .setPosition(width/2-100, height/2-60)
    .setSize(200, 30)
    .setAutoClear(false)
    .setCaptionLabel("Elev 2's navn")
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
    .setValue("")
    ;
  cp5Main.addButton("backToMenu")
    .setPosition(5, height-55)
    .setSize(100, 50)
    .setCaptionLabel("Back to Menu")
    .setColorForeground(color(#CB0000))
    .setColorBackground(color(#FF5252))
    .setColorActive(color(#FFAAAA))
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

  initialized = true;
  cp5Main.hide();
  cp5Menu.hide();
}
public void Start() {
  cp5Main.show();
  cp5Menu.hide();
  for (int i=0; i < numPl; i++){
    String temp = cp5Menu.get(Textfield.class, "Pl"+(i+1)).getText();
    if (temp.length() < 1){
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

public void roll(){
  /*/
  playDiceAnimation
  int roll = int(random(1,7);
  playerPos.add(roll);
  /*/
}
