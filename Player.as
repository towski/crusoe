package{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.utils.getQualifiedClassName
  import flash.geom.ColorTransform;
  import flash.geom.Rectangle;
  
  public class Player{ 
		[Embed(source='char.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		public var sprite:SpriteSheet;
		
		public var inventorySlot:SpriteSheet;
		public var equipmentSlot:SpriteSheet;
		
    public var x:int;
    public var y:int;
    
    public var inventory:Item;
    public var equipment:Item;
    public function Player(obj_x:int, obj_y:int, stage:Object) {
      x = obj_x;
      y = obj_y;
			
      drawSprite(stage);
    }
    
    public function darken(shade:Number):void {
      sprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(shade, shade, shade));
    }
    
    public function drawInventory(stage:Object){
      inventorySlot = inventory.getSprite();
			inventorySlot.x = 32 * 18;
			inventorySlot.y = 32 * 20;
			inventorySlot.drawTile(inventory.tile);
      stage.addChild(inventorySlot)
    }
    
    public function useItem(node:Node, stage:Object):void{
      var inventoryName:String = flash.utils.getQualifiedClassName(inventory);
      var itemName:String = null;
      if(node != null){
        itemName = flash.utils.getQualifiedClassName(node.item);
      }
      trace(itemName)
      if (inventoryName == "Sword"){
        if (itemName == "Goat"){
          node.useItem(stage);
        }
      } else if(itemName != "null" && itemName != null) {
        node.item.useItem(stage);
      } else {
        if(inventory != null && inventory.useable){
          inventory.useItem(stage)
        }
        //node.useItem(stage, stage.world);
      }
    }
    
    public function take(node:Node, stage:Object):void{
      if(!hasInventory()){
        node.afterTake(stage, stage.world);
      }
    }
    
    public function place(node:Node, stage:Object):void{
      if(node.item == null){
        node.addItem(inventory, stage);
        clearInventory()
      } else {
        var inventoryName:String = flash.utils.getQualifiedClassName(inventory);
        if (flash.utils.getQualifiedClassName(node.item) == "Barrel"){
          if (inventoryName == "Grapes" || inventoryName == "Mushroom" || inventoryName == "Meat"){
            stage.food += 1
            stage.barrel.push(clearInventory())
            stage.food_text.text = "food:" + stage.food;
          }
        }
        if (flash.utils.getQualifiedClassName(node.item) == "Table"){
          if (flash.utils.getQualifiedClassName(inventory) == "Log"){
            stage.wood += 1
            clearInventory()
            stage.wood_text.text = "wood:" + stage.wood;
          }
        }
      }
    }
    
    public function addToInventory(object:Item, stage:Object):void{
      inventory = object;
      drawInventory(stage)
      inventorySlot.drawTile(object.tile);
    }
    
    public function clearInventory():Item{
      var item:Item = inventory;
      inventory = null;
      if(inventorySlot != null && item != null){
        inventorySlot.drawTile(item.emptyTile);
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