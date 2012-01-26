package{
  public class Bush extends Node{
    public function Bush(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0x00FF00);
      walkable = false;
      //stage.addChild(sprite);
      sprite = new SpriteSheet(sheet, 32, 32);
			sprite.drawTile(78);
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			stage.addChild(sprite)
      delay = 400;
    }
    
    override public function take(stage:Object, world:World, closure:Function):void{
      super.take(stage, world, closure);
    }
  }
}