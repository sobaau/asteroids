class Explosion {
  //Define class variables
  int explosionTime;
  ArrayList<Shrapnel> shrapnel = new ArrayList<Shrapnel>();

  /**
    Function: Explosion()
    Description: Constructor for the Explosion class.
    Parameters: TODO
    Returns: None
    */
  Explosion(int size, PVector locaion, int time) {
    explosionTime = time;
    playAudio();
    while (shrapnel.size() < size) {
      shrapnel.add(new Shrapnel(locaion));
    }
  }

  /**
    Function: draw()
    Description: Draws the starfield using the stars within the stars array.
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
    soundsCount++;
    explosion.trigger();
  }
}