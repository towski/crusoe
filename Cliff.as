package{
  public class Cliff extends Node{
    public function Cliff(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffff);
      takeable = false;
      walkable = false;
      sprite = groundSprite;
  		groundSprite.drawTile(96);
      //  sprite = new SpriteSheet(sheet, 32, 32);
  		//	sprite.x = 32 * x;
  		//	sprite.y = 32 * y;
  		//	sprite.drawTile(105);
  		//	stage.addChild(sprite)
      //} else if(random < 20){
      //  sprite = new SpriteSheet(sheet, 32, 32);
  		//	sprite.x = 32 * x;
  		//	sprite.y = 32 * y;
  		//	sprite.drawTile(89);
  		//	stage.addChild(sprite)
      //}
    }
    
    override public function darken(shade:Number):void {
      //groundSprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(shade, shade, shade));
      //trace(groundSprite.canvasBitmapData.getPixel(0,0))
	    //darkenItem(shade);
    }
  }
}