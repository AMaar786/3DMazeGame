/*

Shahrukh
(SP12-BCS-202)
Talha Abbas
(SP12-BCS-220)



*/
     import ddf.minim.*;
    float x,y,z; // X, Y and Z components
    float transX,transY,transZ;// Translation in coordinates
    float xc, zc;// values of coordinates controls centre of camera
    float camAngle;// angle of the camera...
    boolean mUP,mDOWN,mLEFT,mRIGHT;// for starting and stopping the motion in a direction......
    int totalBoxes = 20;// used to draw boxes for floor and walls....!!
   int speed = 50;    //Controls the movement speed...
   float angleSensitivity = 15;      //controls the 
   int stillBox = 100;        //If mouse pointer leaves the range of 100 the angle will change hence the view will also change...
   int r = 1000;  //distance from camera to camera target in lookmode... 8?
   int LightsMode = 1;// selects lighting mode...
  boolean start=true;// for starting motion
  boolean collision=false;
  boolean play=false;  
int timer=60;
int counter=1;
int check=1000;
int time;
boolean GameOver=false;
int lives=1;
int TextTimer=0;
int i=0;//  PImage bg;// Image
boolean WireFrame=false;
boolean win=false;
boolean lock;
AudioPlayer player;
Minim minim;//audio context

 
 
 //-------------------------------------------** Setting Up Screen **--------------------------------------------------------------
 
 
  void setup(){
  size(800,600,P3D);
  stroke(204, 102, 0); 
 //  bg = loadImage("collision.jpg");
  //Camera Initialization
  x = -500;
  y = height/2;
    y-= 120;
 // z = (height/2.0) / tan(PI*60.0 / 360.0);
  z=6744;
// noFill();
  
  xc = transX - x;
  zc = transZ - z;
  camAngle = 0;
  
  
  time=millis();
  
  //Movement Initialization
   mUP = false;
  mDOWN = false;
  mLEFT = false;
  mRIGHT = false;  
 
 //-----------------------------** Back Ground Music **--------------------------------------------
   minim = new Minim(this);
  player = minim.loadFile("mazerun.mp3",2048);
  player.play();
  player.loop();
  
  
  
  
 //if(){}
}


//------------------------------------------------** Drawing Game Scene  **--------------------------------------------


void draw(){
  
  
  
  if(WireFrame)
  {
  stroke(0,170,0);
  }
  
  
  
  int m =1;
  if(millis() - time >= check){
    i++;
  //  println(i+". tick");//if it is, do something
    time = millis();//also update the stored time
      if(play){
//      println(timer);
      timer--;
      
      if(timer==0)
      {
      
        GameOver=true;
         x = -500;
        z=1000;
      }
      //String time=""+timer;
//text("time"+timer, -550, 180, 1100);
      }  

}
  
  
  
  
//  
//  if(collision)
//  {
// //background(bg); 
//    transX = width/2;
//  transY = height/2;
//  transZ = 0;
//    play=false;
//text("You Failed!", -500, 180, 1000);    
//  }
//  
  if(start)
  {
  decreZ();
  }
  checkDest();
  collisionDetection();
  if(collision)
lifeUpdate();


  //update frame
  background(0);
//drawWalls();
  

  if(LightsMode == 1)
    lights();
  else if(LightsMode == 2)
   noLights();
   
   println(WireFrame);
   
  if(!WireFrame)
  {
  drawWall1();  
  drawWall2();
  drawWall3();
  drawWall4();
  drawFloor();  

}
if(WireFrame)

{
  wire_drawWall1();  
  wire_drawWall2();
  wire_drawWall3();
  wire_drawWall4();
  wire_drawFloor();  

}

  snow();
  textBanner();
  if(play)
{
  
  
  
  
  
  
  if(!lock)
  updateView();
if(!GameOver && !win ){
   movement();}
   else if(GameOver && !win)
 {

  textSize(32);
  fill(255);

   text("Game Over!", -530, 180, 830);
 }

else if(win)
{

  textSize(32);
  fill(255);
   x = -500;
    z=1000;
 
   text("You Win", -530, 180, 830);


}

textSize(32);
fill(255);
pushMatrix();
//rotateY(45);
text("Start!", -550, 180, 1100);
textAlign(CENTER);
if(!GameOver)
text(""+timer, transX, 150, transZ+900);
popMatrix();
}
 
 

println(x+" "+y+" "+z);
    camera(x,y,z,transX,transY,transZ,0,1,0);
  


}

