class Star{
  PVector location;
  int starB;
  Star(){
    location = new PVector(random(height), random(width));
    starB = 1;
  }

  void draw(){
    push();
    if(frameCount % 10 == 0){
      starB = int(random(1, 3));
    }
    strokeWeight(starB);
    stroke(255);
    point(location.x, location.y);
    pop();
  }
}