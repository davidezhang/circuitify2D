class Point {
  int px;
  int py;
  int gridCol;
  int gridRow;
  int edges;
  int lastDir;
  
  Point opposite;
  
  boolean visited = false;
  
  ArrayList<Point> neighbors = new ArrayList<Point>();
  
  Point(int px_, int py_, int edges_) {
    px = px_;
    py = py_;
    edges = edges_;
  }
  
  void displayMe() {
    noStroke();
    fill(255, 0, 0, 50);
    ellipse(px, py, 5, 5);
  }
  
  void search2() {
     for (int x = 0; x < neighbors.size(); x++) {
          Point currNei = neighbors.get(x);
          if (currNei.visited == false && edges < 2) {
              stroke(255,255,255);
              strokeWeight(1);
              line(px, py, currNei.px, currNei.py); 
              currNei.edges = 1;
              edges += 1;
              opposite = currNei;
              currNei.visited = true;
          }
            
     } 
  }
 

  
}
