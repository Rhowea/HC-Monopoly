boolean showingError = false;
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
    } else if (!showingError) {
      flavorText = flavorText + "\n"+"Du har ikke råd til at investerer i denne egendom";
      cardTextarea.setText(flavorText);
      showingError = true;
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
        if (prevType != 1 && prevType != 2) {
          getSpace(prevCard, false);
        } else if (prevType == 1) {
          getChance(prevCard);
        } else if (prevType == 2) {
          getAbsence(prevCard);
        }
        m = 0;
        println("hit");
      } else {
        showingCard = false; 
        cp5Main.show();
      }
    }
  }
}
