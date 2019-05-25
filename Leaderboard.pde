class leaderBoard {
  //Define Variables
  String AstMn = "ASTEROIDS";
  String LdrBd = "Leaderboard";
  String backB = "M for main menu";
  String headr = "Rank |  Name  |  Time  |  Score  " ;
  float rctX = width*.50;
  float rctY = height*.55;
  float rctW = width*.50;
  float rctH = height*.70;
  int rctRad = 10;
  int topTen = 10;
  //Array
  /**
    Function: leaderBoard()
    Description: TODO
    Returns: None
 */
  leaderBoard() {
  }

  /**
    Function: draw()
    Description: TODO
    Returns: None
 */
  void draw() {
    //
    fill(0);
    stroke(230);
    rectMode(CENTER);
    rect(rctX, rctY, rctW, rctH, rctRad);
    //
    fill(255);
    textFont(font1);
    textAlign(CENTER);

    //Game Title
    textSize(80);
    text(AstMn, width/2, height*.10);

    //Leaderboard Text
    textSize(40);
    fill(250, 240, 0);
    text(LdrBd, width/2, height*.15);
    fill(255);
    //text(headr, width/2, height*.25);

    text("RANK", width*0.30, height*.25);
    text("NAME", width*0.40, height*.25);
    text("TIME", width*0.54, height*.25);
    text("SCORE", width*0.68, height*.25);

    for (int i = 0; i < hsData.size()  &&  i < topTen; i++) {
         String getName = hsData.getJSONObject(i).getString("name");
         int getTime = hsData.getJSONObject(i).getInt("jsonTime");
         int getScore = hsData.getJSONObject(i).getInt("jsonScr");
         int getRank = i + 1;
     text(getName, width*0.40, (height*.30) + (65 * i));
     text(nf(getTime), width*0.54, (height*.30) + (65 * i));
     text(nf(getScore), width*0.68, (height*.30) + (65 * i));
     text(nf(getRank), width*0.30, (height*.30) + (65 * i));
     }
    //Menu Option
    textSize(25);
    fill(250, 240, 0);
    text(backB, width/2, height*.95);
  }
}
