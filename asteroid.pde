class Asteroid{
  PVector location;
  PVector velocity;
  float minSize;
  float maxSize;
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  /**************************************************************
   * Function: Asteroid()
   
   * Parameters: PVector(loc): The location to spawn the Asteroid.
   
   * Returns: None
   
   * Desc: Spawns an asteroid at the given Vector location and generates its 
           size and shape to be used when drawing.
   ***************************************************************/
  Asteroid(PVector loc){
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    minSize = 30;
    maxSize = 50;
    float a = 0;
    while (a < 360) {
      float x = cos(radians(a)) * random(minSize,maxSize);
      float y = sin(radians(a)) * random(minSize,maxSize);
      vertices.add(new PVector(x,y));
      a += random(15, 40);
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
  Asteroid(PVector loc, float minS, float maxS){
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    minSize = minS - 10;
    maxSize = maxS - 10;
    float a = 0;
    while (a < 360) {
      float x = cos(radians(a)) * random(minSize,maxSize);
      float y = sin(radians(a)) * random(minSize,maxSize);
      vertices.add(new PVector(x,y));
      a += random(15, 40);
    }
  }

  /**************************************************************
   * Function: update()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the location of the asteroid.
   ***************************************************************/
  void update(){
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
  void draw(){
    push();
    stroke(255);
    noFill();
    translate(location.x, location.y);
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y);
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
  void checkEdges(){
    if (location.x > width + maxSize){
      location.x = -maxSize;
    } else if (location.x < -maxSize){
      location.x = width + maxSize;
    }
    if (location.y > height + maxSize){
      location.y = -maxSize;
    } else if (location.y < -maxSize){
      location.y = height + maxSize;
    }
  }

  /**************************************************************
   * Function: playAudio()
   
   * Parameters: None
   
   * Returns: void
   
   * Desc: Plays the astertoid explosion audio file.
   ***************************************************************/
  void playAudio() {
    asteroidHit.play();
  }
}
