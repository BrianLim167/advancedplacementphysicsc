public class Tile {
  int row, col;
  float tilesize;
  color avgcolor;
  Splotch[][] region;

  public Tile(int row, int col, float tilesize, color avgcolor) {
    this.row = row;
    this.col = col;
    this.tilesize = tilesize;
    this.avgcolor = avgcolor;
  }
  
  public void displayAvgColor() {
    stroke(0,0,0,0); // transparent outlines
    fill(avgcolor);
    rect(col*tilesize, row*tilesize, tilesize, tilesize);
  }
}