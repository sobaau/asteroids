class OpenScn{
  //Define Strings
  StringList menu;
  final String gameTitle = "ASTEROIDS";
  final String tip = "Select using the shortcut keys";
  final String devTeam = "Created by Daniel Harraka, David Preston" + 
                         " & Reece Temple";

  /**
    Function: openScn()
    Description: Constructor for the openScn class.
    Parameters: None.
    Returns: None.
  */
  OpenScn() {
    menu = new StringList();
    menu.append("(N)ew Game");
    if (gameInProgress) {
      menu.append("(C)ontinue Game");
    }
    menu.append("(L)eaderboard");
    menu.append("(H)elp");
    menu.append("(E)xit");
  }

  /**
    Function: draw()
    Description: Makes the main menu login page with selection capability.
    Parameters: None.
    Returns: Void.
  */
  void draw() {
    int menuSpacing = 60;

    //Common setup
    fill(255);
    textFont(font1);
    textAlign(CENTER);

    //Game Title
    textSize(gameTitleTextSize);
    text(gameTitle, width/2, height * 0.10);

    //Menu
    textSize(normalTextSize);
    stroke(5);
    for (int i = 0; i < menu.size(); i++) {
      text(menu.get(i), width/2, ((height/2) * 0.8) + (menuSpacing * i));
    }

    //Credits
    textSize(18);
    fill(255, 204, 0);
    text(tip, width/2, height * 0.92);
    fill(255);
    text(devTeam, width/2, height * 0.975);
  }
}