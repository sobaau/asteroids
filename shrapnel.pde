class Shrapnel {
  //Define class variables
  PVector location;
  PVector velocity;
  final float minVel = 0.5;
  final float maxVel = 2;

  /**
    Function: explosion()
    Description: Constructor for the Shrapnel class. Spawns a piece of
                  shrapnel at location specified with a random
                  velocity and direction.
    Parameters: PVector(loc): The location to show the piece of shrapnel.
    Returns: None
  */
  Shrapnel(PVector loc) {
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    velocity.mult(random(minVel, maxVel));
  }

  /**
    Function: update()
    Description: Updates the location of the shrapnel.
    Parameters: None
    Returns: Void
  */
  void update() {
    location.add(velocity);
  }

  /**
    Function: draw()
    Description: draws the shrapnel using a processing point.
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