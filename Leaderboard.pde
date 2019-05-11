class leaderBoard{
  //Define Strings
  StringList menu;
  StringList ldrInfo;
  String AstMn = "ASTEROIDS";
  String LdrBd = "Leaderboard";
  String backB = "M for main menu";
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

  leaderBoard() {
    menu = new StringList();
    menu.append(backB);

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
   
    JSONObject highscores = new JSONObject();




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
  text(backB, width/2,height*.95);}}

  /*
  json.setInt("id", 0);
  json.setString("species", "Panthera leo");
  json.setString("name", "Lion");

  saveJSONObject(json, "json/ldr.json");
*/
