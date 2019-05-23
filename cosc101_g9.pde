/**************************************************************
 * File: cosc101_g9.pde
 * Group: Daniel Harraka, David Preston, Reece Temple, group 9
 * Date: 26/05/2019
 * Course: COSC101 - Software Development Studio 1
 * Desc: Asteroids is a space-themed multidirectional shooter with asteroids and
         Aliens.
 * Usage: Make sure to run in the processing environment and press play.
 **************************************************************/
//Import required libraries
import ddf.minim.*;
Minim minim;
//Define global variables
JSONArray json;
JSONArray hsData;
Ship player;
Asteroid asteroid;
Shot shot;
Explosion explode;
Alien alien;
DataLB data;
AudioSample shipShot;
AudioSample alienShot;
AudioSample explosion;
AudioSample asteroidHit;
int startingAste = 1;
int level = 1;
int starAmount = 200;
final int minScreenEdge = 0;
final int explosionDuration = 1000;
int periodTimerStart;
int totalGameTimer;
int liveGameTimer;
int dispScreen = 1;
boolean runGame = false;
boolean gameOver = false;
boolean gameRunningLastScan = false;
boolean gameInProgress = false;
boolean endGameDone = false;
boolean alienSpawned = false;
Starfield stars;
OpenScn openScreen;
leaderBoard openLdr;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
String[] Name;
String[] jsonTime;
//Font Change
PFont font1;

/**
  Function: setup()
  Description: TODO
  Parameters: None
  Returns: Void
*/
void setup() {
  fullScreen();
  loadData();
  stars = new Starfield(starAmount);
  openScreen = new OpenScn();
  openLdr = new leaderBoard();
  data = new DataLB();
  //Load audio
  minim = new Minim(this);
  shipShot = minim.loadSample("audio/shotGun.wav", 512);
  alienShot = minim.loadSample("audio/alienShot.wav", 512);
  explosion = minim.loadSample("audio/explosion.wav", 512);
  font1 = loadFont("font/OCRAExtended-48.vlw");
}

/**
  Function: draw()
  Description: TODO
  Parameters: None
  Returns: Void
  */
