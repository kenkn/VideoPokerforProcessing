class MainScreen{

  float version;
  
  MainScreen(float currentVersion){
    
    version = currentVersion;
    
  }
  
  void display(){
    
    background(0, 130, 0);
    fill(255);    
    textSize(40);
    
    // cards frame
    stroke(255);
    fill(0, 130, 0);
    strokeWeight(1);
    rect(553, 400, 174, 264, 12);
    rect(368, 400, 174, 264, 12);
    rect(183, 400, 174, 264, 12);
    rect(738, 400, 174, 264, 12);
    rect(923, 400, 174, 264, 12);
    
    // score board
    stroke(150, 0, 0);
    strokeWeight(10);
    fill(0, 0, 200);
    rect(100, 10, 1080, 185, 2); 
    
    fill(255, 255, 0);
    textSize(20);
    text("ROYAL FLUSH", 150, 50);
    text("x800", 400, 50);
    text("4 OF A KIND", 150, 80);
    text("x25", 400, 80);
    text("FLUSH", 150, 110);
    text("x6", 400, 110);
    text("3 OF A KIND", 150, 140);
    text("x3", 400, 140);
    text("JACKS OR BETTER", 150, 170);
    text("x1", 400, 170);
    
    text("5 OF A KIND", 750, 50);
    text("x200", 1000, 50);
    text("STRAIGHT FLUSH", 750, 80);
    text("x50", 1000, 80);
    text("FULL HOUSE", 750, 110);
    text("x9", 1000, 110);
    text("STRAIGHT", 750, 140);
    text("x4", 1000, 140);
    text("TWO PAIR", 750, 170);
    text("x2", 1000, 170);
    
    textSize(20);
    text("ver. " + version, 1080, 170);
    
  }
  
}
