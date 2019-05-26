/**************************************************************
 * File: cosc101_g9.pde
 * Group: Daniel Harraka, David Preston, Reece Temple, group 9
 * Date: 26/05/2019
 * Course: COSC101 - Software Development Studio 1
 * Desc: Asteroids is a space-themed multidirectional shooter with 
 asteroids and Aliens.
 * Usage: Make sure to run in the processing environment and press play.
 * Packages required: minim
 **************************************************************/

//Import required libraries
import ddf.minim.*;
//Define global variables
Minim minim;
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
int numOfTopScores = 10;
int dispScreen = 1;
int gameTitleTextSize = 80;
int pageTitleTextSize = 40;
int normalTextSize = 28;
int weaponEnergyReq = 25;
int numExplosAstr = 6;
int numExplosAlien = 15;
int numExplosShip = 50;
float playerRotationRate = 0.08;
boolean runGame = false;
boolean gameOver = true;
boolean enterScore = false;
boolean gameRunningLastScan = false;
boolean gameInProgress = false;
boolean endGameDone = false;
boolean alienSpawned = false;
Starfield stars;
OpenScn openScreen;
LeaderBoard openLdr;
HelpPage helpPage;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Shot> shots = new ArrayList<Shot>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
String highScore = "New high score! Please enter your name";
String name = "";
//Font Change
PFont font1;

/**
  Function: setup()
  Description: This function setups the window, some classes and loads the
                audio files.
  Parameters: None
  Returns: Void
*/
void setup() {
  fullScreen();
  //Declare classes
  stars = new Starfield(starAmount);
  openScreen = new OpenScn();
  helpPage = new HelpPage();
  openLdr = new LeaderBoard();
  data = new DataLB("json/topScores.json");
  //Load audio
  minim = new Minim(this);
  shipShot = minim.loadSample("audio/shotGun.wav", 512);
  alienShot = minim.loadSample("audio/alienShot.wav", 512);
  explosion = minim.loadSample("audio/explosion.wav", 512);
  //Load fonts
  font1 = loadFont("font/OCRAExtended-48.vlw");
}

/**
  Function: draw()
  Description: The main draw loop. This function calls all the other functions
                required to load the various screens and run the game.
  Parameters: None
  Returns: Void
*/
void draw() {
  noCursor();
  background(0);
  stars.draw();
  gameTimer();
  //If game not running, load main menu.
  if (!runGame) {
    switch (dispScreen) {
    //Load main menu
    case 1 :
      openScreen.draw();
      break;
    //Load Leaderboard page
    case 10 :
      if (data.isValid()) {
        openLdr.draw(data.getData());
      }
      break;
    //Load help page
    case 20 :
      helpPage.draw();
      break;
    default :
      break;
    }
  } else {
    //Run game
    gameOver = !player.isAlive;
    if (player.isAlive) {
      drawPlayer();
      drawShots();
      drawAsteroids();
      if (alienSpawned) {
        drawAlien();
      }
      collisionDetection();
      checkLevelProgress();
    } else {
      //Game over. Check for new high score and save.
      if (!endGameDone) {
        //Trigger endGame sequence once.
        endGame();
      }
      checkScore();
    }
    //Draw the explosions if any exist
    if (explosions != null) {
      drawExplosions();
    }
    drawStats();
  }
}

