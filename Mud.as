package{  
  public class Mud extends Node{
    public function Mud(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 70) {
      super(obj_x, obj_y, stage, world, 28);
    }
    
    override public function after_take(stage:Object, world:World):void{
      super.after_take(stage, world)
    } 
  }
}