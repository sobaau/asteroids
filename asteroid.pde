class Asteroid{
  PVector location;
  PVector velocity;
  float r;
  int total = floor(random(5, 15));
  float[] offset = new float[total];

  /**************************************************************
  * Function: Asteroid()

  * Parameters: None

  * Returns: 

  * Desc: 
  ***************************************************************/
  Asteroid(PVector loc){
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    r = random(15, 50);
    for (int i = 0; i < total; i++){
      offset[i] = random(-15, 15);
    }
  }
  
  /**************************************************************
  * Function: Asteroid()

  * Parameters: None

  * Returns: 

  * Desc: 
  ***************************************************************/
  Asteroid(PVector loc, float size){
    location = new PVector(loc.x, loc.y);
    velocity = PVector.random2D();
    r = size * 0.5;
    for (int i = 0; i < total; i++){
      offset[i] = random(-r * 0.5 , r * 0.5);
    }
  }

  /**************************************************************
  * Function: update()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void update(){
    checkEdges();
    move();
    draw();
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
    noFill();
    translate(location.x, location.y);
    beginShape();
    for (int i = 0 ; i < total; i++){
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
  * Function: move()

  * Parameters: None

  * Returns: Void

  * Desc: 
  ***************************************************************/
  void move(){
    location.add(velocity);
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
}