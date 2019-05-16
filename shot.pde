class Shot {
  //Define class variables
  PVector location;
  PVector velocity;
  String type;

  /**
    Function: Shot()
    Description: Constructor for the Shot class for when a shot needs
                  to be fired at a given location, Doesn't track the target.
                  The shot will spawn at the provided location and be fired 
                  toward the provided target.
    Parameters: PVector(spawnLoc): The location to spawn the shot, 
                PVector(targetLoc): The location of the target that the shot 
                will be fired towards.
    Returns: None
  */
  Shot(PVector spawnLoc, PVector targetLoc) {
    type = "alien";
    location = new PVector(spawnLoc.x, spawnLoc.y);	
    PVector target = PVector.sub(targetLoc, spawnLoc);
    velocity = PVector.fromAngle(target.heading());
    velocity.mult(9);
    playAudio();
  }

  /**
    Function: Shot()
    Description: Constructor for the Shot class, The shot is created
                  at the given location and fired in the direction 
                  that the ship firing it is facing.
    Parameters: PVector(spawnLoc): The location to spawn the shot,
                 float(heading): The heading to fire the shot from.
    Returns: None
  */
  Shot(PVector spawnLoc, float heading) {
    type = "player";
    location = new PVector(spawnLoc.x, spawnLoc.y);
    velocity = PVector.fromAngle(heading);
    velocity.mult(9);
    playAudio();
  }

  /**
    Function: update()
    Description: Updates the location of the shot.
    Parameters: None
    Returns: Void
  */
  void update() {
    location = location.add(velocity);
  }

  /**
    Function: draw()
    Description: Draws the shot using a processing point function.
    Parameters: None
    Returns: Void
  */
  void draw() {
    push();
    stroke(255);
    strokeWeight(4);
    point(location.x, location.y);
    pop();
  }

  /**
    Function: collide()
    Description: Checks if the shot has collided with an asteroid
                  and returns true if it has.
    Parameters: Asteroid(a): The asteroid to check if its been hit.
    Returns: Boolean
  */
  boolean collide(Asteroid a) {
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.maxSize) {
      return true;
    }
    return false;
  }

  /**
    Function: collide()
    Description: Checks if the shot has collided with a ship and returns
                  true if it has.
    Parameters: Ship(s): the ship to check if its been hit.
    Returns: Boolean
  */
  boolean collide(Ship s) {
    float d = dist(location.x, location.y, s.location.x, s.location.y);
    if (d < s.r) {
      return true;
    }
    return false;
  }

  /**
    Function: checkBounds()
    Description: Checks if the shot is off the screen and returns
                  true if it is.
    Parameters: None
    Returns: Boolean
  */
  boolean checkBounds() {
    if (location.x > width || location.y > height 
        || location.x < minScreenEdge || location.y < minScreenEdge) {
      return true;
    }
    return false;
  }

  /**
    Function: playAudio()
    Description: Plays the shot audio file.
    Parameters: None
    Returns: void
  */
  void playAudio() {
    shipShot.amp(0.1);
    shipShot.play();
  }
}