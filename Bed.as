package{
  public class Bed extends Node{
    public function Bed(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffaa);
      sprite = new SpriteSheet(sheet, 32, 32);
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			sprite.drawTile(135);
      //stage.addChild(currentSprite);
      stage.addChild(sprite)
    } 
    
    override public function place(stage:Object, world:World):void{
      super.place(stage, world);
      stage.bed = this;
    }
  }
}