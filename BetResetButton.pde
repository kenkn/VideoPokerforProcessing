class BetResetButton{
  
  boolean isClicked;
  
  BetResetButton(boolean isBetClicked){
    isClicked = isBetClicked;
  }
  
  void display(){
    fill(255, 255, 0);
    strokeWeight(1);
    stroke(255);
    rect(655, 700, 75, 75, 5);
    fill(0);
    text("RESET", 665, 745);
  }
}
