package{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Rectangle;
  import flash.geom.ColorTransform;
  
  public class Player{ 
		[Embed(source='char.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		public var sprite:SpriteSheet;
		
    [Embed(source='previewenv.png')]
		public var environmentSheetClass:Class;
		public var environmentSheet:Bitmap = new environmentSheetClass();
		public var inventorySlot:SpriteSheet;
		
    public var x:int;
    public var y:int;
    
    public var inventory:Item;
    public function Player(obj_x:int, obj_y:int, stage:Object) {
      x = obj_x;
      y = obj_y;
			
      drawSprite(stage);
    }
    
    public function drawInventory(stage:Object){
      inventorySlot = inventory.getSprite();
			inventorySlot.x = 32 * 18;
			inventorySlot.y = 32 * 20;
			inventorySlot.drawTile(inventory.tile);
      stage.addChild(inventorySlot)
    }
    
    public function addToInventory(object:Item, stage:Object):void{
      inventory = object;
      drawInventory(stage)
      inventorySlot.drawTile(object.tile);
    }
    
    public function clearInventory():Item{
      var item:Item = inventory;
      inventory = null;
      if(inventorySlot != null){
        inventorySlot.drawTile(14);
      }
      return item;
    }
    
    public function hasInventory():Boolean{
      return inventory != null;
    }
    
    public function drawSprite(stage:Object){
      sprite = new SpriteSheet(sheet, 8, 8);
      sprite.scaleX = 4;
      sprite.scaleY = 4;
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			stage.addChild(sprite);
			sprite.drawTile(493);
    }
  }
}