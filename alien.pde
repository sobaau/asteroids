class Alien {
  PVector location;
  PVector target;
  PVector direction;
  PVector acceleration;
  PVector velocity = new PVector(0, 0);
  final float topSpeed = 2;
  int energy = 0;

  /**
    Function: Alien()
    Description: Constructor for the Alien, The alien spawns at a
                  random location and flies to another one and repeats.
    Parameters: None
    Returns: Void
  */
  Alien() {
    location = new PVector(random(10, height), random(10, width));
    target = new PVector(random(10, height), random(10, width));
  }

  /**
    Function: update()
    Description: Updates the aliens location using Vectors and
                  also picks a new location to fly to when it reaches
                  its target.
    Parameters: None
    Returns: Void
  */
  void update() {
    float deadzone = 15;
    float d = dist(location.x, location.y, target.x, target.y);

    if (d < deadzone){
      target = new PVector(random(10, width), random(10, height));
    }

    direction = PVector.sub(target, location);
    direction.normalize();
    direction.mult(0.5);
    acceleration = direction;
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
    checkEdges();

    if(frameCount % 1 == 0 && energy <= 100) {
      energy++;
    }
  }

  /**
    Function: draw()
    Description: Draws the alien at its location using arcs and vertex's.
    Parameters: None
    Returns: Void
  */
  void draw() {
    push();
    noFill();
    translate(location.x, location.y);
    stroke(255);
    arc(0, 30, 40, 40, PI, TWO_PI);
    beginShape();
    vertex(-25, 30);
    vertex(25, 30);
    vertex(20, 25);
    vertex(-20, 25);
    endShape(CLOSE);
    pop();
  }

  /**
    Function: checkEdges()
    Description: Checks if the ship is off the screen and changes
                  its location to the other side of the screen if it is.
    Parameters: None
    Returns: Void
  */
  void checkEdges() {
    if (location.x > width) {
      location.x = minScreenEdge;
    } else if (location.x < minScreenEdge) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = minScreenEdge;
    } else if (location.y < minScreenEdge) {
      location.y = height;
    }
  }
}