void decreZ()
{
z=z-15;
if(z<=1200){
start=false;
play=true;
}
}
public void updateView(){

    int diffX = mouseX - width/2;
    int diffY = mouseY - width/2;
    
    if(abs(diffX) > stillBox){
      xc = transX - x;
      zc = transZ - z;
  
      camAngle+= diffX/(angleSensitivity*10);
      
      
      //validating camera angle limits...
      if(camAngle < 0)
        camAngle += 360;
      else if (camAngle >= 360)
        camAngle -= 360;
      
      
      // calculating x and y coordinates using polar-coordinates....
      float newxc = r * sin(radians(camAngle));
      float newzc = r * cos(radians(camAngle));
  //println(newxc+" "+newzc);
  //updating translations    
      transX = newxc + x;
      transZ = -newzc + z;
    
       
           
  }
      if (abs(diffY) > stillBox)
      transY += diffY/(angleSensitivity/2);

  
}

void checkDest()
{
if(x>=1200 && x<=1335 && z>=-345 && z<=-200 )

{
win=true;
}
}


 void movement(){
  
  

  
    if(mUP){
      z += zc/speed;
      transZ+= zc/speed;
      x += xc/speed;
      transX+= xc/speed;

    }
    else if(mDOWN){
      z -= zc/speed;
      transZ-= zc/speed;
      z -= xc/speed;
      transZ-= xc/speed;
    }
    if (mRIGHT){
      z += xc/speed; 
      transZ+= xc/speed;
      x -= zc/speed;
      transX-= zc/speed;
    
println(x+" "+z);  
}
    if (mLEFT){
      z -= xc/speed; 
      transZ-= xc/speed;
      x += zc/speed;
      transX+= zc/speed;
    }
       
  
}


public void keyPressed(){
  if(keyCode == UP ){
 
    mUP = true;
  }
  
  else if(keyCode == DOWN ){
 
    mDOWN = true;
  }
  
  else if(keyCode == LEFT ){
    
    mLEFT = true;
  }
  
  else if(keyCode == RIGHT){
 
    mRIGHT = true;
  }
  
  
  if(keyCode == 'w' || keyCode == 'W')
  {
  WireFrame=true;
  }
 if(keyCode == 'n' || keyCode== 'N')
  {
  WireFrame=false;
  }
  if(keyCode == 'z' || keyCode== 'Z')
  {
  if(lock){lock=false;}
  else{lock=true;}
  }
  if(keyCode == 'l' || keyCode== 'L')
{
if(LightsMode==1)
{
  LightsMode=2;
}

else
{
LightsMode=1;
}
}
}

public void keyReleased(){
  if(keyCode == UP ){
    mUP = false;
 
  }
  else if(keyCode == DOWN ){
    mDOWN = false;
 
  }
    
  else if(keyCode == LEFT ){
    mLEFT = false;
 
  }
  
  else if(keyCode == RIGHT){
    mRIGHT = false;
 
  }
  
  
  
  
}





