class Alien {
  PVector location;
  PVector target;
  PVector direction;
  PVector acceleration;
  PVector velocity = new PVector(0, 0);
  final float hitBoxW = 50;
  final float hitBoxH = 30;
  final float topSpeed = 2;
  final float minWallGap = 10;
  final int maxEnergy = 100;
  final int numFrames = 1;
  int energy = 0;
  boolean isAlive;

  /**
    Function: Alien()
    Description: Constructor for the Alien, The alien spawns at a
                  random location and flies to another one and repeats.
    Parameters: None
    Returns: Void
  */
  Alien() {
    location = new PVector(random(minWallGap, height - minWallGap), 
                            random(minWallGap, width - minWallGap));
    target = new PVector(random(minWallGap, height - minWallGap), 
                            random(minWallGap, width - minWallGap));
    isAlive = true;
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

    if (d < deadzone) {
      target = new PVector(random(minWallGap, height - minWallGap), 
                            random(minWallGap, width - minWallGap));
    }

    direction = PVector.sub(target, location);
    direction.normalize();
    direction.mult(0.5);
    acceleration = direction;
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
    checkEdges();
    
    //Recharge ray gun energy when not full.
    if(frameCount % numFrames == 0 && energy < maxEnergy) {
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
    arc(0, 0, 40, 40, PI, TWO_PI);
    beginShape();
    vertex(-20, -5);
    vertex(20, -5);
    vertex(25, 0);
    vertex(-25, 0);
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

  /**
    Function: getLoc()
    Description: Returns the location of the alien.
    Parameters: None
    Returns: PVector
  */
  PVector getLoc() {
    return location;
  }

  /**
    Function: getWidth()
    Description: Returns the width of the ship.
    Parameters: None
    Returns: float
  */
  float getWidth() {
    return hitBoxW;
  }

  /**
    Function: getHeight()
    Description: Returns the Height of the ship.
    Parameters: None
    Returns: float
  */
  float getHeight() {
    return hitBoxH;
  }
}