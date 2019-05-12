class dataLB {
//Define class variables

/**************************************************************
 * Function: loadData()
 
 * Returns: None
 
 * Desc: Constructor for the dataLB Class
 ***************************************************************/
dataLB() {

}

/**************************************************************
 * Function: loadData()
 
 * Returns: None
 
 * Desc: Constructor for the dataLB Class
 ***************************************************************/
void draw() {
//load JSON file from folder
json = loadJSONArray("json/ldr.json");
JSONArray highscoreData = json.getJSONArray(0);

  for (int i = 0; i < highscoreData.size(); i++) {
    // Get top 10 rank in the array
    JSONObject hsData = highscoreData.getJSONObject(i); 

// Get highscore objects
int rank = hsData.getInt("Rank");
String name = hsData.getString("Name");
int score = hsData.getInt("jsonScr");
String timer = hsData.getString("jsonTime");

}
  //saveJSONArray(highscoreData,"json/ldr.json");
}
}