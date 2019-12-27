// ===================================================
//
//             * V I D E O * P O K E R *
//
//                  JACKS OR BETTER
//
//    SAWADA Kenta 2019-12-24  MERRY CHRISTMAS BRO!
//
//                  "BOCCHI SAIKO!"
//
// ===================================================

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

final float currentVersion = 1.2;

TrumpDesign trumpDesign[] = new TrumpDesign[5];
Trump trump[] = new Trump[54];
Trump hand[] = new Trump[5];
MainScreen main;
BetButton betButton;
FiveBetButton fiveBet;
DrawButton draw;
BetResetButton betReset;
HandJudge judge;

int playerCredit = 50;
int playerBet = 0;
int playerWin = 0;
int gameStatus = 0;
int firstDrawTime = 50;
int secondDrawTime = 0;
int fiveStatusTime = 0;
int drawOrder[] = {10, 20, 30, 40, 50};
int notHeldCard[] = new int[5];
int secondTurnOverCount = 0;
String playerHand;
boolean subCreditFlg = false;
boolean addCreditFlg = false;
boolean hideFlg = true;
boolean isDrawComplete = false;
boolean isBetClicked = false;
boolean isFiveBetClicked = false;
boolean isDrawClicked = false;
boolean isBetResetClicked = false;
boolean isShuffled = false;
boolean isKeyPressed = false;
boolean isArrowAccess = false;
boolean isCardClicked[] = new boolean[5];
boolean isCardPassed[] = new boolean[5];
boolean isCardChenge[] = new boolean[5];


void setup(){
  
  size(1280, 800);
  smooth();
  textAlign(LEFT);
  main = new MainScreen(currentVersion);
  betButton = new BetButton(isBetClicked);
  fiveBet = new FiveBetButton(isFiveBetClicked);
  draw = new DrawButton(isDrawClicked);
  betReset = new BetResetButton(true);

  gameStatus = 1;
  
  for(int i = 0; i < trump.length; ++i){
    trump[i] = new Trump();
    
    if(i >= 0 && 12 >= i){
      trump[i].number = i + 1;
      trump[i].pattern = 0;
    } else if(i >= 13 && 25 >= i){
      trump[i].number = i - 12;
      trump[i].pattern = 1;
    } else if(i >= 26 && 38 >= i){
      trump[i].number = i - 25;
      trump[i].pattern = 2;
    } else if(i >= 39 && 51 >= i){
      trump[i].number = i - 38;
      trump[i].pattern = 3;
    } else {
      trump[i].number = 0;
      trump[i].pattern = -1;
    }
  
  }
  
  trumpDesign[0] = new TrumpDesign(trump[3].number, trump[3].pattern, false, 3.0);
  trumpDesign[1] = new TrumpDesign(trump[22].number, trump[22].pattern, false, 3.0);
  trumpDesign[2] = new TrumpDesign(trump[53].number, trump[53].pattern, false, 3.0);
  trumpDesign[3] = new TrumpDesign(trump[23].number, trump[23].pattern, false, 3.0);
  trumpDesign[4] = new TrumpDesign(trump[40].number, trump[40].pattern, false, 3.0);
  
}

