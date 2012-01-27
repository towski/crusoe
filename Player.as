package{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Rectangle;
  import flash.geom.ColorTransform;
  
  public class Player{ 
    
    public var sprite:SpriteSheet;
    //[Embed(source='player.png')]
    //private var playerClass:Class;
		//public var sprite:Bitmap = new playerClass();
		
		[Embed(source='char.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		
    //private var tree:Bitmap = new crosshairClass ();
    public var x:int;
    public var y:int;
    public function Player(obj_x:int, obj_y:int, stage:Object) {
      x = obj_x;
      y = obj_y;
      //sprite = new Sprite();
      //sprite.graphics.beginFill(0xFFFF00);
      //sprite.graphics.drawRect(0, 0, 25, 25);
      //sprite.graphics.endFill();
      //sheet.bitmapData.colorTransform( new Rectangle(0, 0, 32, 32), new ColorTransform(0.1, 0.1, 0.1));
			
      drawSprite(stage);
			//sheet.bitmapData.colorTransform( new Rectangle(0, 0, 32, 32), new ColorTransform(0.5, 0.5, 0.5));
			sprite.drawTile(493);
    }
    
    public function drawSprite(stage:Object){
      sprite = new SpriteSheet(sheet, 8, 8);
      sprite.scaleX = 4;
      sprite.scaleY = 4;
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			stage.addChild(sprite);
    }
  }
}