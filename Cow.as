package{
  import flash.utils.*;
  public class Cow extends Node{
    public function Cow(obj_x:int, obj_y:int, stage:Object, world:World){
      super(obj_x, obj_y, stage, world, 0x00AA00);
      walkable = false;
      setInterval(moove, 1000);
      stage.addChild(sprite);
    }
    
    public function moove(){
      var targetNeighbors:Array = world.neighbors(world.world[y][x]);
      var target:Object;
      for(var i = 0; i < targetNeighbors.length; i++){
        if(targetNeighbors[i].walkable){
          target = targetNeighbors[i];
          break;
        }
      }
      if(target){
      }
    }
  }
}