void buy() {
  bankSystem b = banks.get(playerTurn-1); 
  if (type == 0) {
    int haveFunds = b.balance - price; 
    if (haveFunds >= 0) {
      b.addToBalance(-price); 
      Player p = Players.get(playerTurn-1); 
      p.ownedSpaces.append(p.gridPos); 
      p.ownedSpacesValued.append(0);
      showingCard = false; 
      cp5Main.show();
      nextTurn();
    } else {
      flavorText = flavorText + "\n"+"Du har ikke råd til at investerer i denne egendom";
      cardTextarea.setText(flavorText);
    }
  } else if (type == 8) {
    int haveFunds = b.balance - reBuyValue; 
    if (haveFunds >= 0) {
      b.addToBalance(-reBuyValue);   
      Player p = Players.get(playerTurn - 1);
      p.ownedSpacesValued.set(drawnCardIndex, 0);
      println(p.ownedSpacesValued);
      println(drawnCardIndex);
      println(p.ownedSpacesValued);
      if (type == 8 || type == 3) {
        getSpace(prevCard, false);
        m = 0;
        println("hit2");
      } else {
        showingCard = false; 
        cp5Main.show();
      }
    }
  }
}
