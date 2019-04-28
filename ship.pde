class Ship{
  PVector location;
  PVector velocity = new PVector(0,0);
  PVector force;
  boolean isThrusting = false;
  // float radians=radians(270); //if your ship is facing up (like in atari game)
  boolean alive;
  int r = 15; // Size of the ship 
  float heading = 0;
  float rotation;

  /**************************************************************
  * Function: Ship()

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: None

  * Desc: 
  ***************************************************************/
  Ship(){
    location = new PVector(height/2, width/2);
    boolean alive = true;
  }

  /**************************************************************
  * Function: update()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void update(){
    if (isThrusting){
      thrust();
    }
    move();
    draw();
    turn();
  }

  /**************************************************************
  * Function: draw()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void draw(){
    checkEdges();
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

  * Desc: 
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

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void setRotation(float x){
    rotation = x;
  }

  /**************************************************************
  * Function: turn()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void turn(){
    heading += rotation;
  }

  /**************************************************************
  * Function: thrusting()

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void thrusting(boolean b){
    isThrusting = b;
}

  /**************************************************************
  * Function: thrust()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void thrust(){
    force = PVector.fromAngle(heading);
    force.mult(0.1);
    velocity.add(force);
  }

  /**************************************************************
  * Function: move()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void move(){
    location.add(velocity);
    velocity.mult(0.99);
  }

  /**************************************************************
  * Function: collide()

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: 

  * Desc: 
  ***************************************************************/
  boolean collide(Asteroid a){
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.r){
      return true;
    }
    return false;
  }
}
