// SAWADA Kenta 2019-12-23
// Trump Object

class TrumpDesign{
  
  int number;  // 0:JOKER
  int pattern;  // 0:SPADE 1:CLUB 2:HEART 3:DIAMOND
  Boolean isFront;
  float cardSize;
  float locateX = 0.0, locateY = 0.0;
  //Boolean isPassing = false;
  
  TrumpDesign(int requireNumber, int requirePattern, Boolean isCardFront, float requireCardSize){
    
    number = requireNumber;
    pattern = requirePattern;
    isFront = isCardFront;
    cardSize = requireCardSize;
    locateX = 0;
    locateY = 0;
    
  }
  
  void setLocation(float tempX, float tempY){
    
    locateX = tempX;
    locateY = tempY;    
    
  }
  
  void brightCard(boolean isPassing){
    
    if(isPassing == true){
      fill(255, 255, 0, 150);
      rect(locateX, locateY, cardSize * 58, cardSize * 88, cardSize * 4);
    }
    
  }
  
  void cardTurnOver(){
    fill(150, 10, 0);
    rect(locateX, locateY, cardSize * 58, cardSize * 88, cardSize * 4);
  }
  
  void display(){
    
    float cardX = cardSize * 58;
    float cardY = cardSize * 88;
    float patternMarginX = cardSize * 45;
    float patternMarginY = cardSize * 5;
    float numberMarginX = cardSize * 3;
    float numberMarginY = cardSize * 25;
    float jackMarginX = cardSize * 7;
    
    stroke(0);
    if(isFront == true)  fill(255);
    else   fill(150, 10, 0);
    rect(locateX, locateY, cardX, cardY, cardSize * 4);
    
    if(isFront == true){
    
      if(number != 0){
        
        switch(pattern){
        
        case 0:
          fill(0);
          textSize(cardSize * 50.0);
          text("♠", locateX + cardX - patternMarginX, locateY + cardY - patternMarginY);
          break;
        
        case 1:
          fill(0);
          textSize(cardSize * 50.0);
          text("♣", locateX + cardX - patternMarginX, locateY + cardY - patternMarginY);
          break;
        
        case 2:
          fill(255, 0, 0);
          textSize(cardSize * 50.0);
          text("♥", locateX + cardX - patternMarginX, locateY + cardY - patternMarginY);
          break;
        
        case 3:
          fill(255, 0, 0);
          textSize(cardSize * 50.0);
          text("♦", locateX + cardX - patternMarginX, locateY + cardY - patternMarginY);
          break;
          
        case -1:
          break;
        
        default:
          System.out.println("Occured trump pattern error!");
          exit();
          break;
          
        }
        
        textSize(cardSize * 28.0);
        
        if(number <= 10 && number != 1){
          text(number, locateX + numberMarginX, locateY + numberMarginY);
        } else if(number <= 13){
          
          switch(number){
          
          case 1:
            text("A", locateX + numberMarginX, locateY + numberMarginY);
            break;
          
          case 11:
            text("J", locateX + jackMarginX, locateY + numberMarginY);
            break;
            
          case 12:
            text("Q", locateX + numberMarginX, locateY + numberMarginY);
            break;
            
          case 13:
            text("K", locateX + numberMarginX, locateY + numberMarginY);
            break;
            
          default:
            System.out.println("Occured trump number error!");
            exit();
            break;
          
          }
        } else {
          System.out.println("Occured trump pattern error!");
          exit();
        }
        
      } else {  // JOKER(Simple ver.)
        
        float jokerMarginX = cardSize * 8;
        float jokerMarginY = cardSize * 50;
        fill(0);
        textSize(cardSize * 15.0);
        text("JOKER", locateX + jokerMarginX, locateY + jokerMarginY);
        
      }
    } 
  }
  
}
