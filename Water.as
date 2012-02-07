package{
  public class Water extends Node{
    public function Water(obj_x:int, obj_y:int, stage:Object, world:World) {
      
			var random:int = Math.floor(Math.random() * 101);
			var color:int;
      if(random < 50){
  			color = 114;
      } else {
  		  color = 130;
      }
      super(obj_x, obj_y, stage, world, color);
      takeable = false;
      walkable = false;
      //darken(stage.shadeFromBase())
			
    } 
  }
}