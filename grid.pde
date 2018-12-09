class Grid {
  ArrayList<Point> allPoints = new ArrayList<Point>();
  ArrayList<Point> potentialPoints = new ArrayList<Point>();
  Point[][] my2D = new Point[250][250];

  Point current;
  Point sameDir;
  Point opp;

  Grid() {
  }

  void createAll() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        my2D[x][y] = new Point(x*offset, y*offset, 0);
        //my2D[x][y].displayMe();
        allPoints.add(my2D[x][y]);
      }
    }
  }

  void findAllNeighbors2() {
    for (int x = 0; x < allPoints.size(); x++) {
      Point curr = allPoints.get(x); 
      for (int y = 0; y < allPoints.size(); y++) {
        Point potential = allPoints.get(y);
        if (y!=x && dist(curr.px, curr.py, potential.px, potential.py) < 250) {
          curr.neighbors.add(potential);
        }
      }
    }
  }   

  void findAllNeighbors() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        for (int colNum = x - 1; colNum <= (x + 1); colNum +=1  ) {
          for (int rowNum = y - 1; rowNum <= (y + 1); rowNum +=1  ) {
            if (! ((colNum == x) && (rowNum == y))) {

              //make sure it is within  grid
              if (withinGrid (colNum, rowNum)) {
                //System.out.println("Neighbor of "+ x+ " "+ y + " - " + colNum +" " + rowNum );
                my2D[x][y].neighbors.add(my2D[colNum][rowNum]);
              }
            }
          }
        }
      }
    }
    //for (int x=0; x < my2D[1][1].neighbors.size(); x++) {
    //  print(1);
    //  my2D[1][1].neighbors.get(x).displayMe();
    //}
  }

  private boolean withinGrid(int colNum, int rowNum) {
    if ((colNum < 0) || (rowNum <0) ) {
      return false;    //false if row or col are negative
    }
    if ((colNum >= 250) || (rowNum >= 250)) {
      return false;    //false if row or col are > 250
    }
    return true;
  }


  int search(Point curr, int unvisited_) {
    
    // find potential unvisited opposites 
    for (int x = 0; x < curr.neighbors.size(); x++) {
       Point currNei = curr.neighbors.get(x);
       if (!currNei.visited) {
           potentialPoints.add(currNei);
       }
    }
    
    if (potentialPoints.size() == 0) {  
        return unvisited_;
       
      
    } else {
      
      // parallel lines: high chance that next edge has same dir as previous edge
      for (int x = 0; x < potentialPoints.size(); x++) {
          if (checkDir(curr, potentialPoints.get(x)) == curr.lastDir) {
              sameDir = potentialPoints.get(x);
              break;
          }
        
      }
      
      if (sameDir != null && int(random(10)) > 1) {
          opp = sameDir;
      } else {
        // randomly choose the point to form an edge with
        opp = potentialPoints.get(int(random(0, potentialPoints.size())));
      }
      stroke(255,255,255);
      strokeWeight(1);
      line(curr.px, curr.py, opp.px, opp.py); 
      opp.visited = true;
      opp.lastDir = checkDir(curr, opp);
      unvisited_--;
      potentialPoints.clear();
      return search(opp, unvisited_);
      
    }
  }
  
  private int checkDir(Point p1, Point p2) {
     int dir = 0;
     if (p1.px - 1 == p2.px && p1.py - 1 == p2.py) {
       dir = 1;
     }
     if (p1.px == p2.px && p1.py - 1 == p2.py) {
       dir = 2;
     }
     if (p1.px + 1 == p2.px && p1.py - 1 == p2.py) {
       dir = 3;
     }
     if (p1.px - 1 == p2.px && p1.py == p2.py) {
       dir = 4;
     }
     if (p1.px + 1 == p2.px && p1.py == p2.py) {
       dir = 6;
     }
     if (p1.px - 1 == p2.px && p1.py + 1 == p2.py) {
       dir = 7;
     }
     if (p1.px == p2.px && p1.py + 1 == p2.py) {
       dir = 8;
     }
     if (p1.px + 1 == p2.px && p1.py + 1 == p2.py) {
       dir = 9;
     }
     
     return dir;
    
  }

}
