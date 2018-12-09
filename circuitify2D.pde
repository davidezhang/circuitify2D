Grid myGrid = new Grid();
int rows = 250;
int cols = 250;
int imageHeight = 1000;
int imageWidth = 1000;
int offset = imageHeight / cols;
PImage picture;
int unvisited = rows*cols;
int saveCount = 0;
int strokeWei = 1;

void setup() {
    //picture = loadImage("moun.jpg"); 
    size(1000, 1000);
    background(0);
    //image(picture, 0, 0);
    myGrid.createAll();
    myGrid.findAllNeighbors();
    
    //find random point as starting point
    Point start = myGrid.my2D[50][50];
    
    //give start point random previous direction
    start.lastDir = 1;
    
    start.displayMe();
    start.visited = true;
    unvisited--;
    unvisited = myGrid.search(start, unvisited, strokeWei);
    
    while (unvisited>60000) {
        Point next = myGrid.my2D[int(random(cols))][int(random(rows))];
        unvisited--;
        
        strokeWei = 1;
        
        if (unvisited % 3 == 0) {
           strokeWei = int(random(2,4)); 
        }
        
        if (unvisited % 25 == 0) {
           strokeWei = 8; 
        }
        
        myGrid.search(next, unvisited, strokeWei);
    }
    save("jpgs/"+saveCount+".jpg");
    saveCount++;
}
