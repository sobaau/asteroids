class DataLB {
  //Define class variables

  /**
    Function: loadData()
    Description: Constructor for the dataLB Class
    Parameters: None
    Returns: None
    */
  DataLB() {

  }

  /**
    Function: update()
    Description: TODO
    Parameters: None
    Returns: Void
    */
  void update() {
    readFromFile("json/ldr.json");
  }

  /**
    Function: draw()
    Description: TODO
    Parameters: None
    Returns: Void
    */
  void draw() {
  
  }

  /**
    Function: readFromFile()
    Description: TODO
    Parameters: TODO
    Returns: Void
    */
  boolean readFromFile(String file) {
    //load JSON file
    json = loadJSONArray(file);
    hsData = json.getJSONArray(0);
    
    boolean valid = true;
    int i = 0 ;

    //Check if file read successful
    if (json == null) {
      valid = false;
    } else {
      while (valid && i < hsData.size()) {

        //println(hsData.getJSONObject(i));

        //Get one object
        JSONObject jsonObj = hsData.getJSONObject(i);

        //Check Rank contains a value
        if (jsonObj.isNull("Rank")) {
          valid = false;
        } else {
          //Check Rank is an Int. Catch the error if it isn't
          try {      
            jsonObj.getInt("Rank");
          }
          catch (Exception e) {
            valid = false;
            //println("Rank not an Int");
          }
        }

        i++;
      }
    }    
    return valid;
  }

  //JSONArray highscoreData = json.getJSONArray(0);
    //for (int i = 0; i < json.size(); i++) {
    
      //if (json.getJSONObject(i)

      //I hope this doesn't confuse you but i would only read and check the data is valid
      //in this function. Basically you want to go through the array and ensure it has what
      //you expect. I'd probably change the return type of this function to boolean. Return
      //true if it was successful. False if it failed.

      // Get highscore objects
      /* This doesn't need to be in the loop or in this function.
      i would have a seperate function that prints the data to the screen.
      *//*
      int rank = hsData.getInt("Rank");
      String name = hsData.getString("Name");
      int score = hsData.getInt("jsonScr");
      String timer = hsData.getString("jsonTime");

      println("Rank: " + (rank + 1) + " Name: " + name + " Score: " + score + " Time: " + timer);*/
    //}

// Get top 10 rank in the array
      /*hsData isn't an array. While you are reading a new value
      every iteration of the loop, you're writing over the same
      variable each time. Make hsData an array and increment
      the index each loop. Also, as hsData is created within this loop,
      it's scope is only this loop. Once you exit the loop the variable is
      destroyed (variable scope). If you moved it out of the loop but left it
      in the readFromFile function it would be destroyed once the function ends.
      I would create hsData as part of the class. Then it exists while the class
      exists.
      */


  /**
    Function: writeToFile()
    Description: TODO
    Parameters: TODO
    Returns: Void
    */
  void writeToFile(String file) {

  }

  /**
    Function: isNewHighScore()
    Description: TODO
    Parameters: TODO
    Returns: boolean
    */
  boolean isNewHighScore(int newScore, JSONArray data) {
    //Start at the highest score.
    //Check if the new score is higher than the score in the array.
    //If it is return true
    return true;
  }

  /**
    Function: updateHighScore()
    Description: TODO
    Parameters: TODO
    Returns: 
    */
  void updateHighScore(int newScore, String name, int time, JSONArray data) {
    //Start at the highest score.
    //Check if the new score is higher than the score in the array.
    //If it is return true
    //Hint use the isNewHighScore function for the above few steps.
    //Find where to insert the new score.
    //Copy the previous score into temporary1 variables.
    //Insert new score.
    //Copy next slot into temporary2 variables.
    //Insert temporary1 variables into this slot.
    //repeat previous few steps.
    //Essentially you want to shift down the remaining scores until the last one drops out.
    //But you need to copy what is there before overwriting it. There are a few ways to do
    //this.
  }
}