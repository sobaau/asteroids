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
    hsData = loadJSONArray(file);
    boolean valid = true;
    int i = 0 ;

    //Check if file read successful
    if (hsData == null) {
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
            int rank = jsonObj.getInt("Rank");
            if((rank < 1) || (rank > 10)) {
              valid = false;
            }
          }
          catch (Exception e) {
            valid = false;
            //println("Rank not an Int");
          }
        }

        //Check Name contains a value
        if (jsonObj.isNull("Name")) {
          valid = false;
        } else {
          //Check Name is an string no greater than 10 in length Catch the error if it isn't
          try {   
            String name = jsonObj.getString("Name");
            if(name.length() > 10) {
              valid = false;
            }
          }
          catch (Exception e) {
            valid = false;
            //println("Name not a String or too long/blank");
          }
        }


        //Check jsonScr contains a value
        if (jsonObj.isNull("jsonScr")) {
          valid = false;
        } else {
          //Check jsonScr is greater than 0
          try {   
            int scr = jsonObj.getInt("jsonScr");
            if(scr < 0) {
              valid = false;
            }
          }
          catch (Exception e) {
            valid = false;
            //println("jsonScr not an Int or is less than 1");
          }
        }

        if (jsonObj.isNull("jsonTime")) {
          valid = false;
        } else {
          //Check jsonTime is an Int. Catch the error if it isn't
          try {   
            int timer = jsonObj.getInt("jsonTime");
            if(timer < 1) {
              valid = false;
            }
          }
          catch (Exception e) {
            valid = false;
            //println("jsonTime not an Int");
          }
        }
        i++;
      }
    }
    return valid;
  }

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
    boolean higher = false;

    for(int i = 0; i < data.size(); i++) {
      JSONObject jsonObj = data.getJSONObject(i);
      int scr = jsonObj.getInt("jsonScr");
      if(newScore > scr) {
      
      }
    }
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