void collisionDetection()
{
//--------------*Collision Detection*-----------------
  if(x>=-465 && x<=-338 && z<=1038 && z>=538 )
  {
    x = -500;
    z=1000;
  
collision=true;
//lifeUpdate();
}

if(x>=8 && x<=188 && z>=340 && z<=485)
{
 x = -500;
    z=1000;
    collision=true;
}


if(x>=-320 && x<=-180 && z>=-40 && z<=40)
{
 x = -500;
    z=1000;
    collision=true;
}
  if(x>=-465 && x<=-338 && z<=278 && z>=-682 )
  {
    x = -500;
    z=1000;
    collision=true;
//lifeUpdate();
  }
  if(x>=-183 && x<=-13 && z<=646 && z>=-638 )
  {
    x = -500;
    z=1000;
    collision=true;
//lifeUpdate();  
}
if(x>=1422)
{

x=1422;

}
  if(x<=-627 && z<=1100)
  {
  
  x = -500;
    z=1000;
    collision=true;
//lifeUpdate();
  }

  if(x>=112 && x<=586 && z<=67 && z>=-983 )
  {
    x = -500;
    z=1000;
    collision=true;
//lifeUpdate();  
}
 if(x>=444 && x<=586 && z<=634 && z>=-983 )
  {
    x = -500;
    z=1000;
collision=true;
//lifeUpdate();
}
  if(x>=739 && x<=860 && z<=200 && z>=-628 )
  {
    x = -500;
    z=1000;
    collision=true;
//lifeUpdate();  
}
  if(x>=1043 && x<=1162 && z<=569 && z>=-641 )
  {
    x = -500;
    z=1000;
    collision=true;
//lifeUpdate();  
}
  if(z<=-983)
  {
  
  x = -500;
    z=1000;
    collision=true;
//lifeUpdate();
  }
  

}







void drawFloor() //draws the floor..
{
int tempx=-700;
int tempz=-1100;
 for(int x1 = 0; x1 < totalBoxes; x1++){
    
       tempx+=100;
   
   for(int z1 = 0; z1 < totalBoxes; z1++){
        
     pushMatrix();
     tempz=tempz+100;
          translate(tempx,300,tempz);
          fill(255,125,125);
          
          box(90);  
        popMatrix();
    }
     tempz=-1100;
  }
 


}


void drawWall1()
{

  //left border wall...
  int tempx=-700;
  int tempz=-1100;
  for(int x1 = 0; x1 < totalBoxes; x1++){
    tempx=((tempx+=100)-90);
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+100;
        
          translate(tempx,165,tempz);
         fill(155,125,125);
          if(z1==19 && x1==0)
//          println(tempx+"  :  "+tempz);
          fill(155,125,125);
          if(x1==0)
          box(90,360,90);  
        popMatrix();
    }
    //int tempx=-700;
//int tempz=-1100;  
}
 
    
}



void drawWall2()
{

  //all maze inner walls....
  
  int tempx=-700;
  int tempz=-1100;
  for(int x1 = 1; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=100));
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+100;
          translate(tempx,75,tempz);
          fill(155,125,125);
         
  //making horizontal obstacle wall no.1 !
       if(x1==4 &&z1==10 || x1==5 &&z1==10)
     {
     
     box(90,360,90);
     }  
     
     //making horizontal obstacle wall no.2 !
     
     
     if(x1==7 &&z1==14 || x1==8 &&z1==14)
     {
     box(90,360,90);
     
     }
     
     //making horizontal obstacle wall no.3 !
     if(x1==10 &&z1==10 || x1==11 &&z1==10)
     {
     box(90,360,90);
     
     }
     
     
     //making horizontal obstacle wall no.4 !
     if(z1==15 && x1==16 ||z1==15 && x1==17 )
   {
     box(90,360,90);
   }
     //making horizontal obstacle wall no.5 !
     if(z1==12 && x1==19 ||z1==12 && x1==20 )
   {
     box(90,360,90);
   }
     
     //leaving a difference of two block between vertical walls using modulus...!
          if(x1%3==0)
          {
  
    //using if statements for making gaps....!
    if(z1==0 && x1==3)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==12 && x1==3)
    {
    z1+=3;
    tempz+=300;
    }    
           
     if(z1==0 && x1==6)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==16 && x1==6)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==10 && x1==9)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==16 && x1==12)
    {
    z1+=3;
    tempz+=300;
    }    
            
    if(z1==0 && x1==15)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==12 && x1==15)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==0 && x1==18)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==15 && x1==18)
    {
    z1+=3;
    tempz+=300;
    }    
    
    
    
        
           
           
    
    
    
    
            //for right border wall...
            if(x1==21)
          
          {
        
            if(z1==7){
            z1+=3;
      tempz+=300;    }
            popMatrix();
                  pushMatrix();
            translate(tempx,165,tempz);
              box(90,360,90);  
        }
          
    else
          box(90,360,90);  
          }
        popMatrix();
    }
    //int tempx=-700;
