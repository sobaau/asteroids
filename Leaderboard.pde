void drawOpenLdr() {
  /* 1. Create starts in the background the fade in and out for effect
  2. Menu to have "Play Game, "Leaderboard", "Instructions" & "Controls" as options
  */
   /**************************************************************
 * Function: drawOpenLdr()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Shows the high score board for the game. Scores saved in JSON.
 ***************************************************************/

  String AstMn = "ASTEROIDS";
  String LdrBd = "Leaderboard";
  String backB = "| Press M for Main Menu |";
 
  fill(255);
  textAlign(CENTER);
  textSize(80);
  text(AstMn,width/2,(height/2)-300);
  textSize(25);
  stroke(5);
  
  
  text(LdrBd, width/2,(height/2)-220);
  text(backB, width/2,height*.95);
}
