int index;

JSONArray Spaces;
JSONArray Chance;
JSONArray Absence;


void loadJSONS() {
  Spaces = loadJSONArray("spaces.json");
  Chance = loadJSONArray("chance.json");
  Absence = loadJSONArray("absence.json");
}
void getSpace(int index) {
  JSONObject Space = Spaces.getJSONObject(index); 
  String c = Space.getString("color");
  color rgb = unhex("FF"+c.substring(1));
  String header = Space.getString("Name");
  String flavor = Space.getString("Flavortext");
  int price = Space.getInt("Price");
  int rent = Space.getInt("Rent");
  int value = Space.getInt("Value");
  println(rgb + ", " + header + ", " + flavor + ", " + price + ", " + rent + ", " + value);
}
