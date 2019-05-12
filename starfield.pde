class Starfield {
  //Define class variables
  ArrayList<Star> stars = new ArrayList<Star>();
  
  /**
    Function: Starfield()
    Description: Constructor for the Starfield class. 
                  Creates the amount of stars specified by size.
    Parameters: int(size): The amount of stars to spawn
    Returns: None
  */
  Starfield(int size) {
    while (stars.size() < size) {
      stars.add(new Star());
    }
  }

  /**
    Function: draw()
    Description: draws the starfield using the stars within the stars array.
    Parameters: None
    Returns: Void
  */
  void draw() {
    for (Star s: stars) {
      s.draw();
    }
  }
}