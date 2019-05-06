class Starfield{
  ArrayList<Star> stars = new ArrayList<Star>();
  
  /**************************************************************
   * Function: Starfield()
   
   * Parameters: int(size): The amount of stars to spawn
   
   * Returns: None
   
   * Desc: Constructor for the Starfield class. Creates the amount of stars
           specified by size.
  ***************************************************************/
  Starfield(int size){
    while(stars.size() < size){
      stars.add(new Star());
    }
  }

  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: draws the starfield using the stars within the stars array.
   ***************************************************************/
  void draw(){
    for (Star s: stars){
      s.draw();
    }
  }
}