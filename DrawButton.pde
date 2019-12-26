class DrawButton{

  boolean isClicked;
  
  DrawButton(boolean isBetClicked){
    isClicked = isBetClicked;
  }
  
  void display(){
    fill(255, 0, 0);
    strokeWeight(1);
    stroke(255);
    rect(470, 700, 175, 75, 5);
    fill(255);
    text("DRAW", 525, 745);
    
    if(isClicked == true){
      fill(255, 255, 0);
      rect(470, 700, 175, 75, 2);
    }
  }
  
}