tempz=-1100;  
}
 
    
}


void drawWall3()
{
//back wall
  int tempx=-700;
  int tempz=-1090;
  for(int x1 = 0; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=90));
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+10;
          translate(tempx,165,tempz);
          fill(155,125,125);
          if(z1==0)
          box(90,360,90);  
        popMatrix();
    }
    //int tempx=-700;
tempz=-1090;  
}
 
    
}


//int xl=0;

void drawWall4()
{


//front wall
  int tempx=-450;
  int tempz=1000;
  for(int x1 = 3; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=90));
    
    for(int z1 = 21; z1 <= 21; z1++){
        pushMatrix();
        //tempz=tempz+10;
          translate(tempx,165,tempz-10);
          
          pushMatrix();
          
          translate(tempx,100,tempz-10);
          
          fill(255);
          //if(xl<=1)
         // ellipse(200, 325, 100, 200);
       //xl++;
          popMatrix();
          
          fill(155,125,125);
          
          box(90,360,90);  
        popMatrix();
    }
    

}
     
}



void wire_drawFloor()
{
int tempx=-700;
int tempz=-1100;
 for(int x1 = 0; x1 < totalBoxes; x1++){
    
       tempx+=100;
   
   for(int z1 = 0; z1 < totalBoxes; z1++){
        
     pushMatrix();
 //    noFill();
     tempz=tempz+100;
          translate(tempx,300,tempz);
          //fill(255,125,125);
          noFill();
          box(90);  
        popMatrix();
    }
     tempz=-1100;
  }
 


}


void wire_drawWall1()
{

  //left border wall...
  int tempx=-700;
  int tempz=-1100;
  for(int x1 = 0; x1 < totalBoxes; x1++){
    tempx=((tempx+=100)-90);
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+100;
        
          translate(tempx,165,tempz);
       noFill();
       //  fill(155,125,125);
          if(z1==19 && x1==0)
//          println(tempx+"  :  "+tempz);
          noFill();
          if(x1==0)
          box(90,360,90);  
        popMatrix();
    }
    //int tempx=-700;
//int tempz=-1100;  
}
 
    
}



