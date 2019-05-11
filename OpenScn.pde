class OpenScn{

  //Define Strings
  StringList menu;
  String gameTitle = "ASTEROIDS";
  String tip = "Select using the shortcut keys";
  String devTeam = "Created by Daniel Harraka, David Preston & Reece Temple";

  /**************************************************************
  * Function: Menu()
  * Desc: Constructor for the Menu class.
  * Param: None
  * Returns: None
  ***************************************************************/
  OpenScn() {
    menu = new StringList();
    menu.append("(P)lay Game");
    menu.append("(L)eaderboard");
    menu.append("(H)elp");
    menu.append("(E)xit");
  }

  /* 1. Create starts in the background the fade in and out for effect
  2. Menu to have "Play Game, "Leaderboard", "Instructions" & "Controls" as options
  */
  /**************************************************************
  * Function: draw()
  * Desc: Makes the main menu login page with selection capability.
  * Parameters: None.
  * Returns: Void
  ***************************************************************/
  void draw() {
    //
    fill(255);
    textFont(font1);
    textAlign(CENTER);

    //Game Title
    textSize(80);
    text(gameTitle, width/2, (height/2) - 300);
    
    //Menu
    textSize(25);
    stroke(5);
    for (int i = 0; i < menu.size(); i++) {
      text(menu.get(i), width/2, (height/2) + (40 * i));
    }

    //
    textSize(18);
    fill(255, 204, 0);
    text(tip, width/2, height * 0.92);
    fill(255);
    text(devTeam, width/2, height * 0.975);
  }
}
