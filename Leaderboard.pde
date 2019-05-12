class leaderBoard{

  //Define Strings
  StringList ldrInfo;
  String AstMn = "ASTEROIDS";
  String LdrBd = "Leaderboard";
  String backB = "M for main menu";
  String headr = "Rank | Name |   Time   | Score";
  String rank1 = "{}";
  String rank2 = "";
  String rank3 = "";
  String rank4 = "";
  String rank5 = "";
  String rank6 = "";
  String rank7 = "";
  String rank8 = "";
  String rank9 = "";
  String rank10 = "";

  //Define Variables
  float rctX = width*.50;
  float rctY = height*.55;
  float rctW = width*.50;
  float rctH = height*.70;
  int rctRad = 10;
  int topTen = 9;

  //Array
  

  leaderBoard() {

    ldrInfo =new StringList();
    ldrInfo.append(rank1);
    ldrInfo.append(rank2);
    ldrInfo.append(rank3);
    ldrInfo.append(rank4);
    ldrInfo.append(rank5);
    ldrInfo.append(rank6);
    ldrInfo.append(rank7);
    ldrInfo.append(rank8);
    ldrInfo.append(rank9);
    ldrInfo.append(rank10);
  }

  /* 1. Create starts in the background the fade in and out for effect
  2. Menu to have "Play Game, "Leaderboard", "Instructions" & "Controls" as options
  */
   /**************************************************************
 * Function: drawOpenLdr()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Shows the high score board for the game. Scores saved in JSON.
 ***************************************************************/
 void draw() {
   


  //
  fill(0);
  stroke(230);
  rectMode(CENTER);
  rect(rctX,rctY,rctW,rctH,rctRad);

  //
  fill(255);
  textFont(font1);
  textAlign(CENTER);

  //Game Title
  textSize(80);
  text(AstMn,width/2,height*.10);

  //Leaderboard Text
  textSize(40);
  stroke(5);
  text(LdrBd, width/2,height*.15);
  text(headr, width/2,height*.25);

  for (int i = 0; i < ldrInfo.size()  ||  i > topTen; i++) {
      text(ldrInfo.get(i), width/2, (height*.30) + (40 * i));
    }
  //Menu Option
  textSize(25);
  fill(250,240,0);
  text(backB, width/2,height*.95);}
  
  }
