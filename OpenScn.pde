void OpenScn() {
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
  String PlayGm = "| (P)lay Game |";
  String LdrBd = "| (L)eaderboard |";
  String Instr = "| (I)nstructions |";
  String ex = "| (E)xit |";
  String selectn = "Choose using the shortcut keys or the return key";
  String info = "Created by Daniel Harraka David Preston & Reece Temple";
 
  fill(255);
  textFont(font1);
  textAlign(CENTER);
  textSize(80);
  text(AstMn,width/2,(height/2)-300);
  textSize(25);
  stroke(5);
  
  text(PlayGm, width/2,height/2);
  text(LdrBd, width/2,(height/2)+40);
  text(Instr, width/2,(height/2)+80);
  text(ex,  width/2,(height/2)+120);
  
  textSize(18);
  fill(255, 204, 0);
  text(selectn,width/2,height*.92);
  fill(255);
  text(info,width/2,height*.975);
}
