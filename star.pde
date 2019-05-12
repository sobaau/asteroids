class Star {
  //Define class variables
  float locX;
  float locY;
  int starBright;

  /**
    Function: Star()
    Description: Constructor for the Star class. Spawns a star at a 
                  random location within the screen boundaries.
    Parameters: None
    Returns: None
  */
  Star() {
    locX = random(screenEdge, width);
    locY = random(screenEdge, height);
    starBright = 1;
  }
  
  /**
    Function: draw()
    Description: draws the star using a processing point function 
                  and changes its brightness every second.
    Parameters: None
    Returns: Void
  */
  void draw() {
    push();
    if (frameCount % 10 == 0) {
      starBright = int(random(1, 3));
    }
    strokeWeight(starBright);
    stroke(255);
    point(locX, locY);
    pop();
  }
}