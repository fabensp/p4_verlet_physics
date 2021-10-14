int w = 1000;
int h = 1000;
void setup(){
  size(1000,1000);
  frameRate(30);
  strokeWeight(1);
}

Point[] points = {
  
  new Point(
  150,
  0,
  150,
  0,
  true
  ),
  
  new Point(
  50,
  100,
  50,
  100,
  false
  ),
  
  new Point(
  250,
  0,
  250,
  0,
  false
  ),
  
  new Point(
  0,
  350,
  0,
  350,
  false
  ),
  
  new Point(
  100,
  50,
  100,
  50,
  false
  ),
  
  new Point(
  0,
  50,
  0,
  50,
  false
  ),
  
  new Point(
  0,
  350,
  0,
  350,
  false
  ),
  
  new Point(
  0,
  250,
  0,
  250,
  false
  ),
  
  new Point(
  0,
  250,
  0,
  250,
  false
  ),
  
  new Point(
  0,
  350,
  0,
  350,
  false
  ),
  
  new Point(
  0,
  250,
  0,
  250,
  false
  ),
  
  new Point(
  0,
  250,
  0,
  250,
  false
  )
  
};

Stick[] sticks = {

  new Stick( //vert cross head
  points[0],
  points[1],
  sqrt(20000)
  ),
  
  new Stick( //bottom side head
  points[1],
  points[2],
  100
  ),
  
  new Stick( //top side head
  points[2],
  points[0],
  100
  ),
  
  new Stick( //top side head
  points[0],
  points[3],
  100
  ),
  
  new Stick(//bottom side head
  points[3],
  points[1],
  100
  ),
  
  new Stick( //horiz cross head
  points[2],
  points[3],
  sqrt(20000)
  ),
  
  new Stick( //neck side
  points[1],
  points[4],
  60
  ),
  
  new Stick( //neck side
  points[1],
  points[5],
  60
  ),
  
  new Stick( //collarbone
  points[5],
  points[4],
  100
  ),
  
  new Stick( //body side
  points[5],
  points[6],
  100
  ),
  
  new Stick( //body side
  points[4],
  points[7],
  100
  ),
  
  new Stick( // body cross
  points[4],
  points[6],
  sqrt(20000)
  ),
  
  new Stick( //body cross
  points[5],
  points[7],
  sqrt(20000)
  ),
  
  new Stick( //body bottom
  points[6],
  points[7],
  100
  ),
  
  new Stick( // arm
  points[4],
  points[11],
  100
  ),
  
  new Stick( //arm
  points[5],
  points[10],
  100
  ),
  
  new Stick( //leg
  points[9],
  points[6],
  100
  ),
  
  new Stick( //leg
  points[8],
  points[7],
  100
  ),
  
};

void draw(){
  background(255);
  textAlign(CENTER);
  textSize(20);
  fill(0);
  text("click and hold to control dummy",w/2, h/10);
  
  //Check and correct stick lengths. Completed multiple times per frame to reduce jellyness
  for(int i = 0; i < 50; i++){
  for(Stick s : sticks){
    s.update();
  }
  
  //Check and correct points leaving window
  for(Point p : points){
    p.boundary();
  }
  }
  
  // Move points according to physics
  for(Point p : points){
    if(p.s&&mousePressed){p.x-=(p.x-mouseX)/10;p.y -= (p.y-mouseY)/10;}
    p.update();
  }
  
  //draw sticks
  for(Stick s : sticks){
    s.render();
  }
  //draw points
  for(Point p : points){
    p.render();
  }
}

class Point{
  float x, y, oldx, oldy; //coords for pos and past pos, instead of velocity vector
  boolean s; // 'stuck' property, whether the point is mouse-controlled
  Point(float i,float j,float k,float l, boolean h){
    x=i; y=j; oldx = k; oldy = l; s = h;
  }
  
  void update(){
    //if(!s){ //un-commenting all the if statements will make s = true points be "pinned"
    float tempx = x;
    float tempy = y;
    x+=(x-oldx)*0.999;
    y+=(y-oldy+0.98)*0.999;// gives points gravity and air resistance
    oldx = tempx;
    oldy = tempy;
  //}
  }
  
  void boundary(){ //if point leaves window, move it back and switch directions. take away a little bit of energy.
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
  
  void render(){//draw s = true points in red
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
  /*
  calculates midpoint between two points, distance of both points from
  that midpoint, difference between that distance and the desired stick
  length, then moves the point by however much it needs to make the 
  stick the right length. 'modifier' is the percentage by which the
  points need to get shorter.
  */
  PVector midpoint = new PVector(a.x+(b.x-a.x)/2,a.y+(b.y-a.y)/2);
  float modifier = (dist(a.x,a.y, b.x,b.y)/(l)-1)/2;
  //if(!a.s){
  a.x -= (a.x-midpoint.x)*modifier;
  a.y -= (a.y-midpoint.y)*modifier;
  //}
  //if(!b.s){
  b.x -= (b.x-midpoint.x)*modifier;
  b.y -= (b.y-midpoint.y)*modifier;
  //}
  }
  
  void render(){ // draw line between stick points
  stroke(0);
  line(a.x, a.y, b.x, b.y);
  }
  
}
