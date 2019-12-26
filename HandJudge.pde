class HandJudge{
  
  Trump judgeHand[] = new Trump[5];
  int numberOfJoker = 0;
  int jokerAddress[] = new int[50];
  
  HandJudge(Trump catchHand[]){
    for(int i = 0; i < catchHand.length; ++i){
      judgeHand[i] = catchHand[i];
    }
  }
  
  String judgement(){
    
    for(int i = 0; i < judgeHand.length; ++i){
      if(judgeHand[i].number == 0){
        jokerAddress[numberOfJoker] = i;
        numberOfJoker++;
      }
    }
    
    println("number of joker : "+numberOfJoker);
    println("jokers address : "+jokerAddress[0]);
    for(int i=0;i<judgeHand.length;++i){
      println("card "+i+" is "+judgeHand[i].number);
    }
    println();
    
    if(isRsf())  return "ROYAL STRAIGHT FLUSH";
    else if(isStraightFlush())  return "STRAIGHT FLUSH";
    else if(isFourCard())  return "4 OF A KIND";
    else if(isFullHouse()) return "FULL HOUSE";
    else if(isFlush())  return "FLUSH";
    else if(isStraight())  return "STRAIGHT";
    else if(isThreeCard()) return "3 OF A KIND";
    else if(isTwoPair())  return "TWO PAIR";
    else if(isJacksOrBetter())  return "JACKS OR BETTER";
    else return "";
  
  }
  
  boolean isJacksOrBetter(){
    
    if(numberOfJoker == 0){
      for(int i = 0; i < judgeHand.length; ++i){
        if(judgeHand[i].number == 1 || judgeHand[i].number >= 11){
          for(int j = i + 1; j < judgeHand.length; ++j){
            if(judgeHand[i].number == judgeHand[j].number)  return true;
          }
        }
      }
      
      return false;
    }
    
    else if(numberOfJoker == 1){
      for(int i = 0; i < judgeHand.length; ++i){
        if(judgeHand[i].number == 1 || judgeHand[i].number >= 11){
          return true;
        }
      }
      return false;
    } else return true;
    
  }
  
  boolean isTwoPair(){
    
    int tmpArray[] = new int[5];
    for(int i = 0; i < judgeHand.length; ++i){
      tmpArray[i] = judgeHand[i].number;
    }
    
    //sort
    for(int i = 0; i < tmpArray.length - 1; i++){
      for(int j = tmpArray.length - 1; j > i; j--){
        if(tmpArray[j] < tmpArray[j - 1]){
          int tmp = tmpArray[j];
          tmpArray[j] = tmpArray[j - 1];
          tmpArray[j - 1] = tmp;
        }
      }
    }
        
    if(numberOfJoker == 0){
      if(tmpArray[0] == tmpArray[1] && tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[0] == tmpArray[1] && tmpArray[1] != tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else if(tmpArray[0] != tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){  // threecard
      return false;
    }
    
    else return false;  //numberOfJoker = 2
  }
  
  boolean isThreeCard(){
    
    int tmpArray[] = new int[5];
    for(int i = 0; i < judgeHand.length; ++i){
      tmpArray[i] = judgeHand[i].number;
    }
    
    //sort
    for(int i = 0; i < tmpArray.length - 1; i++){
      for(int j = tmpArray.length - 1; j > i; j--){
        if(tmpArray[j] < tmpArray[j - 1]){
          int tmp = tmpArray[j];
          tmpArray[j] = tmpArray[j - 1];
          tmpArray[j - 1] = tmp;
        }
      }
    }
    
    if(numberOfJoker == 0){
      if(tmpArray[0] == tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[0] != tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[0] != tmpArray[1] && tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){
      if(tmpArray[1] == tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[1] != tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else{  //numberOfJoker = 2
      if(tmpArray[2] != tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else return false;
    }
    
  }
  
  boolean isStraight(){
    
    int tmpArray[] = new int[5];
    for(int i = 0; i < judgeHand.length; ++i){
      tmpArray[i] = judgeHand[i].number;
    }
    
    //sort
    for(int i = 0; i < tmpArray.length - 1; i++){
      for(int j = tmpArray.length - 1; j > i; j--){
        if(tmpArray[j] < tmpArray[j - 1]){
          int tmp = tmpArray[j];
          tmpArray[j] = tmpArray[j - 1];
          tmpArray[j - 1] = tmp;
        }
      }
    }
    
    if(numberOfJoker == 0){
      if(tmpArray[0] + 2 == tmpArray[1] + 1 && tmpArray[1] + 1 == tmpArray[2] && tmpArray[2] == tmpArray[3] - 1 && tmpArray[3] - 1 == tmpArray[4] - 2){
        return true;
      } else if(tmpArray[0] == 1 && tmpArray[1] == 10 && tmpArray[2] == 11 && tmpArray[3] == 12 && tmpArray[4] == 13){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){
      if(tmpArray[1] == tmpArray[2] - 1 && tmpArray[2] - 1 == tmpArray[3] - 2 && tmpArray[3] - 2 == tmpArray[4] - 3){
        return true;
      } else if(tmpArray[1] == tmpArray[2] - 2 && tmpArray[2] - 2 == tmpArray[3] - 3 && tmpArray[3] - 3 == tmpArray[4] - 4){
        return true;
      } else if(tmpArray[1] == tmpArray[2] - 1 && tmpArray[2] - 1 == tmpArray[3] - 3 && tmpArray[3] - 3 == tmpArray[4] - 4){
        return true;
      } else if(tmpArray[1] == tmpArray[2] - 1 && tmpArray[2] - 1 == tmpArray[3] - 2 && tmpArray[3] - 2 == tmpArray[4] - 4){
        return true;
      } else return false;
    }
    
    else {  //numberOfJoker = 2
      if(tmpArray[2] == tmpArray[3] - 1 && tmpArray[3] - 1 == tmpArray[4] - 2){
        return true;
      } else if(tmpArray[2] == tmpArray[3] - 2 && tmpArray[3] - 2 == tmpArray[4] - 3){
        return true;
      } else if(tmpArray[2] == tmpArray[3] - 1 && tmpArray[3] - 1 == tmpArray[4] - 3){
        return true;
      } else if(tmpArray[2] == tmpArray[3] - 3 && tmpArray[3] - 3 == tmpArray[4] - 4){
        return true;
      } else if(tmpArray[2] == tmpArray[3] - 1 && tmpArray[3] - 1 == tmpArray[4] - 4){
        return true;
      } else if(tmpArray[2] == tmpArray[3] - 2 && tmpArray[3] - 2 == tmpArray[4] - 4){
        return true;
      } else return false;
    }
    
  }
  
  boolean isFlush(){
    
    if(numberOfJoker == 0){
      if(judgeHand[0].pattern == judgeHand[1].pattern && judgeHand[1].pattern == judgeHand[2].pattern && judgeHand[2].pattern == judgeHand[3].pattern && judgeHand[3].pattern == judgeHand[4].pattern){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){
      int tmpArray[] = new int[5];
      for(int i = 0; i < judgeHand.length; ++i){
        tmpArray[i] = judgeHand[i].pattern;
      }
      
      //sort
      for(int i = 0; i < tmpArray.length - 1; i++){
        for(int j = tmpArray.length - 1; j > i; j--){
          if(tmpArray[j] < tmpArray[j - 1]){
            int tmp = tmpArray[j];
            tmpArray[j] = tmpArray[j - 1];
            tmpArray[j - 1] = tmp;
          }
        }
      }
      
      if(tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
      
    }
    
    else {  //numberOfJoker = 2
      int tmpArray[] = new int[5];
      for(int i = 0; i < judgeHand.length; ++i){
        tmpArray[i] = judgeHand[i].pattern;
      }
      
      //sort
      for(int i = 0; i < tmpArray.length - 1; i++){
        for(int j = tmpArray.length - 1; j > i; j--){
          if(tmpArray[j] < tmpArray[j - 1]){
            int tmp = tmpArray[j];
            tmpArray[j] = tmpArray[j - 1];
            tmpArray[j - 1] = tmp;
          }
        }
      }
      
      if(tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
  }
  
  boolean isFullHouse(){
    
    int tmpArray[] = new int[5];
    for(int i = 0; i < judgeHand.length; ++i){
      tmpArray[i] = judgeHand[i].number;
    }
    
    //sort
    for(int i = 0; i < tmpArray.length - 1; i++){
      for(int j = tmpArray.length - 1; j > i; j--){
        if(tmpArray[j] < tmpArray[j - 1]){
          int tmp = tmpArray[j];
          tmpArray[j] = tmpArray[j - 1];
          tmpArray[j - 1] = tmp;
        }
      }
    }
    
    if(numberOfJoker == 0){
      if(tmpArray[0] == tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else if(tmpArray[0] == tmpArray[1] && tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){
      if(tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else if(tmpArray[1] == tmpArray[2] && tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else if(tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else return false;
    }
    
    else return false;  //numberOfJoker = 2

  }
  
  boolean isFourCard(){
    
    int tmpArray[] = new int[5];
    for(int i = 0; i < judgeHand.length; ++i){
      tmpArray[i] = judgeHand[i].number;
    }
    
    //sort
    for(int i = 0; i < tmpArray.length - 1; i++){
      for(int j = tmpArray.length - 1; j > i; j--){
        if(tmpArray[j] < tmpArray[j - 1]){
          int tmp = tmpArray[j];
          tmpArray[j] = tmpArray[j - 1];
          tmpArray[j - 1] = tmp;
        }
      }
    }
    
    if(numberOfJoker == 0){
      if(tmpArray[0] == tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[0] != tmpArray[1] && tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else if(numberOfJoker == 1){
      if(tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[1] != tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else{  //numberOfJoker = 2
      if(tmpArray[2] == tmpArray[3] && tmpArray[3] != tmpArray[4]){
        return true;
      } else if(tmpArray[2] != tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }

  }
  
  boolean isFiveCard(){
    
    int tmpArray[] = new int[5];
    
    if(numberOfJoker != 0){
      for(int i = 0; i < judgeHand.length; ++i){
        tmpArray[i] = judgeHand[i].number;
      }
      
      //sort
      for(int i = 0; i < tmpArray.length - 1; i++){
        for(int j = tmpArray.length - 1; j > i; j--){
          if(tmpArray[j] < tmpArray[j - 1]){
            int tmp = tmpArray[j];
            tmpArray[j] = tmpArray[j - 1];
            tmpArray[j - 1] = tmp;
          }
        }
      }
    }
    
    if(numberOfJoker == 0)  return false;
    
    else if(numberOfJoker == 1){
      if(tmpArray[1] == tmpArray[2] && tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
    else {  //numberOfJoker = 2
      if(tmpArray[2] == tmpArray[3] && tmpArray[3] == tmpArray[4]){
        return true;
      } else return false;
    }
    
  }
  
  boolean isStraightFlush(){
    
    if(isStraight() && isFlush())  return true;
    else return false;
    
  }
  
  boolean isRsf(){
    
    if(isStraightFlush()){
      int tmpArray[] = new int[5];
      for(int i = 0; i < judgeHand.length; ++i){
        tmpArray[i] = judgeHand[i].number;
      }
      
      //sort
      for(int i = 0; i < tmpArray.length - 1; i++){
        for(int j = tmpArray.length - 1; j > i; j--){
          if(tmpArray[j] < tmpArray[j - 1]){
            int tmp = tmpArray[j];
            tmpArray[j] = tmpArray[j - 1];
            tmpArray[j - 1] = tmp;
          }
        }
      }
      
      if(tmpArray[0] == 1 && tmpArray[1] == 10 && tmpArray[2] == 11 && tmpArray[3] == 12 && tmpArray[4] == 13){
        return true;
      } else return false;
        
    } else return false;
    
  }
  
}
