class Shot{
  PVector location;
  PVector velocity;

  /**************************************************************
  * Function: Shot()

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: None

  * Desc: 
  ***************************************************************/
    Shot(PVector spawnLoc, PVector player){
    location = new PVector(spawnLoc.x, spawnLoc.y);	
    PVector target = PVector.sub(player, spawnLoc);
    velocity = PVector.fromAngle(target.heading());
    velocity.mult(9);
  }
  /**************************************************************
  * Function: Shot()

  * Parameters: None ( could be integer(x), integer(y) or String(myStr))

  * Returns: None

  * Desc: 
  ***************************************************************/
  Shot(PVector spawnLoc, float heading){
    location = new PVector(spawnLoc.x, spawnLoc.y);
    velocity = PVector.fromAngle(heading);
    velocity.mult(9);
  }

  /**************************************************************
  * Function: update()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void update(){
    draw();
    location = location.add(velocity);
  }

  /**************************************************************
  * Function: draw()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void draw(){
    push();
    stroke(255);
    strokeWeight(4);
    point(location.x, location.y);
    pop();
  }

  /**************************************************************
  * Function: collide()

  * Parameters: Asteroid(a)

  * Returns: Boolean

  * Desc: 
  ***************************************************************/
  boolean collide(Asteroid a){
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.r){
      return true;
    }
    return false;
  }
    boolean collide(Ship a){
    float d = dist(location.x, location.y, a.location.x, a.location.y);
    if (d < a.r){
      return true;
    }
    return false;
  }

  boolean checkBounds(){
    if (location.x > width || location.y > height || location.x < 0 
    || location.y < 0){
      return true;
    }
    return false;
  }

}