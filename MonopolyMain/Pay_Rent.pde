void payRent() {
  bankSystem b = banks.get(playerTurn-1);
  bankSystem O = banks.get(playerOwning);
  if (index == 11 || index == 27) {
    println("Vi er på kemi");
    rent = 4 * lastPlayerRoll;
  } else if (index == 4 || index == 14 || index == 24 || index == 34) {
    int mult = -1;
    Player p = Players.get(playerOwning);
    for (int i = 0; i < p.ownedSpaces.size(); i++) {
      if (p.ownedSpaces.get(i) == 4 || p.ownedSpaces.get(i) == 14 || p.ownedSpaces.get(i) == 24 || p.ownedSpaces.get(i) == 34) {
        mult++;
      }
    }
    rent = labRent[mult];
  }
  int haveFunds = b.balance - rent; 
  if (haveFunds >= 0) {
    b.addToBalance(-rent);
    O.addToBalance(rent);

    showingCard = false; 
    cp5Main.show();
  }
  if (type == 8 || type == 3) {
    if (prevType == 0){
    getSpace(prevCard, false);
    } else if (prevType == 1){
      getChance();
    } else {
      getAbsence();
    }
    m = 0;
    println("hit2");
  } else {
    showingCard = false; 
    cp5Main.show();
    nextTurn();
  }
}