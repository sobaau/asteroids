class helpPage {
  //Define Strings
  StringList helpText;
  final String gameTitle = "ASTEROIDS";
  final String helpMn = "Help";
  final String backB = "M for Main Menu";
  final String helpArrows = "Use the directional arrows on your keyboard to" +
                            " move and steer the spacehip. SPACE can be" + 
                            " used to shoot.";
  final String helpPause = "Press ESC during the game to pause it.";
  final String helpAim = "The aim of this game is to ensure all asteroids" +
                         " and enemies are destroyed. Doing this will" + 
                         " advance your level & difficulty.";
  final String helpAlien = "Alien spaceships will begin to appear on level" +
                           " 3. Make sure you destroy them before they" +
                           " destroy you.";
  final String helpHit = "You start with 3 lives. If you are shot, or" +
                         " collide with an asteroid or enemy, you will" +
                         " lose a life.";
  final String helpEnergy = "After shooting, the ships canon must recharge." + 
                            " Shoot wisely!";

  /**
    Function: helpPage()
    Description: TODO
    Returns: None
  */
  helpPage() {
    helpText = new StringList();
    helpText.append(helpAim);
    helpText.append(helpAlien);
    helpText.append(helpHit);
    helpText.append(helpArrows);
    helpText.append(helpPause);     
    helpText.append(helpEnergy);   
  }

  /**
    Function: draw()
    Description:  TODO
    Parameters: None
    Returns: Void
  */
  void draw() {
    //Headings
    fill(255);
    textFont(font1);
    textAlign(CENTER);
    textSize(gameTitleTextSize);
    text(gameTitle, width/2, height * 0.10);
    fill(250, 240, 0);
    textSize(pageTitleTextSize);
    text(helpMn, width/2, height * 0.15);
    //Menu Info
    noFill();
    stroke(255);
    textSize(normalTextSize);
    fill(255);
    textAlign(CENTER);
    for (int i = 0; i < helpText.size(); i++) {
      text(helpText.get(i), width/4, height/4 + (120 * i), width/2, height/2);
    }
    //Back to Menu Option
    textSize(normalTextSize);
    fill(250, 240, 0);
    text(backB, width/2, height * 0.95);
  }
}