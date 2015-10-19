 class Stargazer{
   float maxCursorSize;
   
   class Cursor{
     float x1;     
     float y1;
     float x2;
     float y2;
     
     float[] circles;
     
     float maxSize;
     
     Cursor(int totalCircle, float _maxSize, float _x1, float _y1, float _x2, float _y2){
       circles = new float[totalCircle];
       maxSize = _maxSize;
       
       for(int i = 0; i < circles.length; i++){
         circles[i] = i / (float)circles.length * maxSize;
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
         
         float alpha = i / (float)circles.length * 50f;
         
         fill(255,255,255,alpha);
         
         ellipse(x, y, circles[i], circles[i]);
       }
       
       // draw current ending point
       ellipse(x2, y2, maxSize, maxSize);
       
     }
     
   }
   
   public Stargazer(){
     maxCursorSize = 20f;
   }
   
   public Stargazer(float _maxCursorSize){
     maxCursorSize = _maxCursorSize;
   }
   
   public void drawConnectingLine(float x1,float y1,float x2,float y2){
     float dx = x1 - x2;
     float dy = y1 - y2;
     float m = sqrt(pow(dx,2) + pow(dy,2));
      
     new Cursor((int)(m * 0.05f), maxCursorSize, x1, y1, x2, y2).drawCursor();  
   }  
   
   public void createConnector(Star _star_1, Star _star_2){
     Connector newConnector = new Connector(_star_1, _star_2);
     SkyManager.Connectors = (Connector[]) append(SkyManager.Connectors, newConnector);
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
   
   public float getCursorSize(){
     return maxCursorSize;
   }
   
 }