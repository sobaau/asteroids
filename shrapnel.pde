class Shrapnel {
  //Define class variables
  PVector location;
  PVector velocity;

  /**
    Function: explosion()
    Description: Constructor
    Parameters: PVector(loc): The location to show the explosion.
    Returns: None
    */
  Shrapnel(PVector loc) {
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    velocity.mult(random(0.5, 2));
  }

  /**
    Function: update()
    Description: 
    Parameters: None
    Returns: Void
    */
  void update() {
    location.add(velocity);
  }

  /**
    Function: draw()
    Description: 
    Parameters: None
    Returns: Void
    */
  void draw() {
    push();
    stroke(255);
    strokeWeight(2);
    point(location.x, location.y);
    pop();
  }
}