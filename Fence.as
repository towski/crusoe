package{
  import Node
  public class Fence extends Node{
    public function Fence(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xbc8f8f);
      sprite = new SpriteSheet(sheet, 32, 32);
			sprite.x = 32 * x;
			sprite.y = 32 * y;
      sprite.drawTile(16);
      walkable = false;
    }

    override public function requirements_met(stage:Object):Boolean{
      if(stage.wood > 0){
        return true;
      } else {
        return false;
      }
    }
    
    override public function place(stage:Object, world:World):void{
      super.place(stage, world);
      stage.wood -= 1;
      stage.energy -= 1;
    }
    
    override public function take(stage:Object, world:World, closure:Function):void{
      super.take(stage, world, closure);
      stage.wood += 1;
    }
  }
}