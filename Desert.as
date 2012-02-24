package{
  public class Desert extends Node{
    public function Desert(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 190);
      takeable = false;
    } 
  }
}