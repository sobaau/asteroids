void drawOpenScn() {
  /* 1. Create starts in the background the fade in and out for effect
  2. Menu to have "Play Game, "Leaderboard", "Instructions" & "Controls" as options
  */
   /**************************************************************
 * Function: drawOpenScn()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Makes the main menu login page with selection capability.
 ***************************************************************/


  String AstMn = "ASTEROIDS";
  String PlayGm = "| Play Game (P) |";
  String LdrBd = "| Leaderboard (L) |";
  String Instr = "| Instructions (I) |";
  String ex = "| Exit (Esc) |";
 
  
  fill(255);
  textAlign(CENTER);
  textSize(80);
  text(AstMn,width/2,(height/2)-300);
  textSize(25);
  stroke(5);
  
  text(PlayGm, width/2,height/2);
  text(LdrBd, width/2,(height/2)+40);
  text(Instr, width/2,(height/2)+80);
  text(ex,  width/2,(height/2)+120);

}
