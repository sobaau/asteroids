class Shot {
  PVector location;
  PVector velocity;

  /**************************************************************
   * Function: Shot()
   
   * Parameters: PVector(spawnLoc): The location to spawn the shot, 
   PVector(targetLoc): The location of the target that the shot 
   will be fired towards
   
   * Returns: None
   
   * Desc: Constructor for the Shot class for when a shot needs to be fired at a 
           given location, Doesn't track the target. The shot will spawn at 
           the provided location and be fired toward the provided target.
   ***************************************************************/
  Shot(PVector spawnLoc, PVector targetLoc) {
    location = new PVector(spawnLoc.x, spawnLoc.y);	
    PVector target = PVector.sub(targetLoc, spawnLoc);
    velocity = PVector.fromAngle(target.heading());
    velocity.mult(9);
  }

  /**************************************************************
   * Function: Shot()
   
   * Parameters: PVector(spawnLoc): The location to spawn the shot,
                 float(heading): The heading to fire the shot from.
   
   * Returns: None
   
   * Desc: Constructor for the Shot class, The shot is created at the given 
           location and fired in the direction that the ship firing it is facing
   ***************************************************************/
  Shot(PVector spawnLoc, float heading) {
    location = new PVector(spawnLoc.x, spawnLoc.y);
    velocity = PVector.fromAngle(heading);
    velocity.mult(9);
  }

  /**************************************************************
   * Function: update()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the location of the shot.
   ***************************************************************/
  void update() {
    location = location.add(velocity);
  }

  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: draws the shot using a processing point function.
   ***************************************************************/
  void draw() {
    push();
    stroke(255);
    strokeWeight(4);
    point(location.x, location.y);
    pop();
  }

  /**************************************************************
   * Function: collide()
   
   * Parameters: Asteroid(a): The asteroid to check if its been hit.
   
   * Returns: Boolean
   
   * Desc: Checks if the shot has collided with an asteroid and returns true if 
           it has.
   ***************************************************************/
  boolean collide(Asteroid a) {
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.r) {
      return true;
    }
    return false;
  }

  /**************************************************************
   * Function: collide()
   
   * Parameters: Ship(s): the ship to check if its been hit.
   
   * Returns: Boolean
   
   * Desc: Checks if the shot has collided with a ship and returns 
           true if it has
   ***************************************************************/
  boolean collide(Ship s) {
    float d = dist(location.x, location.y, s.location.x, s.location.y);
    if (d < s.r) {
      return true;
    }
    return false;
  }

  /**************************************************************
   * Function: checkBounds()
   
   * Parameters: None
   
   * Returns: Boolean
   
   * Desc: Checks if the shot is off the screen and returns true if it is.
   ***************************************************************/
  boolean checkBounds() {
    int screenEdge = 0;
    if (location.x > width || location.y > height || location.x < screenEdge 
      || location.y < screenEdge) {
      return true;
    }
    return false;
  }
}
