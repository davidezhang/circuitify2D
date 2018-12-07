Grid myGrid = new Grid();
int rows = 50;
int cols = 50;
int imageHeight = 1000;
int imageWidth = 1000;
int offset = imageHeight / cols;
PImage picture;
int unvisited = rows*cols;

void setup() {
    picture = loadImage("moun.jpg"); 
    size(1000, 1000);
    background(0);
    image(picture, 0, 0);
    myGrid.createAll();
    myGrid.findAllNeighbors();
    
    //find random point as starting point
    Point start = myGrid.my2D[5][5];
    start.displayMe();
    start.visited = true;
    unvisited--;
    unvisited = myGrid.search(start, unvisited);
    while (unvisited>0) {
        Point next = myGrid.my2D[int(random(50))][int(random(50))];
        unvisited--;
        myGrid.search(next, unvisited);
    }
}
