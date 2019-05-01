class Ship{
  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector force;
  boolean isThrusting = false;
  boolean alive;
  int r = 15; // Size of the ship 
  float heading = 0;
  float rotation;

  /**************************************************************
   * Function: Ship()
   
   * Parameters: None
   
   * Returns: None
   
   * Desc: Constructor for the Ship class, Spawns the ship in the middle of the
           screen and sets its status to alive.
   ***************************************************************/
  Ship(){
    location = new PVector(height/2, width/2);
    boolean alive = true;
  }

  /**************************************************************
   * Function: update()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the ships location and checks if the ship is thrusting to turn
           the ship.
   ***************************************************************/
  void update(){
    if (isThrusting){
      thrust();
    }
    location.add(velocity);
    velocity.mult(0.99);
    checkEdges();
    turn();
  }

  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Draws the ship at its location using the triangle function from 
           processing.
   ***************************************************************/
  void draw(){
    float offset = PI / 2;
    push();
    translate(location.x, location.y);
    rotate(heading + offset);
    fill(0);
    stroke(255);
    triangle(-r, r, r, r, 0, -r);
    pop();
  }

  /**************************************************************
   * Function: checkEdges()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Checks if the ship is off the screen and changes its location to
           the other side of the screen if it is.
   ***************************************************************/
  void checkEdges(){
    if (location.x > width + r){
      location.x = -r;
    } else if (location.x < -r){
      location.x = width + r;
    }
    if (location.y > height + r){
      location.y = -r;
    } else if (location.y < -r){
      location.y = height + r;
    }
  }

  /**************************************************************
   * Function: setRotation()
   
   * Parameters: float(x): The number to set rotation to.
   
   * Returns: Void
   
   * Desc: Sets the rotation variable.
   ***************************************************************/
  void setRotation(float x){
    rotation = x;
  }

  /**************************************************************
   * Function: turn()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the heading using the rotation variable.
   ***************************************************************/
  void turn(){
    heading += rotation;
  }

  /**************************************************************
   * Function: thrusting()
   
   * Parameters: boolean(b): The status to set the isThrusting boolean to
   
   * Returns: Void
   
   * Desc: Sets isThrusting to the provided boolean.
   ***************************************************************/
  void thrusting(boolean b){
    isThrusting = b;
  }

  /**************************************************************
   * Function: thrust()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Thrusts the ship forward using a Vector.
   ***************************************************************/
  void thrust(){
    force = PVector.fromAngle(heading);
    force.mult(0.1);
    velocity.add(force);
  }

  /**************************************************************
   * Function: collide()
   
   * Parameters: Asteroid(a): The Asteroid to check.
   
   * Returns: Boolean
   
   * Desc: Checks if the ship is colliding with the provided asteroid.
   ***************************************************************/
  boolean collide(Asteroid a){
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.r){
      return true;
    }
    return false;
  }
}
