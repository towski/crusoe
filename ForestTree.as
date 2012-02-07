package{
  //import com.bensilvis.spriteSheet.SpriteSheet;
  
  import flash.display.Bitmap;
  
  //[Embed(source='library/crosshair.png')]
  //private var tree:Bitmap = new crosshairClass ();
  
  public class ForestTree extends Node
  {
    
    public function ForestTree(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0x00EE00);
      walkable = false;
      delay = 10000;
      //currentSprite = new SpriteSheet(sheet, 20, 20);
			
			sprite = new SpriteSheet(sheet, 32, 32);
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			sprite.drawTile(77);
			groundSprite.drawTile(86);
			
      //stage.addChild(currentSprite);
      stage.addChild(sprite)
    }
    
    override public function take(stage:Object, world:World, closure:Function):void{
      super.take(stage, world, closure);
      stage.moving = false;
      stage.updateEnergy(-4);
    }
  }
}