class leaderBoard {
  //Define Variables
  JSONArray data;
  final String astMn = "ASTEROIDS";
  final String ldrBd = "Leaderboard";
  final String backB = "M for main menu";
  float rctX = width * 0.50;
  float rctY = height * 0.55;
  float rctW = width * 0.50;
  float rctH = height * 0.70;
  int rctRad = 10;
  int topTen = 10;
  
  /**
    Function: leaderBoard()
    Description: Constructor for the Leaderboard Page.
    Parameters: None
    Returns: Void
  */
  leaderBoard() {

  }

  /**
    Function: update()
    Description: TODO
    Parameters: None
    Returns: Void
  */
  void update() {

  }

  /**
    Function: draw()
    Description: TODO
    Parameters: None
    Returns: Void
  */
  void draw() {
    drawStaticText();
    drawScores(hsData);
  }

  /**
    Function: drawStaticText()
    Description: TODO
    Parameters: None
    Returns: Void
  */
  void drawStaticText() {
    //TODO
    fill(0);
    stroke(230);

    //TODO
    fill(255);
    textFont(font1);
    textAlign(CENTER);

    //Game Title
    textSize(80);
    text(astMn, width/2, height * 0.10);

    //Leaderboard Text
    textSize(40);
    fill(250, 240, 0);
    text(ldrBd, width/2, height * 0.15);

    //Display Headings
    fill(255);
    text("RANK", width * 0.30, height * 0.25);
    text("NAME", width * 0.40, height * 0.25);
    text("TIME", width * 0.54, height * 0.25);
    text("SCORE", width * 0.68, height * 0.25);

    //Menu Option
    textSize(25);
    fill(250, 240, 0);
    text(backB, width/2, height * 0.95);
  }

   /**
    Function: drawScores()
    Description: TODO
    Parameters: TODO
    Returns: Void
  */
  void drawScores(JSONArray topScores) {
    fill(255);
    textSize(40);
    
    //TODO
    for (int i = 0; (i < topScores.size()) && (i < topTen); i++) {
      String name = topScores.getJSONObject(i).getString("name");
      int time = topScores.getJSONObject(i).getInt("jsonTime");
      int score = topScores.getJSONObject(i).getInt("jsonScr");
      text(name, width * 0.40, (height * 0.30) + (65 * i));
      text(nf(time), width * 0.54, (height * 0.30) + (65 * i));
      text(nf(score), width * 0.68, (height * 0.30) + (65 * i));
      text(nf(i + 1), width * 0.30, (height * 0.30) + (65 * i));
    }
  }
}
