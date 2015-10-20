public static class SkyManager{
  
  public enum State {
    Idle, Draging, CreatingConnector, CreatingNewStar
  }

  public static float threshold = 10f;
  
  public static ArrayList<Star> garbage;
  
  public static Star[] stars = new Star[0];
  public static Connector[] Connectors = new Connector[0];
  
  public static Stargazer stargazer;
  
  static State currentState = State.Idle;
  
  static Star selectedStar_1;
  static Star selectedStar_2;
  
  static boolean mPressed;
  static float mX;
  static float mY;
  
  public static void update(boolean _kPressed, boolean _mPressed, float _mouseX, float _mouseY){
    // update variables
    mPressed = _mPressed;
    mX = _mouseX;
    mY = _mouseY;
    
    // pressed any key to clear the sky
    if(_kPressed && garbage.size() != stars.length){
      
      //stars = new Star[0];
      //Connectors = new Connector[0];
      for(int i = 0; i < stars.length; i++){
        garbage.add(stars[i]);
      } 
    
    }
    
    // update sky manager variable
    threshold = stargazer.maxCursorSize;
    
    // update collection  
    for(int i = 0; i < stars.length; i++){
      stars[i].update();
    }
    
    // draw Connectors 
    for(int i = 0; i < Connectors.length; i++){
      Connectors[i].update();
    }
    
    // update state and main system
    updateIdleState();
    updateDragingState();
    updateCreatingNewStarState();
    updateConnectorState();
    
    updateCollection();
    //println(currentState);
  }
  
  public static void display(){
    
    // draw Connectors 
    for(int i = 0; i < Connectors.length; i++){
      Connectors[i].display();
    }
    
    // draw connecting line
    if(selectedStar_1 != null){
      stargazer.drawConnectingLine(selectedStar_1.x,selectedStar_1.y,mX,mY);
    }
    
    // draw stars 
    for(int i = 0; i < stars.length; i++){
      stars[i].display();
    } 
  }
  
  private static void updateIdleState(){
    // update some state
    
    if(currentState == State.Idle){
      selectedStar_1 = null;
      selectedStar_2 = null;
      
      //currentState = mPressed ? State.CreatingNewStar : State.Idle; 
    }
    
    if(currentState == State.Draging){
      currentState = mPressed ? State.Draging : State.Idle;
    }
    
  }
  
  private static void updateCreatingNewStarState(){
    
    if(currentState == State.CreatingNewStar && !mPressed){
      // do stuff , add new star
      stargazer.createNewStar();
      
      currentState = State.Idle;
    }
  }
  
  
  private static void updateDragingState(){
    
    if(currentState == State.Idle){
      // start looking a collision
      for(int i = 0; i < stars.length; i++){
        
        // check collision with mouse
        if(dist(mX,mY,stars[i].x,stars[i].y) - stars[i].radius <= threshold){
          
          // if mouse click on this star
          if(mPressed){
            currentState = State.Draging;
            selectedStar_1 = stars[i];
          }
        }// end check collision
      }// end loop
      
      // if no collision
      if(currentState == State.Idle && mPressed){
        currentState = State.CreatingNewStar;
      }
      
    }// end check state
  }
  
   private static void updateConnectorState(){
    
    if(currentState == State.Draging || currentState == State.CreatingConnector){
      // start looking a collision
      for(int i = 0; i < stars.length; i++){

        // check collision with mouse
        if(dist(mX,mY,stars[i].x,stars[i].y) - stars[i].radius <= threshold){
          
          // remove the selected star
          if(stars[i].equals(selectedStar_1) && !mPressed){
            garbage.add(stars[i]);
            currentState = State.Idle;
            return;
          }
          
          currentState = State.CreatingConnector;
          selectedStar_2 = stars[i];
          
          // if mouse is up , then create new Connector
          if(!mPressed){
            stargazer.createConnector(selectedStar_1, stars[i]); 
            currentState = State.Idle;
          }
        }// end check collision
        else {
          
          // if mouse went away from 'selectedStar_2'
          if(stars[i].equals(selectedStar_2)){
            currentState = State.Draging;
            selectedStar_2 = null;
          }  
        }// end check uncollision
        
      }// end loop
    }// end check state
  }
  
  public static void updateCollection(){
    
    // command 'dead' to star in the garbage
    for (int i = 0; i < garbage.size(); i++) {
      garbage.get(i).dead();
    }
    
    // remove star
    ArrayList<Star> starList = new ArrayList<Star>();
     
    for(int i = 0; i < stars.length; i++){
      starList.add(stars[i]);
    }
    
    for (int i = 0; i < garbage.size(); i++) {
      if(garbage.get(i).isDead())
        starList.remove(garbage.get(i));
    }
    
    stars = starList.toArray(new Star[0]);
    
    // remove Connector
    ArrayList<Connector> ConnectorList = new ArrayList<Connector>();
        
    for(int i = 0; i < Connectors.length; i++){
      ConnectorList.add(Connectors[i]);
    }
    
    for(int i = 0; i < ConnectorList.size(); i++){
      for (int j = 0; j < garbage.size(); j++) {
        if(ConnectorList.get(i).hasConnectedWith(garbage.get(j))){
          ConnectorList.get(i).dead();
        }
      }
      
      if(ConnectorList.get(i).isDead())
        ConnectorList.remove(ConnectorList.get(i));
    }
    
    Connectors = ConnectorList.toArray(new Connector[0]);
    
    //garbage.clear();
    for (int i = 0; i < garbage.size(); i++) {
      if(garbage.get(i).isDead())
        garbage.remove(garbage.get(i));
    }
    
  }
  
}