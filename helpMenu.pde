class helpMenu{
  //Define Strings
  StringList menu;
  String AstMn = "ASTEROIDS";
  String helpMn = "Help";
  String backB = "M for Main Menu";
  String helpArrows = "Use the directional arrows on your keyboard to move and steer the spacehip. SPACE can be used to shoot.  ";
  String helpPause = "Press ESC during the game to pause it.";
  String helpAim = "The aim of this game is to ensure all asteroids and enemies are destroyed. Doing this will advance your level & difficulty.";
  String helpAlien = "An alien spaceship will appear on level 3. Make sure you destroy it before it destroys you.";
  String helpHit = "You start with 3 lives. If you are shot, or collide with an asteroid or enemy, you will lose a life.";
  String helpEnergy = "After shooting, the ships canon must recharge. Shoot wisely!";
  /**
    Function: helpMenu()
    Description: Shows the high score board for the game. Scores saved in JSON.
    Returns: None
 */
  helpMenu() {
     menu = new StringList();
        menu.append(helpAim);
        menu.append(helpAlien);
        menu.append(helpHit);
        menu.append(helpArrows);
        menu.append(helpPause);     
        menu.append(helpEnergy);   
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
  text(AstMn,width/2,height*0.10);

  //Menu Text
  fill(250,240,0);
  textSize(35);
  text(helpMn,width/2,height*0.15);
  
  //Menu Info
  noFill();
  stroke(255);

  textSize(25);
  fill(255);
  for (int i = 0; i < menu.size(); i++) {
      text(menu.get(i), width/4,height/4 + (120*i),width/2,height/2);
    }


  //Back to Menu Option
  fill(250,240,0);
  text(backB, width/2,height*0.95);
  }
}
