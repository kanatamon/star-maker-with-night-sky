public enum LivingState {Birth, Life, Death}; 

void setup(){
  size(1280,680);
  
  Stargazer stargazer = new Stargazer();
  SkyManager.stargazer = stargazer;
  SkyManager.garbage = new ArrayList<Star>();
  
  stargazer.createNewStar(new Star(width/2, height/2, 10, 50));
  stargazer.createNewStar(new Star(width/4, height/4, 5, 20));
  
}

void draw(){
  background(255);
  drawBg();
 
  SkyManager.update(keyPressed,mousePressed, mouseX, mouseY);
  SkyManager.display();
  
}


void drawBg(){
  noStroke();
  for(int i = 0; i <= height; i ++){
    float a = (1 - i / (float)height) * 255;
    //float interpolation = percent * percent;
    fill(48,24,96,a);
    rect(0,i ,width,1);
  } 
  
  for(float i = 0; i <= height; i++){
   float a = (1 - i / (float)height) * 255;
   fill(0,24,72,a);
   rect(0,i,width,1);
  }
}