void draw(){
  
  if(gameStatus == 1){
    
    main = new MainScreen(currentVersion);
    main.display();
    textSize(40);
    fill(255);
    text("WIN: " + playerWin, 50, 730);
    text("BET: " + playerBet, 50, 780);
    textAlign(LEFT);
    text("CREDIT: " + playerCredit, 780, 780);
    textAlign(LEFT);
    
    textSize(20);
    betButton.display();
    fiveBet.display();
    draw.display();
    betReset.display();
    
    if(isBetClicked == true){
      
      if(playerBet < playerCredit)  playerBet++;
      isBetClicked = false;
      
    }
    
    if(isFiveBetClicked == true){
      
      if(playerBet + 5 < playerCredit)  playerBet += 5;
      else if(playerBet < playerCredit)  playerBet = playerCredit;
      isFiveBetClicked = false;
      
    }
    
    if(isBetResetClicked == true){
    
      playerBet = 0;
      isBetResetClicked = false;
      
    }
    
    if(isDrawClicked == true){
    
      isDrawClicked = false;
      if(playerBet > 0)  gameStatus = 2;
      
    }
    
    showCard();
  
  }
  
  else if(gameStatus == 2){
    
    if(subCreditFlg == false){
      playerCredit -= playerBet;
      subCreditFlg = true;
    }
    
    fill(0, 130, 0);
    stroke(0, 130, 0);
    rect(780, 730, 1000, 100);
    textSize(40);
    fill(255);
    textAlign(LEFT);
    text("CREDIT: " + playerCredit, 780, 780);
    textAlign(LEFT);
    
    if(isShuffled == false){
      cardShuffle();
      isShuffled = true;
    }
    
    firstDrawTime--;
    
    if(firstDrawTime == 41){
      trumpDesign[0] = new TrumpDesign(trump[0].number, trump[0].pattern, true, 3.0);
      hand[0] = trump[0];
      trumpDesign[0].setLocation(183, 400);
      trumpDesign[0].display();
    } else if(firstDrawTime == 31){
      trumpDesign[1] = new TrumpDesign(trump[1].number, trump[1].pattern, true, 3.0);
      hand[1] = trump[1];
      trumpDesign[1].setLocation(368, 400);
      trumpDesign[1].display();
    } else if(firstDrawTime == 21){
      trumpDesign[2] = new TrumpDesign(trump[2].number, trump[2].pattern, true, 3.0);
      hand[2] = trump[2];
      trumpDesign[2].setLocation(553, 400);
      trumpDesign[2].display();
    } else if(firstDrawTime == 11){
      trumpDesign[3] = new TrumpDesign(trump[3].number, trump[3].pattern, true, 3.0);
      hand[3] = trump[3];
      trumpDesign[3].setLocation(738, 400);
      trumpDesign[3].display();
    } else if(firstDrawTime == 1){
      trumpDesign[4] = new TrumpDesign(trump[4].number, trump[4].pattern, true, 3.0);
      hand[4] = trump[4];
      trumpDesign[4].setLocation(923, 400);
      trumpDesign[4].display();
    } else if(firstDrawTime == 0){
      gameStatus = 3;
      judge = new HandJudge(hand);
      textAlign(CENTER);
      text(judge.judgement(), 640, 350);
      textAlign(LEFT);
      
      firstDrawTime = 50;
      isShuffled = false;
    }
        
  }
  
  else if(gameStatus == 3){
       
    if(keyPressed == true && key == '1'){
       if(isKeyPressed == false){
         isCardClicked[0] = !isCardClicked[0];
         isKeyPressed = true;
       }
    } else if(keyPressed == true && key == '2'){
       if(isKeyPressed == false){
         isCardClicked[1] = !isCardClicked[1];
         isKeyPressed = true;
       }
    } else if(keyPressed == true && key == '3'){
       if(isKeyPressed == false){
         isCardClicked[2] = !isCardClicked[2];
         isKeyPressed = true;
       }
    } else if(keyPressed == true && key == '4'){
       if(isKeyPressed == false){
         isCardClicked[3] = !isCardClicked[3];
         isKeyPressed = true;
       }
    } else if(keyPressed == true && key == '5'){
       if(isKeyPressed == false){
         isCardClicked[4] = !isCardClicked[4];
         isKeyPressed = true;
       }
    } else if(keyPressed == true && key == ENTER){
      if(isKeyPressed == false){
         isDrawClicked = true;
         isKeyPressed = true;
       }
    } else isKeyPressed = false;
    
    showCard();
    showHeldStr();
    
    if(isDrawClicked == true){
      
      hideHeldStr();
      isDrawClicked = false;
      gameStatus = 4;
      
    }
  }
  
  else if(gameStatus == 4){
    
    secondDrawTime++;
    int notHeld = 0;
    fill(0, 130, 0);
    stroke(0, 130, 0);
    rect(300, 300, 700, 60);
    
    for(int i = 0; i < trumpDesign.length; ++i){
      
      if(isCardClicked[0] == true && isCardClicked[1] == true && isCardClicked[2] == true && isCardClicked[3] == true && isCardClicked[4] == true){
        isDrawComplete = true;
      }
      
      if(isCardClicked[i] == false){
        if(hideFlg == true)  trumpDesign[i].cardTurnOver();
        notHeldCard[notHeld] = i;
        notHeld++;
                    
        trumpDesign[i] = new TrumpDesign(trump[i + 5].number, trump[i + 5].pattern, true, 3.0);
        hand[i] = trump[i + 5];       
          
        switch(i){
          case 0:
            trumpDesign[i].setLocation(183, 400);
            break;
          case 1:
            trumpDesign[i].setLocation(368, 400);
            break;
          case 2:
            trumpDesign[i].setLocation(553, 400);
            break;
          case 3:
            trumpDesign[i].setLocation(738, 400);
            break;
          case 4:
            trumpDesign[i].setLocation(923, 400);
            break;
        }
      }
    }
    
    hideFlg = false;
    
    if(secondDrawTime >= drawOrder[secondTurnOverCount] && secondTurnOverCount <= notHeld - 1){
      trumpDesign[notHeldCard[secondTurnOverCount]].display();
      secondTurnOverCount++;
      if(secondTurnOverCount == notHeld)  isDrawComplete = true;
    }
     
    for(int i = 0; i < trumpDesign.length; ++i){
        if(isCardClicked[i] == false){
          hand[i] = trump[i + 5];
        }
    }
    
    if(isDrawComplete == true){
      judge = new HandJudge(hand);
      playerHand = judge.judgement();
      isDrawComplete = false;
      hideFlg = true;
      secondDrawTime = 0;
      secondTurnOverCount = 0;
      gameStatus = 5;
    }
  }
  
  else if(gameStatus == 5){
    
    fill(255, 255, 0);
    stroke(255, 255, 0);
    textSize(72);
    textAlign(CENTER);
    text(playerHand, 640, 280);
    fiveStatusTime++;
    
    if(playerHand == "JACKS OR BETTER"){
      
      if(addCreditFlg == false){
        playerWin = playerBet;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "TWO PAIR"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 2;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "3 OF A KIND"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 3;
         playerCredit += playerWin;
        addCreditFlg = true;
      }
     
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "STRAIGHT"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 4;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "FLUSH"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 6;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
     textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "FULL HOUSE"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 9;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
     
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "4 OF A KIND"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 25;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
     
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "STRAIGHT FLUSH"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 50;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else if(playerHand == "5 OF A KIND"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 200;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      text("CREDIT: " + playerCredit, 780, 780);
      
    } else if(playerHand == "ROYAL STRAIGHT FLUSH"){
      
      if(addCreditFlg == false){
        playerWin = playerBet * 800;
        playerCredit += playerWin;
        addCreditFlg = true;
      }
      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(780, 730, 1000, 100);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("CREDIT: " + playerCredit, 780, 780);
      textAlign(LEFT);
      
    } else {
      fill(255, 255, 0);
      textSize(36);
      text("GAME OVER", 1100, 730);
    }
    
    if(isBetClicked == true){
      
      playerBet++;      
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 735, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("BET: " + playerBet, 50, 780);
      isBetClicked = false;
      
    }
    
    if(isFiveBetClicked == true){
      
      playerBet += 5;
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 735, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("BET: " + playerBet, 50, 780);
      isFiveBetClicked = false;
    
    }
    
    if(isBetResetClicked == true){
      playerBet = 0;
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 735, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("BET: " + playerBet, 50, 780);
      isBetResetClicked = false;
    }
    
    if(playerCredit == 0){
        gameStatus = 6;
    }
    
    if(fiveStatusTime > 40)  isKeyPressed = false;
    
    if((isDrawClicked == true || (keyPressed == true && key == ENTER)) && playerBet > 0 && isKeyPressed == false){
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(200, 205, 800, 100);
      rect(950, 700, 280, 30);
      for(int i = 0; i < trumpDesign.length; ++i){
        trumpDesign[i].cardTurnOver();
        isCardClicked[i] = false;
      }
      
      subCreditFlg = false;
      addCreditFlg = false;
      isDrawClicked = false;
      
      playerWin = 0;
      fill(0, 130, 0);
      stroke(0, 130, 0);
      rect(50, 680, 200, 50);
      textSize(40);
      fill(255);
      textAlign(LEFT);
      text("WIN: " + playerWin, 50, 730);      
      
      if(playerBet > playerCredit){
        playerBet = playerCredit;
        fill(0, 130, 0);
        stroke(0, 130, 0);
        rect(50, 735, 200, 50);
        textSize(40);
        fill(255);
        textAlign(LEFT);
        text("BET: " + playerBet, 50, 780);
      }
      gameStatus = 2;
    }
    
  }

}

void mousePressed(){
  
  if(gameStatus == 1 || gameStatus == 5){
    if(mouseX >= 300 && 375 >= mouseX && mouseY >= 700 && 775 >= mouseY){  // betbutton clicked
      isBetClicked = true;
    }
    
    if(mouseX >= 385 && 460 >= mouseX && mouseY >= 700 && 775 >= mouseY){
      isFiveBetClicked = true;
    }
    
    if(mouseX >= 655 && 735 >= mouseX && mouseY >= 700 && 775 >= mouseY){
      isBetResetClicked = true;
    }
  }
  
  if(gameStatus == 1 || gameStatus == 3 || gameStatus == 5){
    if(mouseX >= 470 && 645 >= mouseX && mouseY >= 700 && 775 >= mouseY){
      isDrawClicked = true;
    }
  }
  
  //mousepointer clickes card
  if(gameStatus == 3){
    if(mouseX >= 183 && mouseX <= 357 && mouseY >= 400 && mouseY <= 664){
      isCardClicked[0] = !isCardClicked[0];
    } else if(mouseX >= 368 && mouseX <= 542 && mouseY >= 400 && mouseY <= 664){
      isCardClicked[1] = !isCardClicked[1];
    } else if(mouseX >= 553 && mouseX <= 727 && mouseY >= 400 && mouseY <= 664){
      isCardClicked[2] = !isCardClicked[2];
    } else if(mouseX >= 738 && mouseX <= 912 && mouseY >= 400 && mouseY <= 664){
      isCardClicked[3] = !isCardClicked[3];
    } else if(mouseX >= 923 && mouseX <= 1097 && mouseY >= 400 && mouseY <= 664){
      isCardClicked[4] = !isCardClicked[4];
    }
  }
  
}

void cardShuffle(){
  
  Random rnd = ThreadLocalRandom.current();
  
  for(int i = trump.length - 1; i > 0; i--) {
    
      int index = rnd.nextInt(i + 1);  
      Trump tmp = trump[index];
      trump[index] = trump[i];
      trump[i] = tmp;
      
  }
  
}

void showHeldStr(){
  
  if(isCardClicked[0] == true){
    fill(255);
    textSize(20);
    text("HELD", 243, 390);
  } else {
    fill(0, 130, 0);
    textSize(20);
    text("HELD", 243, 390);
  }
  
  if(isCardClicked[1] == true){
    fill(255);
    textSize(20);
    text("HELD", 428, 390);
  } else {
    fill(0, 130, 0);
    textSize(20);
    text("HELD", 428, 390);
  }
  
  if(isCardClicked[2] == true){
    fill(255);
    textSize(20);
    text("HELD", 613, 390);
  } else {
    fill(0, 130, 0);
    textSize(20);
    text("HELD", 613, 390);
  }
  
  if(isCardClicked[3] == true){
    fill(255);
    textSize(20);
    text("HELD", 798, 390);
  } else {
    fill(0, 130, 0);
    textSize(20);
    text("HELD", 798, 390);
  }
  
  if(isCardClicked[4] == true){
    fill(255);
    textSize(20);
    text("HELD", 983, 390);
  } else {
    fill(0, 130, 0);
    textSize(20);
    text("HELD", 983, 390);
  }
  
}

void hideHeldStr(){
  
  stroke(0, 130, 0);
  fill(0, 130, 0);
  rect(240, 370, 800, 20);
  
}

void showCard(){
  
  trumpDesign[0].setLocation(183, 400);
  trumpDesign[1].setLocation(368, 400);
  trumpDesign[2].setLocation(553, 400);
  trumpDesign[3].setLocation(738, 400);
  trumpDesign[4].setLocation(923, 400);
  
  trumpDesign[0].display();
  trumpDesign[1].display();
  trumpDesign[2].display();
  trumpDesign[3].display();
  trumpDesign[4].display();
  
  passed();
  
  trumpDesign[0].brightCard(isCardPassed[0]);
  trumpDesign[1].brightCard(isCardPassed[1]);
  trumpDesign[2].brightCard(isCardPassed[2]);
  trumpDesign[3].brightCard(isCardPassed[3]);
  trumpDesign[4].brightCard(isCardPassed[4]);
  
}

void passed(){
  
  // mousepointer passes on card
  if(gameStatus == 3){
    if(mouseX >= 183 && mouseX <= 357 && mouseY >= 400 && mouseY <= 664){
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
      isCardPassed[0] = true;
    } else if(mouseX >= 368 && mouseX <= 542 && mouseY >= 400 && mouseY <= 664){
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
      isCardPassed[1] = true;
    } else if(mouseX >= 553 && mouseX <= 727 && mouseY >= 400 && mouseY <= 664){
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
      isCardPassed[2] = true;
    } else if(mouseX >= 738 && mouseX <= 912 && mouseY >= 400 && mouseY <= 664){
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
      isCardPassed[3] = true;
    } else if(mouseX >= 923 && mouseX <= 1097 && mouseY >= 400 && mouseY <= 664){
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
      isCardPassed[4] = true;
    } else {
      for(int i = 0; i < isCardPassed.length; ++i){
        isCardPassed[i] = false;
      }
    }
  }
  
}
