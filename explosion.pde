class Explosion {
  //Define class variables
  int explosionTime;
  ArrayList<Shrapnel> shrapnel = new ArrayList<Shrapnel>();

  /**
    Function: Explosion()
    Description: Constructor for the Explosion class.
                  Creates the amount of shrapnel specified by size.
                  Records what time the explosion occured.
    Parameters: int(size): The amount of pieces of shrapnel to spawn.
                PVector(location): Location of explosion.
                int(time): Game time explosion started.
    Returns: None
  */
  Explosion(int size, PVector location, int time) {
    explosionTime = time;
    playAudio();
    while (shrapnel.size() < size) {
      shrapnel.add(new Shrapnel(location));
    }
  }

  /**
    Function: draw()
    Description: Draws the explosion using the shrapnel within the 
                  shrapnel array.
    Parameters: None
    Returns: Void
  */
  void draw() {
    for (Shrapnel s: shrapnel) {
      s.update();
      s.draw();
    }
  }

  /**
    Function: playAudio()
    Description: Plays the explosion audio file.
    Parameters: None
    Returns: void
  */
  void playAudio() {
    explosion.trigger();
  }
}