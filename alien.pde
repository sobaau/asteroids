class Alien{
  PVector location;
  PVector target;
  PVector direction;
  PVector acceleration;
  PVector velocity = new PVector(0, 0);
  float topSpeed = 2;

  /**************************************************************
   * Function: Alien()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Constructor for the Alien, The alien spawns at a random location
           and flies to another one and repeats. 
   ***************************************************************/
  Alien(){
    location = new PVector(random(height), random(width));
    target = new PVector(random(height), random(width));
  }

  /**************************************************************
   * Function: update()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Updates the aliens location using Vectors and also picks a new
           location to fly to when it reaches its target.
   ***************************************************************/
  void update(){
    float deadzone = 15;
    float d = dist(location.x, location.y, target.x, target.y);
    if (d < deadzone){
      target = new PVector(random(width), random(height));
    }
    direction = PVector.sub(target, location);
    direction.normalize();
    direction.mult(0.5);
    acceleration = direction;
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
    checkEdges();
  }

  /**************************************************************
   * Function: draw()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Draws the alien at its location using arcs and vertex's
   ***************************************************************/
  void draw(){
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

  /**************************************************************
   * Function: checkEdges()
   
   * Parameters: None
   
   * Returns: Void
   
   * Desc: Checks if the ship is off the screen and changes its location to
           the other side of the screen if it is.
   ***************************************************************/
  void checkEdges(){
    if (location.x > width){
      location.x = 0;
    } else if (location.x < 0){
      location.x = width;
    }
    if (location.y > height){
      location.y = 0;
    } else if (location.y < 0){
      location.y = height;
    }
  }
}
