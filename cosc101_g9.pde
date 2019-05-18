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
//Import required libraries
import processing.sound.*;
//Define global variables
JSONArray json;
Ship player;
Asteroid asteroid;
Shot shot;
Alien alien;
SoundFile shipShot;
SoundFile explosion;
SoundFile asteroidHit;
int startingAste = 1;
int score = 0;
int level = 1;
int starAmount = 200;
int highScr = 11;
final int minScreenEdge = 0;
int highscores;
int periodTimerStart;
int totalGameTimer;
int liveGameTimer;
boolean runGame;
boolean gameOver;
boolean gameRunningLastScan;
boolean gameInProgress;
boolean aliensAdded;
boolean loadLdr;
boolean helpMn;
boolean opScrn;
Starfield stars;
OpenScn openScreen;
leaderBoard openLdr;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
String[] Name;
String[] jsonTime;
//Font Change
PFont font1;

void setup(){
  fullScreen();
  loadData();
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
  runGame = false;
  gameOver = false;
  gameRunningLastScan = false;
  gameInProgress = false;
  loadLdr = false;
}

void draw(){
  noCursor();
  background(0);
  stars.draw();
  gameTimer();
  if (!runGame) {
    if (loadLdr) {
      openLdr.draw();
    } else {
      openScreen.draw();
    }
  } else {
      gameOver = !player.isAlive;

      if (player.isAlive) {
        drawPlayer();
        drawShots();
        drawAsteroids();
        if (aliensAdded) {
          drawAlien();
        }
        collisionDetection();
        checkLevelProgress();
      } else {
        // game over. check for new high score and save.
      }
    drawStats();
  }
}

/**************************************************************
 * Function: loadData()
 
 * Parameters: None.
 
 * Returns: Void
 
 * Desc: Loads the data from the JSON file.
 ***************************************************************/
void loadData(){
//Call class functions
}

/**
  Function: drawPlayer()
  Description: Updates and draws the players location.
  Parameters: None
  Returns: Void
*/
void drawPlayer() {
  player.update();
  player.draw();
}

