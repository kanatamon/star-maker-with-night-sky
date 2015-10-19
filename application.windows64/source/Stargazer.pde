 class Stargazer{
   public color c = color(0);
   
   class Cursor{
     float x1;     
     float y1;
     float x2;
     float y2;
     
     float[] circles;
     
     Cursor(int totalCircle, float _x1, float _y1, float _x2, float _y2){
       circles = new float[totalCircle];
      
       for(int i = 0; i < circles.length; i++){
         circles[i] = i / (float)circles.length * 20.0f;
       }
       
       x1 = _x1;
       y1 = _y1;
       x2 = _x2;
       y2 = _y2;
     }
     
     void drawCursor(){
       
       float dx = x2 - x1;
       float dy = y2 - y1;
       float m = sqrt(pow(dx,2) + pow(dy,2));
       dx = dx / m;  // normalize
       dy = dy / m;  // normalize
       
       float step = m / circles.length;
       
       noStroke();
       ellipseMode(CENTER);
       
       for(int i = 0; i < circles.length; i++){
         float x = dx * step * (float)i + x1;
         float y = dy * step * (float)i + y1;
         
         fill(255,255,255,100);
         
         ellipse(x, y, circles[i], circles[i]);
       }
       
       // draw current ending point
       ellipse(mouseX, mouseY, 20.0f, 20.0f);
       
     }
     
   }
   
   public void drawConnectingLine(float x1,float y1,float x2,float y2){
     float dx = x1 - x2;
     float dy = y1 - y2;
     float m = sqrt(pow(dx,2) + pow(dy,2));
      
     new Cursor((int)(m * 0.05f), x1, y1, x2, y2).drawCursor();  
     
   }  
   
   public void createConnection(Star _star_1, Star _star_2){
     Connection newConnection = new Connection(_star_1, _star_2);
     SkyManager.connections = (Connection[]) append(SkyManager.connections, newConnection);
   }
   
   public void createNewStar(){
     float radius = random(5f,12f);
     float emissionRadius = random(20f,50f) + radius;
     
     Star newStar = new Star(mouseX, mouseY, radius, emissionRadius);
     createNewStar(newStar);  
   }
   
   public void createNewStar(Star newStar){
     SkyManager.stars = (Star[]) append(SkyManager.stars, newStar);
   }
   
 }