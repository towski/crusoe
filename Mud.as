package{  
  public class Mud extends Node{
    public function Mud(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 28) {
      super(obj_x, obj_y, stage, world, groundColor);
    }
    
    override public function afterTake(stage:Object, world:World):void{
      super.afterTake(stage, world)
    } 
  }
}