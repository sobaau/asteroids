class Asteroid {
  //Define class variables
  PVector location;
  PVector velocity;
  final float minAngle = 15;
  final float maxAngle = 40;
  float minSize;
  float maxSize;
  final int degInCircle = 360;
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  /**
    Function: Asteroid()
    Description: Spawns an asteroid at the given Vector location and
                  generates its size and shape to be used when drawing.
    Parameters: PVector(loc): The location to spawn the Asteroid.
    Returns: None
  */
  Asteroid(PVector loc) {
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    minSize = 30;
    maxSize = 50;
    float a = 0;

    //Keep adding lines until a complete asteroid is drawn.
    while (a < degInCircle) {
      float x = cos(radians(a)) * random(minSize, maxSize);
      float y = sin(radians(a)) * random(minSize, maxSize);
      vertices.add(new PVector(x,y));
      a += random(minAngle, maxAngle);
    }
  }

  /**
    Function: Asteroid()
    Description: Constructor for the Asteroid once its destroyed. Spawns
                  the a new smaller asteroid at the old asteroids location 
                  and sends it in a random direction.
    Parameters: PVector(loc): The location to spawn the Asteroid.
                float(minS): The min size of the old asteroid.
                float(maxS): The max size of the old asteroid
    Returns: None
  */
  Asteroid(Asteroid oldAster) {
    location = new PVector(oldAster.location.x, oldAster.location.y);
    velocity = PVector.random2D();
    float reduce = 10;
    minSize = oldAster.minSize - reduce;
    maxSize = oldAster.maxSize - reduce;
    float a = 0;

    //Keep adding lines until a complete asteroid is drawn.
    while (a < degInCircle) {
      float x = cos(radians(a)) * random(minSize, maxSize);
      float y = sin(radians(a)) * random(minSize, maxSize);
      vertices.add(new PVector(x,y));
      a += random(minAngle, maxAngle);
    }
  }

  /**
    Function: update()
    Description: Updates the location of the asteroid.
    Parameters: None
    Returns: Void
  */
  void update() {
    checkEdges();
    location.add(velocity);
  }

  /**
    Function: draw()
    Description: Draws the asteroid at a given location and also
                  random generates the asteroid.
    Parameters: None
    Returns: Void
  */
  void draw() {
    push();
    stroke(255);
    fill(0);
    translate(location.x, location.y);
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    pop();
  }

  /**
    Function: checkEdges()
    Description: Checks to see if an Asteroid is off the screen and
                  if so wraps it to the other side of the screen if it is.
    Parameters: None
    Returns: Void
  */
  void checkEdges() {
    if (location.x > width + maxSize) {
      location.x = -maxSize;
    } else if (location.x < -maxSize) {
      location.x = width + maxSize;
    }

    if (location.y > height + maxSize) {
      location.y = -maxSize;
    } else if (location.y < -maxSize) {
      location.y = height + maxSize;
    }
  }

  /**
    Function: getLoc()
    Description: Returns the location of the asteroid.
    Parameters: None
    Returns: PVector
  */
  PVector getLoc() {
    return location;
  }

  /**
    Function: getMaxSize()
    Description: Returns the Max Size of the asteroid.
    Parameters: None
    Returns: float
  */
  float getMaxSize() {
    return maxSize;
  }
}