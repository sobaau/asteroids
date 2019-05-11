class leaderBoard{
  //Define Strings
  StringList menu;
  String AstMn = "ASTEROIDS";
  String LdrBd = "Leaderboard";
  String backB = "M for Main Menu";


  leaderBoard() {
    menu = new StringList();
    menu.append(backB);
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
  fill(255);
  textFont(font1);
  textAlign(CENTER);

  //Game Title
  textSize(80);
  text(AstMn,width/2,height*.10);

  //Leaderboard Text
  textSize(25);
  stroke(5);
  text(LdrBd, width/2,height*.15);

  //Menu Option
  
  fill(250,240,0);
  text(backB, width/2,height*.95);

 }
 
 
}



