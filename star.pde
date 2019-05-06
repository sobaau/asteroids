class Star{
  float locX;
  float locY;
  int starBright;

  /**************************************************************
   * Function: Star()
   
   * Parameters: None
   
   * Returns: None
   
   * Desc: Constructor for the Star class. Spawns a star at a random location 
           within the screen boundaries.
   ***************************************************************/
  Star(){
    locX = random(0, width);
    locY = random(0, height);
    starBright = 1;
  }
  
  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: draws the star using a processing point function and changes its
           brightness every 10 seconds.
   ***************************************************************/
  void draw(){
    push();
    if(frameCount % 10 == 0){
      starBright = int(random(1, 3));
    }
    strokeWeight(starBright);
    stroke(255);
    point(locX, locY);
    pop();
  }
}