/**************************************************************
 * File: a3.pde
 * Group: Daniel Harraka, David Preston, Reece Temple, group 09
 * Date: 26/05/2019
 * Course: COSC101 - Software Development Studio 1
 * Desc: Asteroids is a ...
 * ...
 * Usage: Make sure to run in the processing environment and press play etc...
 * Notes: If any third party items are use they need to be credited 
          (don't use anything with copyright - unless you have permission)
 * ...
 **************************************************************/
Ship player;
Asteroid asteroid;
Shot shot;
Alien alien;
int startingAste = 20;
int maxAlienShots = 3;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
ArrayList<Shot> eShots = new ArrayList<Shot>();
ArrayList<Star> stars = new ArrayList<Star>();

int score = 0;

void setup(){
  size(800, 800);
  player = new Ship();
  spawnAsteroids(startingAste);
  alien = new Alien();
  while(stars.size() < 100){
    stars.add(new Star());
  }
}

void draw(){
  background(0);
  drawStars();
  collisionDetection();
  drawShots();
  drawPlayer();
  drawAlien();
  if (eShots.size() < maxAlienShots){
    eShots.add(new Shot(alien.location, player.location));
  }
  drawAsteroids();
  // draw score
}

void drawStars(){
  for (Star s: stars){
    s.draw();
  }
}

/**************************************************************
 * Function: drawPlayer()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Updates and draws the players location.
 ***************************************************************/
void drawPlayer(){
  player.update();
  player.draw();
}

/**************************************************************
 * Function: drawAlien()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Updates and draws the aliens location.
 ***************************************************************/
void drawAlien(){
  alien.update();
  alien.draw();
}

/**************************************************************
 * Function: spawnAsteroids()
 
 * Parameters: int(asteroNums): The number of asteroids to spawn.
 
 * Returns: Void
 
 * Desc: Spawns asteroids and makes sure they aren't within a certain distance 
         of the player.
 ***************************************************************/
void spawnAsteroids(int asteroNums){
  int minDistance = 150; // Change this to spawn them closer to the player.
  for (int i = 0; i < asteroNums; i++){
    PVector spawn = new PVector(random(width), random(height));
    while (spawn.dist(player.location) < minDistance){
      spawn = new PVector(random(width), random(height));
    }
    asteroid = new Asteroid(spawn);
    asteroids.add(asteroid);
  }
}

/**************************************************************
 * Function: drawShots()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: Draws both player and alien shots and also removes them from their 
         arrays if they go off the screen.
 ***************************************************************/

void drawShots(){ 
  for (int i = 0; i < shots.size(); i++){
    shots.get(i).update();
    shots.get(i).draw();
    if (shots.get(i).checkBounds()){
      shots.remove(i);
    }
  }
  for (int i = 0; i < eShots.size(); i++){
    eShots.get(i).update();
    eShots.get(i).draw();
    if (eShots.get(i).checkBounds()){
      eShots.remove(i);
    }
  }
}


/**************************************************************
 * Function: drawAsteroids()
 
 * Parameters: None 
 
 * Returns: Void
 
 * Desc: Updates the location of all asteroids in the asteroids array.
 ***************************************************************/
void drawAsteroids(){
  for (Asteroid a : asteroids){
    a.update();
    a.draw();
  }
}

/**************************************************************
 * Function: collisionDetection()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: Checks if the following are colliding:
         Asteroids with shots.
         Alien shots with the player.
         Asteroids and the player.
         If an alien shot collides with a player it is despawned and if a player
         shot collides with an asteroid the asteroid is removed from the array
         and a smaller one is spawned in its place.
 ***************************************************************/
void collisionDetection(){
  for (int i = 0; i < shots.size(); i++){
    for (int j = 0; j < asteroids.size(); j++){
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
  for ( int i = 0; i < eShots.size(); i++){
    if (eShots.get(i).collide(player)){
      println("Alien hit ship");
      eShots.remove(i);
    }
  }
  for (Asteroid a : asteroids){
    if (player.collide(a)){
      println("Ship Hit");
    }
  }
  //TODO If alien and player hit each other do something
  //TODO If playershot hits alien do something
}

/**************************************************************
 * Function: keyPressed()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: 
 ***************************************************************/
void keyPressed(){
  if (key == CODED){
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
  if (keyCode == ' '){
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
