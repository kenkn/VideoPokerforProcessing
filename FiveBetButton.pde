class FiveBetButton{
  
  boolean isClicked;
  
  FiveBetButton(boolean isBetClicked){
    isClicked = isBetClicked;
  }
  
  void display(){
    fill(255, 255, 0);
    strokeWeight(1);
    stroke(255);
    rect(385, 700, 75, 75, 5);
    fill(0);
    text("5 BET", 395, 745);
    
    if(isClicked == true){
      fill(255, 0, 0);
      rect(385, 700, 75, 75, 2);
    }
  }
  
}
