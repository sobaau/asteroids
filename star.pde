class Star {
  //Define class variables
  float locX;
  float locY;
  final int minBright = 1;
  final int maxBright = 3;
  int starBright;
  final int numFrames = 10;

  /**
    Function: Star()
    Description: Constructor for the Star class. Spawns a star at a 
                  random location within the screen boundaries.
    Parameters: None
    Returns: None
  */
  Star() {
    locX = random(minScreenEdge, width);
    locY = random(minScreenEdge, height);
    starBright = int(minBright);
  }
  
  /**
    Function: draw()
    Description: draws the star using a processing point function 
                  and changes its brightness.
    Parameters: None
    Returns: Void
  */
  void draw() {
    push();
    if (frameCount % numFrames == 0) {
      starBright = int(random(minBright, maxBright));
    }
    strokeWeight(starBright);
    stroke(255);
    point(locX, locY);
    pop();
  }
}