class Alien{
  PVector location;
  PVector target;
  PVector direction;
  PVector acceleration;
  PVector playerT;
  PVector velocity = new PVector(0,0);
  float topspeed = 2;

  Alien(){
    location = new PVector(random(height), random(width));
    target = new PVector(random(height), random(width));
  }

  void update(){
    checkEdges();
    move();
    draw();
  }

  void draw(){
    push();
    noFill();
    translate(location.x, location.y);
    stroke(255);
    arc(0, 30, 40, 40, PI, TWO_PI);
    beginShape();
    vertex(-25,30);
    vertex(25,30);
    vertex(20,25);
    vertex(-20,25);
    endShape(CLOSE);
    pop();
  }

  void move(){
    float deadzone = 15;
    if(((abs(location.x - target.x) < deadzone)
      || (abs(target.x - location.x) < deadzone))
      && ((abs(location.y - target.y) < deadzone)
      || abs(target.y - location.y) < deadzone)){
          target = new PVector(random(width) ,
                   random(height));
      }
    direction = PVector.sub(target, location);
    direction.normalize();
    direction.mult(0.5);
    acceleration = direction;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

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