class leaderBoard {
  //Define Variables
  final String gameTitle = "ASTEROIDS";
  final String ldrBd = "Leaderboard";
  final String backB = "Esc or M for main menu";
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
    Function: draw()
    Description: Calls the functions required to populate the screen with
                data.
    Parameters: None
    Returns: Void
  */
  void draw() {
    drawStaticText();
    drawScores(hsData);
  }

  /**
    Function: drawStaticText()
    Description: Draws the displays heading, border and table headings.
    Parameters: None
    Returns: Void
  */
  void drawStaticText() {
    //Page setup
    fill(0);
    stroke(230);
    fill(255);
    textFont(font1);
    textAlign(CENTER);

    //Game Title
    textSize(gameTitleTextSize);
    text(gameTitle, width/2, height * 0.10);

    //Leaderboard Text
    textSize(pageTitleTextSize);
    fill(250, 240, 0);
    text(ldrBd, width/2, height * 0.15);

    //Display Headings
    fill(255);
    textSize(normalTextSize);
    float yPos = height * 0.25;
    text("RANK", width * 0.30, yPos);
    text("NAME", width * 0.40, yPos);
    text("TIME", width * 0.54, yPos);
    text("SCORE", width * 0.68, yPos);

    //Menu Option
    textSize(normalTextSize);
    fill(250, 240, 0);
    text(backB, width/2, height * 0.95);
  }

  /**
    Function: drawScores()
    Description: Extrats the data from the array and displays it.
    Parameters: JSONArray(topScores): Top Score array.
    Returns: Void
  */
  void drawScores(JSONArray topScores) {
    fill(255);
    textSize(normalTextSize);
    
    for (int i = 0; (i < topScores.size()) && (i < topTen); i++) {
      //Extract data from array
      String name = topScores.getJSONObject(i).getString("name");
      int time = topScores.getJSONObject(i).getInt("jsonTime");
      int score = topScores.getJSONObject(i).getInt("jsonScr");
      //Display data on screen
      text(nf(i + 1), width * 0.30, (height * 0.30) + (65 * i));
      text(name, width * 0.40, (height * 0.30) + (65 * i));
      text(convertTime(time), width * 0.54, (height * 0.30) + (65 * i));
      text(nf(score), width * 0.68, (height * 0.30) + (65 * i));
    }
  }

  /**
    Function: convertTime()
    Description: Converts the format of the time from ms to HH:MM:SS
    Parameters: int(time): Time to convert
    Returns: String
  */
  String convertTime(int time) {
    final int secPerMin = 60;
    final int minPerHr = 60;
    final int milSecPerSec = 1000;
    final int milSecPerMin = secPerMin * milSecPerSec;
    final int milSecPerHr = minPerHr * secPerMin * milSecPerSec;

    return "" + floor(time/milSecPerHr) + ":" + 
      floor(time/milSecPerMin)%minPerHr + ":" + (time/milSecPerSec)%secPerMin;
  }
}
