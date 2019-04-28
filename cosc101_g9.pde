/**************************************************************
* File: a3.pde
* Group: Daniel Harraka, David Preston, Reece Temple, group number
* Date: 26/05/2019
* Course: COSC101 - Software Development Studio 1
* Desc: Asteroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/
Ship player;
Asteroid asteroid;
Shot shot;
int asteroNums = 2;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
int score = 0;

void setup(){
  size(800,800);
  player = new Ship();
  for(int i = 0 ; i < asteroNums; i++){
    asteroid = new Asteroid();
    asteroids.add(asteroid);
  }
}

void draw(){
  background(0);
  collisionDetection();
  drawShots();
  player.update();
  drawAsteroids();
  // draw score
}

/**************************************************************
* Function: drawShots()

* Parameters: None

* Returns: Void

* Desc: Each funciton should have appropriate documentation. 
        This is designed to benefit both the marker and your team mates.
        So it is better to keep it up to date, same with usage in the header comment

***************************************************************/

void drawShots(){ 
  for (int i = 0 ; i < shots.size() ; i++){
    shots.get(i).update();
    if (shots.get(i).location.x > width || shots.get(i).location.y > height
    || shots.get(i).location.x < 0 || shots.get(i).location.y < 0){
      shots.remove(i);
    }
  }
}

/**************************************************************
* Function: drawAsteroids()

* Parameters: None 

* Returns: Void

* Desc: 
***************************************************************/
void drawAsteroids(){
  for(Asteroid a : asteroids){
    a.update();
  }
}

/**************************************************************
* Function: collisionDetection()

* Parameters: None

* Returns: Void

* Desc: 
***************************************************************/
void collisionDetection(){
  for (int i = 0 ; i < shots.size() ; i++){
    for (int j = 0 ; j < asteroids.size() ; j++){
      if (shots.get(i).collide(asteroids.get(j))){
        if (asteroids.get(j).r > 10){
          asteroids.add(new Asteroid(asteroids.get(j).location, asteroids.get(j).r)); // TODO Over 80, Will reduce later.
          asteroids.add(new Asteroid(asteroids.get(j).location, asteroids.get(j).r)); // TODO Over 80, Will reduce later.
        }
        asteroids.remove(j);
        shots.remove(i);
        break;
      }
    }
  }
  for (Asteroid a : asteroids){
    if (player.collide(a)){
      println("Ship Hit");
    }
  }
}

/**************************************************************
* Function: keyPressed()

* Parameters: None

* Returns: Void

* Desc: 
***************************************************************/
void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP){
      player.thrusting(true);
    }
    if (keyCode == DOWN){
    } 
    if (keyCode == RIGHT){
      player.setRotation(0.1);
    }
    if (keyCode == LEFT){
      player.setRotation(-0.1);
    }
  }
  if (key == ' '){
    shot = new Shot(player.location, player.heading);
    shots.add(shot);
  }
}

/**************************************************************
* Function: keyReleased()

* Parameters: None

* Returns: Void

* Desc: 
***************************************************************/
void keyReleased(){
  if (key == CODED){
    if (keyCode == UP){
      player.thrusting(false);
    }
    if (keyCode == DOWN){
    } 
    if (keyCode == RIGHT){
      player.setRotation(0);
    }
    if (keyCode == LEFT){
      player.setRotation(0);
    }
  }
}
