int w = 1500;
int h = 1000;
void setup(){
  size(1500,1000);
  frameRate(30);
  strokeWeight(1);
}

Point[] points = {
  
  new Point( //left vertex
  w/4,
  h/4,
  w/4,
  h/4,
  true
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point( //middle vertex
  w/2,
  h/3,
  w/2,
  h/3,
  true
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(
  w/4,
  h/4,
  w/4,
  h/4,
  false
  ),
  
  new Point(//right vertex
  w/2,
  h/2,
  w/2,
  h/2,
  true
  ),
  
  
};

Stick[] sticks = {

  new Stick(
  points[0],
  points[1],
  100
  ),
  
  new Stick(
  points[1],
  points[2],
  100
  ),
  
  new Stick(
  points[2],
  points[3],
  100
  ),
  
  new Stick(
  points[3],
  points[4],
  100
  ),
  
  new Stick(
  points[1],
  points[5],
  100
  ),
  
  new Stick(
  points[5],
  points[6],
  100
  ),
  
  new Stick(
  points[6],
  points[7],
  100
  ),
  
  new Stick(
  points[7],
  points[8],
  100
  ),
  
  new Stick(
  points[8],
  points[9],
  100
  )
  
};

void draw(){
  background(255);
  
  for(int i = 0; i < 30; i++){
  for(Stick s : sticks){
    s.update();
  }
  for(Point p : points){
    p.boundary();
  }
  }
  
  for(Point p : points){
    p.update();
    p.boundary();
    p.render();
  }
  for(Stick s : sticks){
    s.update();
    s.render();
  }
  
}

class Point{
  float x, y, oldx, oldy;
  boolean s;
  Point(float i,float j,float k,float l, boolean h){
    x=i; y=j; oldx = k; oldy = l; s = h;
  }
  
  void update(){
    if(!s){
    float tempx = x;
    float tempy = y;
    x+=x-oldx;
    y+=y-oldy+0.98;
    oldx = tempx;
    oldy = tempy;
  }
  }
  
  void boundary(){
    if(y > height){
      oldy = height+(y-oldy)*0.9;
      y=height;
    }
    if(y < 0){
      oldy = (y-oldy)*0.9;
      y=0;
    }
    if(x > width){
      oldx = width+(x-oldx)*0.9;
      x=width;
    }
    if(x < 0){
      oldx = (x-oldx)*0.9;
      x=0;
    }
  }
  
  void render(){
    if(s){stroke(255,0,0);}
    else{stroke(0);}
    strokeWeight(5);
    point(x,y);
    strokeWeight(1);
  }
}

class Stick{
  
  Point a, b;
  float l;
  
  Stick(Point one, Point two, float dist){
    a = one; b = two; l = dist;
  }
  
  void update(){
  PVector midpoint = new PVector(a.x+(b.x-a.x)/2,a.y+(b.y-a.y)/2);
  float modifier = (dist(a.x,a.y, b.x,b.y)/(l)-1)/2;
  if(!a.s){
  a.x -= (a.x-midpoint.x)*modifier;
  a.y -= (a.y-midpoint.y)*modifier;
  }
  if(!b.s){
  b.x -= (b.x-midpoint.x)*modifier;
  b.y -= (b.y-midpoint.y)*modifier;
  }
  }
  
  void render(){
    stroke(0);
  line(a.x, a.y, b.x, b.y);
  }
  
}
