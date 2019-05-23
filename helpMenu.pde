class helpMenu{
  //Define Strings
  StringList menu;
  String AstMn = "ASTEROIDS";
  String helpMn = "Help";
  String backB = "M for Main Menu";

  /**
    Function: helpMenu()
    Description: Shows the high score board for the game. Scores saved in JSON.
    Returns: None
 */
  helpMenu() {
    menu = new StringList();
    menu.append(backB);
  }

  /**
    Function: draw()
    Description:  TODO
    Parameters: None
    Returns: Void
  */
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
  text(helpMn, width/2,height*.15);
  //Menu Option
  fill(250,240,0);
  text(backB, width/2,height*.95);
  }
}
