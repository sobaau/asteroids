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
    Returns: boolean
  */
  boolean writeToFile(String file, JSONArray data) {
    saveJSONArray(data, file);
    return true;
  }

  /**
    Function: isNewHighScore()
    Description: TODO
    Parameters: TODO
    Returns: boolean
  */
  boolean isNewHighScore(int newScore, JSONArray data) {
    for(int i = 0; i < data.size(); i++) {
      JSONObject jsonObj = data.getJSONObject(i);
      int scr = jsonObj.getInt("jsonScr");
      if(newScore > scr) {
      return true;
      }
    }
    //If it is return true
  return false;
  }

  /**
    Function: updateHighScore()
    Description: TODO
    Parameters: TODO
    Returns: voi
  */
  void updateHighScore(int newScore, String name, int time, JSONArray data) {
      JSONObject newObject = new JSONObject();

      newObject.setInt("jsonScr", newScore);
      newObject.setString("name", name);
      newObject.setInt("jsonTime", time);
      newObject.setInt("Rank", data.size()+1);

      data.append(newObject);

      for (int i = data.size() - 1 ; i > 0; i--) {
        
        JSONObject jsonObj = data.getJSONObject(i);
        int scoreOne = jsonObj.getInt("jsonScr");
        jsonObj = data.getJSONObject(i-1);
        int scoreTwo = jsonObj.getInt("jsonScr");

        if (scoreOne > scoreTwo) {
          //get the current value of the last score in the array
          JSONObject tempObj = data.getJSONObject(i-1);

          JSONObject dataObj = data.getJSONObject(i);
          data.setJSONObject(i-1, dataObj);
          
          data.setJSONObject(i, tempObj);
        }
      }
      while (data.size() > 9) {
      data.remove(data.size() - 1);
    }
  }
}