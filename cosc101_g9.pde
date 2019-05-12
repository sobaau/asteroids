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

	

JSONObject json;

//Import required libraries
import processing.sound.*;
//Define global variables
Ship player;
Asteroid asteroid;
Shot shot;
Alien alien;
//HishScores[] highscores;
SoundFile shipShot;
SoundFile explosion;
SoundFile asteroidHit;
int startingAste = 5;
int score = 0;
int level = 1;
int starAmount = 200;
int highScr = 11;
int minScreenEdge;
boolean runGame;
boolean loadLdr;
boolean helpMn;
boolean opScrn;
Starfield stars;
OpenScn openScreen;
leaderBoard openLdr;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
ArrayList<Shot> eShots = new ArrayList<Shot>();

//Font Change
PFont font1;

void setup(){
  fullScreen();
  //loadData();
  player = new Ship();
  spawnAsteroids(startingAste);
  alien = new Alien();
  stars = new Starfield(starAmount);
  openScreen = new OpenScn();
  openLdr = new leaderBoard();
  //openHelp = new helpMenu();
  //Load audio
  shipShot = new SoundFile(this, "audio/shotGun.wav");
  explosion = new SoundFile(this, "audio/explosion.wav");
  asteroidHit = new SoundFile(this, "audio/asteroidHit.wav");
  font1 = loadFont("font/OCRAExtended-48.vlw");
  opScrn = false; 
  runGame = false; // Change this to false to get the start open.
  loadLdr = false; // Change this to false to get the start open.
}

void draw(){
  background(0);
  stars.draw();
  if (!runGame) {
    if (loadLdr) {
      openLdr.draw();
    } else {
      openScreen.draw();
    }
  } else {
      collisionDetection();
      if(player.getLives() > 0) {
        drawPlayer();
        drawAlien();
        drawShots();
      }
    drawAsteroids();
    drawStats();
    checkLevelProgress();
  }
}

/**************************************************************
 * Function: loadData()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Loads the Highscore Data from json file
 ***************************************************************/
/*void loadData(){
  //load JSON file from folder
  json = loadJSONObject("json/ldr.json");
  //
  JSONArray highscoreData = json.getJSONArray("higschores");
  //Check the size of the highscores array in JSON file
  highscores = new Highscores[highscoreData.size()];

  for (int i = 0; i < highscoresData.Size() || i < highScr; i++) {
    // Get top 10 rank in the array
    JSONObject rank = highscoreData.getJSONObject(i); 
    // Get highscore objects
    JSONObject name = Highscores.getJSONObject("name");
    JSONObject jsonScr = Highscores.getJSONObject("jsonScr");
    JSONObject jsonTime = Highscores.getJSONObject("jsonTime");

    //Put object in array form
    highscores[i] = new Highscores(rank," || ",name," | ",jsonScr," | ",jsonTime);
}
}*/

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
  if (alien.energy > 50){
    eShots.add(new Shot(alien.location, player.location));
    alien.energy = 0;
  }
}

/**************************************************************
 * Function: drawStats()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: Draws the score, level and lifes remaining to the screen.
 ***************************************************************/
void drawStats() {
  int indent = 15;
  float oppindent = width -15;
  int yTextPos = 20;
  int secPerMin = 60;
  int minPerHr = 60;
  int milSecPerSec = 1000;
  int milSecPerMin = secPerMin * milSecPerSec;
  int milSecPerHr = minPerHr * secPerMin * milSecPerSec;
  String backB = "ESC or M for main menu";

  textFont(font1);
  textSize(14);
  fill(255);
  textAlign(LEFT);
  text("TIME: " + floor(millis()/milSecPerHr) + ":" + 
        floor(millis()/milSecPerMin) + ":" + 
        (millis()/milSecPerSec)%secPerMin, indent, yTextPos);
  text("SCORE: " + score, indent, yTextPos*2);
  text("LEVEL: " + level, indent, yTextPos*3);
  text("LIVES: " + player.getLives(), indent, yTextPos*4);
  fill(250,240,0);
   textAlign(RIGHT);
  text(backB,oppindent,yTextPos*1);
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
  for (int i = 0; i < eShots.size(); i++){
    eShots.get(i).update();
    eShots.get(i).draw();
    for (int j = 0; j < asteroids.size(); j++){
      if (eShots.get(i).collide(asteroids.get(j))){
        eShots.remove(i);
        break;
      }
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
  float maxSize;
  float minSize;
  PVector newLoc;

  for (int i = 0; i < shots.size(); i++){
    for (int j = 0; j < asteroids.size(); j++){
      if (shots.get(i).collide(asteroids.get(j))){
        score++;
        if (asteroids.get(j).minSize > 10){
          println("Asteroid Hit");
          minSize = asteroids.get(j).minSize;
          maxSize = asteroids.get(j).maxSize;
          newLoc = asteroids.get(j).location;
          asteroids.add(new Asteroid(newLoc, minSize, maxSize)); 
          asteroids.add(new Asteroid(newLoc, minSize, maxSize));
        }
        asteroids.remove(j);
        asteroid.playAudio();
        shots.remove(i);
        break;
      }
    }
  }
  for ( int i = 0; i < eShots.size(); i++){
    if (eShots.get(i).collide(player)){
      println("Ship Hit");
      eShots.remove(i);
    }
  }
  for (Asteroid a : asteroids){
    if (player.collide(a)){
      println("Ship Hit");
      player.hit();
    }
  }
  //TODO If alien and player hit each other do something
  //TODO If playershot hits alien do something
}

/**************************************************************
 * Function: checkLevelProgress()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Checks if the asteroids have been destroyed.
          If they have it increments the level and spwans new
          asteroids.
 ***************************************************************/
void checkLevelProgress() {
  if (asteroids.size() == 0) {
    println("Level completed");
    level++;
    spawnAsteroids(startingAste*level);
    stars = new Starfield(starAmount);
    alien = new Alien();
  }
}

/**************************************************************
 * Function: keyPressed()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: 
 ***************************************************************/
void keyPressed(){

  //This section is for the Menu related key presses.
  
  //Play Game
  if (keyCode == 'p' || keyCode == 'P') {
    runGame = true;
  }
  //Show Leaderboard
if (keyCode == 'l' || keyCode == 'L') {
    loadLdr = true;
  }
  //Show Help Menu
if (keyCode == 'h' || keyCode == 'H') {
    //helpMn = true;
  }
  //Back to Main
if (keyCode == 'm' || keyCode == 'M') {
    runGame = false;
    loadLdr = false;
    helpMn = false;
  }
  //Exit
  if (keyCode == 'e' || keyCode == 'E' && 
  runGame == false && loadLdr == false  && helpMn == false) {
    exit();
  }

    //Remove ESC key current and change to Main Menu
  if (keyCode == ESC) {
    key =0;
    runGame = false;
    loadLdr = false;
    helpMn = false;
  }

  //This section is for the Game related key presses.
  if (key == CODED){
    if (keyCode == UP){
      player.thrusting(true);
    }
    if (keyCode == DOWN){
    } 
    if (keyCode == RIGHT){
      player.turning(true);
      player.setRotation(0.1);
    }
    if (keyCode == LEFT){
      player.turning(true);
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
      player.turning(false);
      player.setRotation(0);
    }
    if (keyCode == LEFT){
      player.turning(false);
      player.setRotation(0);
    }
  }
}
