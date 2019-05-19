class Ship {
  //Define class variables
  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector force;
  boolean isAlive;
  boolean isThrusting = false;
  boolean isTurning = false;
  int energy;
  int lives = 3;
  int r = 15; // Size of the ship
  final int safeTimeBetweenDeaths = 1000;
  int gunTemperature = 0;
  int timeOfLastDeath;
  int score;
  float heading = 0;
  float rotation;

  /**
    Function: Ship()
    Description: Constructor for the Ship class, Spawns the ship in the
                  middle of the screen and sets its status to alive.
    Parameters:  None
    Returns: None
    */
  Ship() {
    isAlive = true;
    timeOfLastDeath = 0;
    score = 0;
    energy = 100;
    location = new PVector(width/2, height/2);
  }

  /**
    Function: update()
    Description: Updates the ships location and checks if the ship is
                  thrusting to turn the ship.
    Parameters: None
    Returns: Void
    */
  void update() {
    isAlive = isAlive();
    if (isThrusting) {
      thrust();
    }
    location.add(velocity);
    velocity.mult(0.99);
    checkEdges();
    turn();

    if(frameCount % 1 == 0 && energy < 100) {
      energy++;
    }
  }

  /**
    Function: draw()
    Description: Draws the ship at its location using the triangle
                  function from processing.
    Parameters: None
    Returns: Void
    */
  void draw() {
    float offset = PI / 2;
    push();
    translate(location.x, location.y);
    rotate(heading + offset);
    
    if (isThrusting) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      triangle(-r, r, -r/3, r, -2*r/3, 1.5*r);
      triangle(-r/3, r, r/3, r, 0, 1.5*r);
      triangle(r/3, r, r, r, 2*r/3, 1.5*r);
    }

    if (isTurning) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      if (rotation > 0) {
        triangle(-r, r, -r/3, r, -2*r/3, 2*r);
      } else {
        triangle(r/3, r, r, r, 2*r/3, 2*r);
      }
    }

    fill(0);
    stroke(255);
    triangle(-r, r, r, r, 0, -r);
    pop();
  }

  /**
    Function: checkEdges()
    Description: Checks if the ship is off the screen and changes its
                  location to the other side of the screen if it is.
    Parameters: None
    Returns: Void
    */
  void checkEdges() {
    if (location.x > (width + r)) {
      location.x = -r;
    } else if (location.x < -r) {
      location.x = width + r;
    }
    
    if (location.y > (height + r)) {
      location.y = -r;
    } else if (location.y < -r) {
      location.y = height + r;
    }
  }

  /**
    Function: setRotation()
    Description: Sets the rotation variable.
    Parameters: float(x): The number to set rotation to.
    Returns: Void
    */
  void setRotation(float x) {
    rotation = x;
  }

  /**
    Function: turning()
    Description: Sets isTurning to the provided boolean.
    Parameters: boolean(b): The status to set the isTurning boolean to.
    Returns: Void
    */
  void turning(boolean b) {
    isTurning = b;
  }

  /**
    Function: turn()
    Description: Updates the heading using the rotation variable.
                  Heading is limited to between -2 * PI and 2 * PI.
    Parameters: None
    Returns: Void
    */
  void turn() {
    heading += rotation;
    if ((heading > (2 * PI)) || (heading < (-2 * PI))) {
      heading = 0;
    }
  }

  /**
    Function: thrusting()
    Description: Sets isThrusting to the provided boolean.
    Parameters: boolean(b): The status to set the isThrusting boolean to.
    Returns: Void
    */
  void thrusting(boolean b) {
    isThrusting = b;
  }

  /**
    Function: thrust()
    Description: Thrusts the ship forward using a Vector.
    Parameters: None
    Returns: Void
    */
  void thrust() {
    force = PVector.fromAngle(heading);
    force.mult(0.1);
    velocity.add(force);
  }

  /**
    Function: collide()
    Description: Checks if the ship is colliding with the provided asteroid.
    Parameters: Asteroid(a): The Asteroid to check.
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
    Description: TODO
    Parameters: TODO
    Returns: Boolean
    */
  boolean collide(Alien a) {    
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < 50) {
      return true;
    }
    return false;
  }

  /**
    Function: getLives()
    Description: Returns the number of lives the player has.
    Parameters: None
    Returns: int
    */
  int getLives() {
    return lives;
  }

  /**
    Function: hit()
    Description: Removes a life from the player depending on the time expired 
                 so that the player doesn't die right away.
    Parameters: None
    Returns: Void
    */
  void hit() {
    if (lives > 0 && 
        ((liveGameTimer - timeOfLastDeath) > safeTimeBetweenDeaths)) {
      timeOfLastDeath = liveGameTimer;
      lives--;
    }
  }

  /**
    Function: isAlive()
    Description: TODO
    Parameters: None
    Returns: Boolean
    */
  boolean isAlive() {
    return (lives != 0);
  }

  /**
    Function: addScore()
    Description: TODO
    Parameters: 
    Returns: Void
    */
  void addScore(int x) {
    score+= x;
  }

  /**
    Function: subtractScore()
    Description: TODO
    Parameters: 
    Returns: Void
    */
  void subtractScore(int x) {
    score-= x;
  }

  /**
    Function: getScore()
    Description: TODO
    Parameters: 
    Returns: Int
    */
  int getScore() {
    return score;
  }

  /**
    Function: playAudio()
    Description: Plays the ship explosion audio file.
    Parameters: None
    Returns: void
    */
  void playAudio() {
    explosion.trigger();
  }
}