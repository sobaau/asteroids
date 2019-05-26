class DataLB {
  //Define class variables
  int nameLength = 10;
  boolean validData = false;

  /**
    Function: loadData()
    Description: Constructor for the dataLB Class
    Parameters: String(file): the file to be read into the array.
    Returns: None
  */
  DataLB(String file) {
    validData = readFromFile(file);
  }

  /**
    Function: isValid()
    Description: Returns the status of the data.
    Parameters: None
    Returns: boolean
  */
  boolean isValid() {
    return validData;
  }

  /**
    Function: readFromFile()
    Description: Reads the JSON data into an array and checks it's valid.
    Parameters: String(file): the file to be read into the array.
    Returns: boolean
  */
  boolean readFromFile(String file) {
    //load JSON file. Catch error if unable to open.
    try {
      hsData = loadJSONArray(file);
    } catch (Exception e) {
      println("unable to open file");
      return false;
    }
    //Error checking flags
    boolean valid = true;
    int i = 0 ;

    //Check if file read successful
    if (hsData == null) {
      valid = false;
    } else {
      while (valid && i < hsData.size()) {
        //Get one object at a time.
        JSONObject topScoreObj = hsData.getJSONObject(i);

        //Check name contains a value
        if (topScoreObj.isNull("name")) {
          valid = false;
        } else {
          //Check name is an string and no greater than 10 in length.
          //Catch the error if it isn't a string.
          try {   
            String name = topScoreObj.getString("name");
            if (name.length() > nameLength) {
              valid = false;
            }
          } catch (Exception e) {
            valid = false;
          }
        }

        //Check score contains a value
        if (topScoreObj.isNull("score")) {
          valid = false;
        } else {
          //Check score is greater than 0. Throw error if it's not an Int.
          try {
            int scr = topScoreObj.getInt("score");
            if (scr < 0) {
              valid = false;
            }
          } catch (Exception e) {
            valid = false;
          }
        }

        //Check time contains a value
        if (topScoreObj.isNull("time")) {
          valid = false;
        } else {
          //Check time is an Int. Catch the error if it isn't
          try {   
            int timer = topScoreObj.getInt("time");
            if(timer < 1) {
              valid = false;
            }
          } catch (Exception e) {
            valid = false;
          }
        }
        i++;
      }
    }
    return valid;
  }

  /**
    Function: writeToFile()
    Description: Writes the list of top scores to the file. Returns whether
                it was successful or not as a boolean.
    Parameters: String(file): Location of the file.
                JSONArray(data): Array to store in the file.
    Returns: boolean
  */
  boolean writeToFile(String file, JSONArray data) {
    //Try to write to the file. Catch the error if it fails.
    try {
      saveJSONArray(data, file);
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  /**
    Function: isNewHighScore()
    Description: Checks if the new score beats one of the scores on the
                 top 10 leaderboard or if there are empty slots. Returns 
                 whether it was successful or not as a boolean.
    Parameters: int(newScore): the new score to check
                JSONArray(data): the array of data to compare the score with
    Returns: boolean
  */
  boolean isNewHighScore(int newScore, JSONArray data) {
    //Check if there are empty slots on the board.
    if (data.size() < numOfTopScores) {
      return true;
    }
    //Check if the new score beats one of the other scores in the array.
    for(int i = 0; i < data.size(); i++) {
      int scr = data.getJSONObject(i).getInt("score");
      if(newScore > scr) {
        return true;
      }
    }
    //Else it must not be a new high score.
    return false;
  }

  /**
    Function: updateHighScore()
    Description: Adds new high score to array of top scores. Sorts them, and
                removes any excessive objects from the array.
    Parameters: int(newScore): New score to store
                String(name): Name of player
                int(time): Duration of game in ms
                JSONArray(data): Array to store the new score in
    Returns: void
  */
  void updateHighScore(int newScore, String name, int time, JSONArray data) {
    //Create an object for the new score and append to array
    JSONObject newObject = new JSONObject();
    newObject.setInt("score", newScore);
    newObject.setString("name", name);
    newObject.setInt("time", time);
    data.append(newObject);

    //Sort array
    for (int i = data.size() - 1 ; i > 0; i--) {
      int scoreOne = data.getJSONObject(i).getInt("score");
      int scoreTwo = data.getJSONObject(i-1).getInt("score");

      //Check if i > (i - 1)
      if (scoreOne > scoreTwo) {
        //Using a temp object swap the i'th and (i-1)'th objects
        JSONObject tempObj = data.getJSONObject(i-1);
        JSONObject dataObj = data.getJSONObject(i);
        data.setJSONObject(i-1, dataObj);
        data.setJSONObject(i, tempObj);
      }
    }
    //If there are too many scores in the array remove the excessive ones.
    while (data.size() > numOfTopScores) {
      data.remove(data.size() - 1);
    }
  }
}