/**
  Function: checkScore()
  Description: Checks if there is a new high score. If there is triggers the
                name entry screen.
  Parameters: None
  Returns: Void
*/
void checkScore() {
  //Check if the file can be read.
  if (data.isValid()) {
    if (data.isNewHighScore(player.getScore())) {
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text(highScore, width/2, height/2);
      text(name, width/2, height/2 + 50);
      enterScore = true;
    }
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
  Description: Updates and draws the aliens location. Fires a shot if the 
                alien has enough energy.
  Parameters: None
  Returns: Void
*/
void drawAlien() {
  alien.update();
  alien.draw();
  if (alien.isAbleToFire()) {
    shots.add(new Shot(alien.getLoc(), player.getLoc()));
    alien.setEnergy(0);
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
  Description: Draws all the explosions. Removes them after they have been
                on the screen long enough.
  Parameters: None
  Returns: Void
*/
void drawExplosions() {
  for (int i = 0; i < explosions.size(); i++) {
    explosions.get(i).draw();
    if ((liveGameTimer - explosions.get(i).explosionTime) > 
          explosionDuration) {
      explosions.remove(i);
    }
  }
}

/**
  Function: drawStats()
  Description: Draws the score, level and lifes remaining to the screen.
  Parameters: None
  Returns: Void
*/
void drawStats() {
  int rIndent = 15;
  float lIndent = width - 15;
  int yTextPos = 20;
  int i = 1;
  String backB = "ESC or M for main menu";
  textFont(font1);
  textSize(22);
  fill(255);
  textAlign(LEFT);
  text("TIME: " + convertTime(liveGameTimer), rIndent, yTextPos * i++);
  text("SCORE: " + player.getScore(), rIndent, yTextPos * i++);
  text("LEVEL: " + level, rIndent, yTextPos * i++);
  text("LIVES: " + player.getLives(), rIndent, yTextPos * i++);
  text("ENERGY: " + player.energy, rIndent, yTextPos * i++);
  fill(250, 240, 0);
  textAlign(RIGHT);
  text(backB, lIndent, yTextPos * 1);
}

/**
  Function: convertTime()
  Description: Converts the format of the time from ms to HH:MM:SS
  Parameters: int(time)
  Returns: String
*/
String convertTime(int time) {
  final int secPerMin = 60;
  final int minPerHr = 60;
  final int milSecPerSec = 1000;
  final int milSecPerMin = secPerMin * milSecPerSec;
  final int milSecPerHr = minPerHr * secPerMin * milSecPerSec;

  return "" + floor(time/milSecPerHr) + ":" + 
    floor(time/milSecPerMin)%minPerHr + ":" + (time/milSecPerSec)%secPerMin;
}

/**
  Function: gameTimer()
  Description: Keeps track of how long the game has been going for. Pauses
                the timer when the game is paused.
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
    while (spawn.dist(player.getLoc()) < minDistance) {
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
               Player shots with the alien.
               Asteroids and the player.
               If an alien shot collides with a player it is despawned
               and if a player shot collides with an asteroid the asteroid
               is removed from the array and a smaller one is spawned in 
               its place.
               If there is a collision it triggers an explosion.
  Parameters: None
  Returns: Void
*/
void collisionDetection() {
  int maxAstreSize = 10;
  int astreScore = 10;
  int alienScore = 100;
  int astreToSplit = 2;
  for (int i = shots.size() - 1; i >= 0; i--) {
    String shooter = shots.get(i).type;
    //If player shot collides with the alien
    if (alienSpawned && shots.get(i).collide(alien) && shooter != "alien") {
      explosions.add(new Explosion(20, alien.location, liveGameTimer));
      player.addScore(alienScore);
      alienSpawned = false;
      shots.remove(i);
      break;
    }
    //If an alien shot collides with the player
    if (shots.get(i).collide(player) && shooter != "player") {
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
      if (shots.get(i).collide(asteroids.get(j))) {
        //Check if a player shot hits the asteroid
        if (shots.get(i).type == "player") {
          explosions.add(new Explosion(numExplosAstr, 
              asteroids.get(j).location, liveGameTimer));
          player.addScore(astreScore);
          //If asteroid is still large split it.
          if (asteroids.get(j).minSize > maxAstreSize) {
            splitAsteroid(asteroids.get(j), astreToSplit);
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
    if (player.collide(asteroids.get(i))) {
      player.hit();
      explosions.add(new Explosion(numExplosAstr, 
          asteroids.get(i).location, liveGameTimer));
      if (asteroids.get(i).minSize > maxAstreSize) {
        splitAsteroid(asteroids.get(i), astreToSplit);
      }
      asteroids.remove(i);
    }
  }
  //Check if alien and player hit each other
  if (alienSpawned && player.collide(alien)) {
    explosions.add(new Explosion(numExplosAlien, 
        alien.location, liveGameTimer));
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
  for (int i = 0; i < x; i++) {
    asteroids.add(new Asteroid(a));
  }
}

/**
  Function: newGame()
  Description: Clears old game if one exists and creates objects 
                for new game.
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
  name = "";
  spawnAsteroids(startingAste);
  gameInProgress = true;
  gameOver = false;
  enterScore = false;
}

/**
  Function: endGame()
  Description: Triggers any remaining objects on the screen to explode and
                removes them.
  Parameters: None
  Returns: Void
*/
void endGame() {
  for (int i = asteroids.size() - 1; i >= 0; i--) {
    explosions.add(new Explosion(numExplosAstr, 
        asteroids.get(i).location, liveGameTimer));
    asteroids.remove(i);
  }
  explosions.add(new Explosion(numExplosShip, 
      player.location, liveGameTimer));
  if (alien != null) {
    if (alienSpawned) {
      explosions.add(new Explosion(numExplosAlien, 
          alien.location, liveGameTimer));
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
    //Once level 3 is reached add aliens to game.
    if (level >= 3) {
      alienSpawned = true;
      alien = new Alien();
    }
  }
}

/**
  Function: keyPressed()
  Description: Checks for keys pressed and calls the appropriate function.
  Parameters: None
  Returns: Void
*/
void keyPressed() {
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
  } else if (enterScore) {
    //This section is for entering the name for a new high score.
    if (keyCode == BACKSPACE) {
      name = name.substring( 0, name.length() - 1);
    }
    //https://forum.processing.org/two/discussion/16079/taking-user-input
    else if ((key >= 'A' && key <= 'Z' || key >= 'a' && key <= 'z' ||
              keyCode == ' ') && (name.length() < 10)) {
      name += key;
    } else if (keyCode == ENTER || keyCode == RETURN) {
      data.updateHighScore(player.getScore(), name, liveGameTimer);
      data.writeToFile();
      enterScore = false;
      dispScreen = 1;
      runGame = false;
    }
  } else {
    //This section is for the Game related key presses.
    if (key == CODED) {
      if (keyCode == UP) {
        player.thrusting(true);
      }
      if (keyCode == DOWN) {
      } 
      if (keyCode == RIGHT) {
        player.turning(true);
        player.setRotation(playerRotationRate);
      }
      if (keyCode == LEFT) {
        player.turning(true);
        player.setRotation(-playerRotationRate);
      }
    }
    if (keyCode == ' ') {
      if (player.isAbleToFire()) {
        shots.add(new Shot(player.getLoc(), player.getHeading()));
        player.subEnergy(weaponEnergyReq);
      }
    }
  }
  //The following keys need to work all time
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
  Description: Checks for keys released and calls the appropriate function.
  Parameters: None
  Returns: Void
*/
void keyReleased() {
  //This section is for the Game related key releases.
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