Tile[][] field;
int tilesize;
PImage img;

public void setup() {
  tilesize = 20;
  size(800, 600);
  field = new Tile[height/tilesize][width/tilesize];
  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[row].length; col++) {
      field[row][col] = new Tile(row, col, tilesize, color(255, 5, 5));
    }
  }
}

public void draw() {

  for (int row=0; row<field.length; row++) {
    for (int col=0; col<field[row].length; col++) {
      field[row][col].displayAvgColor();
    }
  }
}