void draw() {
  noCursor();
  background(0);
  stars.draw();
  gameTimer();
  if (!runGame) {
    switch (dispScreen) {
      case 1 :
        openScreen.draw();
        break;
      case 10 :
        openLdr.draw();
        data.update();
        break;
      default :
        break;	
    }
  } else {
      gameOver = !player.isAlive;

      if (player.isAlive) {
        drawPlayer();
        drawShots();
        drawAsteroids();
        if (alienSpawned) {
          drawAlien();
        }
        if (explosions != null) {
          drawExplosions();
        }
        collisionDetection();
        checkLevelProgress();
      } else {
        // game over. check for new high score and save.
        if (!endGameDone) {
          endGame();
        }
        if (explosions != null) {
          drawExplosions();
        }
      }
    drawStats();
  }
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

/**
  Function: drawExplosions()
  Description: TODO
  Parameters: None
  Returns: Void
  */
void drawExplosions() {
  for (int i = 0; i < explosions.size(); i++) {
    explosions.get(i).draw();
    if ((liveGameTimer - explosions.get(i).explosionTime) > explosionDuration) {
      explosions.remove(i);
    }
  }
  if (explosions.size() == 0) {
  }
}

/**
  Function: drawStats()
  Description: Draws the score, level and lifes remaining to the screen.
  Parameters: None
  Returns: Void
 */
void drawStats() {
  int indent = 15;
  float oppindent = width - 15;
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
  text("SCORE: " + player.getScore(), indent, yTextPos * 2);
  text("LEVEL: " + level, indent, yTextPos * 3);
  text("LIVES: " + player.getLives(), indent, yTextPos * 4);
  text("ENERGY: " + player.energy, indent, yTextPos * 5);
  fill(250, 240, 0);
  textAlign(RIGHT);
  text(backB, oppindent, yTextPos * 1);
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
  Function: collisionDetection()
  Description: Checks if the following are colliding:
                Asteroids with shots.
                Alien shots with the player.
                Asteroids and the player.
                If an alien shot collides with a player it is despawned
                and if a player shot collides with an asteroid the asteroid
                is removed from the array and a smaller one is spawned in 
                its place.
  Parameters: None
  Returns: Void
  */
void collisionDetection() {
  for (int i = shots.size() - 1; i >= 0; i--) {
    //If player shot collides with the alien
    if (alien != null) {
      if (alienSpawned && shots.get(i).collide(alien) && shots.get(i).type != "alien") {
        explosions.add(new Explosion(20, alien.location, liveGameTimer));
        player.addScore(100);
        alienSpawned = false;
        shots.remove(i);
        break;
      }
    }
    //If an alien shot collides with the player
    if (shots.get(i).collide(player) && shots.get(i).type != "player") {
      player.hit();
      shots.remove(i); 
      break;
    }
    //If a shot is out of bounds
    if (shots.get(i).checkBounds()) {
      shots.remove(i); 
      break;
    }
    //Check if asteroid is hit
    for (int j = asteroids.size() - 1; j >= 0; j--) {
      if (shots.get(i).collide(asteroids.get(j))){
        //Check if a player shot hits the asteroid
        if (shots.get(i).type == "player"){
          explosions.add(new Explosion(6, asteroids.get(j).location, liveGameTimer));
          player.addScore(10);
          //If asteroid is still large split it.
          if (asteroids.get(j).minSize > 10) {
            splitAsteroid(asteroids.get(j), 2);
          }
          asteroids.remove(j);
        }
        shots.remove(i);
        break;
      }
    }
  }
  //Check if asteroid hits player
  for (int i = asteroids.size() - 1; i >= 0; i--) {
    if (player.collide(asteroids.get(i))){
      player.hit();
      explosions.add(new Explosion(6, asteroids.get(i).location, liveGameTimer));
      if (asteroids.get(i).minSize > 10) {
        splitAsteroid(asteroids.get(i), 2);
      }
      asteroids.remove(i);
    }
  }
  //Check if alien and player hit each other
  if (alienSpawned && player.collide(alien)) {
    explosions.add(new Explosion(15, alien.location, liveGameTimer));
    player.hit();
    alienSpawned = false;
  }

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
    explosions.clear();
    level = 1;
    totalGameTimer = 0;
    periodTimerStart = millis();
    alienSpawned = false;
    player = new Ship();
    spawnAsteroids(startingAste);
    gameInProgress = true;
    gameOver = false;
}

/**
  Function: endGame()
  Description:
  Parameters: None
  */
void endGame() {
  for (int i = asteroids.size() - 1; i >= 0; i--) {
    explosions.add(new Explosion(6, asteroids.get(i).location, liveGameTimer));
    asteroids.remove(i);
  }
  explosions.add(new Explosion(50, player.location, liveGameTimer));
  if (alien != null) {
    if (alienSpawned) {
      explosions.add(new Explosion(20, alien.location, liveGameTimer));
    }
  }
  endGameDone = true;
}

/**
  Function: checkLevelProgress()
  Description: Checks if the asteroids have been destroyed.
          If they have it increments the level and spwans new
          asteroids. The game gets harder as the levels
          increase.
  Parameters: None
  Returns: Void
 */
void checkLevelProgress() {
  if (asteroids.size() == 0 && !alienSpawned) {
    shots.clear();
    level++;
    if (level > 20) {
      spawnAsteroids(25);
    } else if (level >= 15) {
      spawnAsteroids(20);
    } else if (level >= 10) {
      spawnAsteroids(15);
    } else if (level >= 5) {
      spawnAsteroids(10);
    } else {
      spawnAsteroids(startingAste * level);
    }
    //Once level 2 is reached add aliens to game.
    if (level >= 1) {
      alienSpawned = true;
      alien = new Alien();
    }
  }
}

/**
  Function: loadData()
  Description: Loads the data from the JSON file.
  Parameters: None
  Returns: Void
 */
void loadData() {
  //TODO Call class functions
}

/**
  Function: keyPressed()
  Description: TODO
  Parameters: None
  Returns: Void
  */
void keyPressed(){

  //This section is for the Menu related key presses.
  if (!runGame) {
    //New Game
    if ((keyCode == 'n' || keyCode == 'N') && dispScreen == 1) {
      newGame();
      runGame = true;
      dispScreen = 0;
    }
    //Continue Game
    if ((keyCode == 'c' || keyCode == 'C') && dispScreen == 1) {
      if (gameInProgress) {
        runGame = true;
        dispScreen = 0;
      }
    }
    //Show Leaderboard
    if ((keyCode == 'l' || keyCode == 'L') && dispScreen == 1) {
      dispScreen = 10;
    }
    //Show Help Menu
    if ((keyCode == 'h' || keyCode == 'H') && dispScreen == 1) {
      dispScreen = 20;
    }
    //Exit
    if ((keyCode == 'e' || keyCode == 'E') && dispScreen == 1) {
      exit();
    }
  } else {
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
    if (keyCode == ' ') {
        if (player.energy > 25) {
          shots.add(new Shot(player.location, player.heading));
          player.energy -= 25;
        }
    }
  }
  //Back to Main
  if (keyCode == 'm' || keyCode == 'M') {
    openScreen = new OpenScn();
    dispScreen = 1;
    runGame = false;
  }
  //Remove ESC key current and change to Main Menu
  if (keyCode == ESC) {
    openScreen = new OpenScn();
    dispScreen = 1;
    runGame = false;
    key = 0;
  }
}

/**
  Function: keyReleased()
  Decription: TODO
  Parameters: None
  Returns: Void
  */
void keyReleased() {
  if (runGame) {
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
}