void wire_drawWall2()
{

  //all maze inner walls....
  
  int tempx=-700;
  int tempz=-1100;
  for(int x1 = 1; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=100));
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+100;
          translate(tempx,75,tempz);
   noFill();
         
  //making horizontal obstacle wall no.1 !
       if(x1==4 &&z1==10 || x1==5 &&z1==10)
     {
     
     box(90,360,90);
     }  
     
     //making horizontal obstacle wall no.2 !
     
     
     if(x1==7 &&z1==14 || x1==8 &&z1==14)
     {
     box(90,360,90);
     
     }
     
     //making horizontal obstacle wall no.3 !
     if(x1==10 &&z1==10 || x1==11 &&z1==10)
     {
     box(90,360,90);
     
     }
     
     
     //making horizontal obstacle wall no.4 !
     if(z1==15 && x1==16 ||z1==15 && x1==17 )
   {
     box(90,360,90);
   }
     //making horizontal obstacle wall no.5 !
     if(z1==12 && x1==19 ||z1==12 && x1==20 )
   {
     box(90,360,90);
   }
     
     //leaving a difference of two block between vertical walls using modulus...!
          if(x1%3==0)
          {
  
    //using if statements for making gaps....!
    if(z1==0 && x1==3)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==12 && x1==3)
    {
    z1+=3;
    tempz+=300;
    }    
           
     if(z1==0 && x1==6)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==16 && x1==6)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==10 && x1==9)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==16 && x1==12)
    {
    z1+=3;
    tempz+=300;
    }    
            
    if(z1==0 && x1==15)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==12 && x1==15)
    {
    z1+=3;
    tempz+=300;
    }    
           
    if(z1==0 && x1==18)
    {
    z1+=3;
    tempz+=300;
    }    
    
    if(z1==15 && x1==18)
    {
    z1+=3;
    tempz+=300;
    }    
    
    
    
        
           
           
    
    
    
    
            //for right border wall...
            if(x1==21)
          
          {
        
            if(z1==7){
            z1+=3;
      tempz+=300;    }
            popMatrix();
                  pushMatrix();
            translate(tempx,165,tempz);
              box(90,360,90);  
        }
          
    else
          box(90,360,90);  
          }
        popMatrix();
    }
    //int tempx=-700;
tempz=-1100;  
}
 
    
}


void wire_drawWall3()
{
//back wall
  int tempx=-700;
  int tempz=-1090;
  for(int x1 = 0; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=90));
    
    for(int z1 = 0; z1 < totalBoxes; z1++){
        pushMatrix();
        tempz=tempz+10;
          translate(tempx,165,tempz);
          noFill();
          if(z1==0)
          box(90,360,90);  
        popMatrix();
    }
    //int tempx=-700;
tempz=-1090;  
}
 
    
}


//int xl=0;

void wire_drawWall4()
{


//front wall
  int tempx=-450;
  int tempz=1000;
  for(int x1 = 3; x1 < totalBoxes+3; x1++){
    tempx=((tempx+=90));
    
    for(int z1 = 21; z1 <= 21; z1++){
        pushMatrix();
        //tempz=tempz+10;
          translate(tempx,165,tempz-10);
          
          pushMatrix();
          
          translate(tempx,100,tempz-10);
          
          fill(255);
          //if(xl<=1)
         // ellipse(200, 325, 100, 200);
       //xl++;
          popMatrix();
          
          noFill();
          
          box(90,360,90);  
        popMatrix();
    }
    

}
     
}




void snow(){
  fill(255);

//translate(100,10,-100);
  pushMatrix();
 
  translate(-500,0,1100);
   fill(255);
 ellipse(200, 325, 200, 200);
  ellipse(200,150, 150, 150);
  ellipse(200, 25, 100, 100);
    fill(0,0,0);
  popMatrix();

pushMatrix();
translate(-500,-100,1100);
  fill(0,0,0);
  ellipse(175,110,10,15);
  ellipse(210,110,10,15);
  popMatrix();
  pushMatrix();
  
  translate(-400,-35,1100);
  fill(245,163,10);
  triangle(95,60,70,65,88,53);
popMatrix();
noStroke();
pushMatrix();
translate(-450,-160,1100);

rect(100,100,100,40);
  rect(75,140,150,20);
popMatrix();
}





void textBanner()
{
fill(0);
  
  pushMatrix();
  translate(0,-120,1100);
rect(-150,140,800,10);
rect(-150,140,10,260);
rect(-150,400,800,10);
rect(650,140,10,270);


popMatrix();
  
  textSize(70);



text("The 3D ",0,100,1050);
text("MAZE ",250,150,1050);
text("GAME! ",500,200,1050);




}
void lifeUpdate()
{

collision=false;
  lives--;
  
  textSize(32);
  fill(255);
if(lives<=0)
GameOver=true;

TextTimer=0;


}
