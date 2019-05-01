class Asteroid {
  PVector location;
  PVector velocity;
  float r;
  int total = floor(random(5, 15));
  float[] offset = new float[total];

  /**************************************************************
   * Function: Asteroid()
   
   * Parameters: PVector(loc): The location to spawn the Asteroid.
   
   * Returns: None
   
   * Desc: Spawns an asteroid at the given Vector location and generates its 
           size and shape to be used when drawing.
   ***************************************************************/
  Asteroid(PVector loc) {
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    r = random(15, 50);
    for (int i = 0; i < total; i++) {
      offset[i] = random(-15, 15);
    }
  }

  /**************************************************************
   * Function: Asteroid()
   
   * Parameters: PVector(loc): The location to spawn the Asteroid.
   float(size): The size of the old asteroid.
   
   * Returns: None
   
   * Desc: Constructor for the Asteroid once its destroyed. Spawns the a 
           new asteroid at the given location and also reduce its size based 
           on the size of the old asteroid.
   ***************************************************************/
  Asteroid(PVector loc, float size) {
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    float scale = 0.5;
    r = size * scale;
    for (int i = 0; i < total; i++) {
      offset[i] = random(-r * scale, r * scale);
    }
  }

  /**************************************************************
   * Function: update()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the location of the asteroid.
   ***************************************************************/
  void update() {
    checkEdges();
    location.add(velocity);
  }

  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Draws the asteroid at a given location and also random generates
           the asteroid.
   ***************************************************************/
  void draw() {
    push();
    stroke(255);
    noFill();
    translate(location.x, location.y);
    beginShape();
    for (int i = 0; i < total; i++) {
      float angle = map(i, 0, total, 0, TWO_PI);
      float t = r + offset[i];
      float x = t * cos(angle);
      float y = t * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    pop();
  }

  /**************************************************************
   * Function: checkEdges()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Checks to see if an Asteroid is off the screen and if so wraps it 
           to the other side of the screen if it is.
   ***************************************************************/
  void checkEdges() {
    if (location.x > width + r) {
      location.x = -r;
    } else if (location.x < -r) {
      location.x = width + r;
    }
    if (location.y > height + r) {
      location.y = -r;
    } else if (location.y < -r) {
      location.y = height + r;
    }
  }
}