/**
  Function: drawAlien()
  Description: Updates and draws the aliens location.
  Parameters: None
  Returns: Void
*/
void drawAlien() {
  alien.update();
  alien.draw();
  if (alien.energy > 50) {
    shots.add(new Shot(alien.location, player.location));
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
  final int secPerMin = 60;
  final int minPerHr = 60;
  final int milSecPerSec = 1000;
  final int milSecPerMin = secPerMin * milSecPerSec;
  final int milSecPerHr = minPerHr * secPerMin * milSecPerSec;
  String backB = "ESC or M for main menu";
  textFont(font1);
  textSize(14);
  fill(255);
  textAlign(LEFT);
  text("TIME: " + floor(liveGameTimer/milSecPerHr) + ":" + 
        floor(liveGameTimer/milSecPerMin) + ":" + 
        (liveGameTimer/milSecPerSec)%secPerMin, indent, yTextPos);
  text("SCORE: " + score, indent, yTextPos*2);
  text("LEVEL: " + level, indent, yTextPos*3);
  text("LIVES: " + player.getLives(), indent, yTextPos*4);
  fill(250,240,0);
   textAlign(RIGHT);
  text(backB,oppindent,yTextPos*1);
}

/**
  Function: gameTimer()
  Description: TODO
  Parameters: None
  Returns: Void
*/
void gameTimer() {

  //Transition to game running
  if (!gameRunningLastScan && runGame) {
    periodTimerStart = millis();
    gameRunningLastScan = true;
  }

  //Transition to game not running
  if (gameRunningLastScan && !runGame) {
    totalGameTimer+= millis() - periodTimerStart;
    gameRunningLastScan = false;
  }

  //Game continues running
  if (gameRunningLastScan && runGame && !gameOver) {
    liveGameTimer = totalGameTimer + millis() - periodTimerStart;
  }
}

/**
  Function: spawnAsteroids()
  Description: Spawns asteroids and makes sure they aren't within a
                certain distance of the player.
  Parameters: int(asteroNums): The number of asteroids to spawn.
  Returns: Void
*/
void spawnAsteroids(int asteroNums) {
  int minDistance = 150; // Change this to spawn them closer to the player.
  for (int i = 0; i < asteroNums; i++) {
    PVector spawn = new PVector(random(width), random(height));
    while (spawn.dist(player.location) < minDistance) {
      spawn = new PVector(random(width), random(height));
    }
    asteroid = new Asteroid(spawn);
    asteroids.add(asteroid);
  }
}

/**
  Function: drawShots()
  Description: Draws both player and alien shots and also removes them 
                from their arrays if they go off the screen. 
  Parameters: None
  Returns: Void
*/
void drawShots() { 
  for (Shot s : shots) {
    s.update();
    s.draw();
  }
}

/**
  Function: drawAsteroids()
  Description: Updates the location of all asteroids in the asteroids array.
  Parameters: None 
  Returns: Void
*/
void drawAsteroids() {
  for (Asteroid a : asteroids) {
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
  for (int i = shots.size() - 1; i >= 0; i--){
    if (shots.get(i).collide(player) && shots.get(i).type != "player"){
      println("Player hit by alien");
      player.hit();
      shots.remove(i); 
      break;
    }
    if (shots.get(i).checkBounds()){
      shots.remove(i); 
      break;
    }
    for (int j = asteroids.size() - 1; j >= 0; j--){
      if (shots.get(i).collide(asteroids.get(j))){
        if (shots.get(i).type == "player"){
          score++;
          if (asteroids.get(j).minSize > 10){
            println("Asteroid Hit");
            splitAsteroid(asteroids.get(j), 2);
          }
          asteroids.remove(j);
          asteroid.playAudio();
        }
        shots.remove(i);
        break;
      }
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


/**
  Function: splitAsteroid()
  Description: Splits the asteroids by the provided times.
  Parameters: Asteroid(a): The asteroid to split.
              int(x): The amount of times to split it.
  Returns: Void
*/
void splitAsteroid(Asteroid a, int x) {
  for(int i = 0; i < x; i++) {
    asteroids.add(new Asteroid(a));
  }
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
    level++;
    spawnAsteroids(startingAste * level);
    alien = new Alien();
    aliensAdded = true;
  }
}

/**
  Function: closeMenu()
  Description: Close's any open menus.
  Parameters: None
  Returns: Void
*/
void closeMenu(){
  openScreen = new OpenScn();
  runGame = false;
  loadLdr = false;
  helpMn = false;
}

/**
  Function: newGame()
  Description: Clears old game if one exists and creates objects for new
                game.
  Parameters: None
  Returns: Void
*/
void newGame() {
    asteroids.clear();
    shots.clear();
    score = 0;
    level = 1;
    aliensAdded = false;
    totalGameTimer = 0;
    periodTimerStart = millis();

    player = new Ship();
    spawnAsteroids(startingAste);
    gameInProgress = true;
    gameOver = false;
}

/**************************************************************
 * Function: keyPressed()
 
 * Parameters: None
 
 * Returns: Void
 
 * Desc: 
 ***************************************************************/
void keyPressed(){
  //This section is for the Menu related key presses.
  //New Game
  if (keyCode == 'n' || keyCode == 'N') {
    newGame();
    runGame = true;
  }
  //Continue Game
  if (keyCode == 'c' || keyCode == 'C') {
    if (gameInProgress) {
      runGame = true;
    }
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
    closeMenu();
  }
  //Exit
  if (keyCode == 'e' || keyCode == 'E' && 
      runGame == false && loadLdr == false  && helpMn == false) {
    exit();
  }
  //Remove ESC key current and change to Main Menu
  if (keyCode == ESC) {
    key = 0;
    closeMenu();
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
      shots.add(new Shot(player.location, player.heading));
    }
}

/**
  Function: keyReleased()
  Decription: TODO
  Parameters: None
  Returns: Void
*/
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.thrusting(false);
    }
    if (keyCode == DOWN) {
    } 
    if (keyCode == RIGHT) {
      player.turning(false);
      player.setRotation(0);
    }
    if (keyCode == LEFT) {
      player.turning(false);
      player.setRotation(0);
    }
  }
}