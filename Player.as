package{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.utils.getQualifiedClassName
  import flash.utils.getDefinitionByName
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
    public var inventoryClass:Object;
    public var equipment:Item;
    
    public var inventoryHighlight:Sprite;
    public function Player(obj_x:int, obj_y:int, stage:Object) {
      x = obj_x;
      y = obj_y;
			
      drawSprite(stage);
      inventoryHighlight = new Sprite()
      inventoryHighlight.graphics.beginFill(0xaaaaaa);
      inventoryHighlight.graphics.drawRect(0, 0, 64, 64);
      inventoryHighlight.graphics.endFill();
      inventoryHighlight.x = 32 * 16;
      inventoryHighlight.y = 32 * 20;
      inventoryHighlight.alpha = 0.5;
      stage.addChild(inventoryHighlight)
    }
    
    public function darken(shade:Number):void {
      sprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(shade, shade, shade));
    }
    
    public function drawInventory(stage:Object){
      inventorySlot = inventory.getSprite();
			inventorySlot.x = 32 * 16.5;
			inventorySlot.y = 32 * 20.5;
			inventorySlot.drawTile(inventory.tile);
      stage.addChild(inventorySlot)
    }
    
    public function drawEquipment(stage:Object){
      equipmentSlot = equipment.getSprite();
			equipmentSlot.x = 32 * 18;
			equipmentSlot.y = 32 * 20.5;
			equipmentSlot.drawTile(equipment.tile);
      stage.addChild(equipmentSlot)
    }
    
    public function useItem(node:Node, stage:Object):void{
      var inventoryName:String = flash.utils.getQualifiedClassName(inventory);
      var equipmentName:String = flash.utils.getQualifiedClassName(equipment);
      
      var itemName:String = null;
      if(node != null){
        itemName = flash.utils.getQualifiedClassName(node.item);
      }
      if (equipmentName == "Sword"){
        if (itemName == "Goat"){
          node.forceUseItem(stage);
        }
      } 
      if(itemName != "null" && itemName != null) {
        if(node.item.useable){
          node.item.useItem(stage);
        } else if(node.item.equipable) {
          addToEquipment(node.item, stage)
          node.removeItem(stage)
        }
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
        if(node.item != null){
          node.item.node = null
        }
      }
    }
    
    public function place(node:Node, stage:Object):void{
      if(node.item == null){
        node.addItem(new inventoryClass(node), stage);
        node.place(stage)
        clearInventory(stage)
      } else {
        var inventoryName:String = flash.utils.getQualifiedClassName(inventory);
        if (flash.utils.getQualifiedClassName(node.item) == "Barrel"){
          if (inventoryName == "Grapes" || inventoryName == "Mushroom" || inventoryName == "Meat"){
            stage.food += 1
            stage.barrel.push(clearInventory(stage))
            stage.food_text.text = "food:" + stage.food;
          }
        }
        if (flash.utils.getQualifiedClassName(node.item) == "Table"){
          if (flash.utils.getQualifiedClassName(inventory) == "Log"){
            stage.wood += 1
            clearInventory(stage)
            stage.wood_text.text = "wood:" + stage.wood;
          }
        }
      }
    }
    
    public function addToInventory(object:Item, stage:Object):void{
      inventory = object;
      inventoryClass = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(inventory))
      drawInventory(stage)
      inventorySlot.drawTile(object.tile);
    }
    
    public function addToEquipment(object:Item, stage:Object):void{
      equipment = object;
      drawEquipment(stage)
      equipmentSlot.drawTile(object.tile);
    }
    
    public function switchInventory():void{
      if(inventoryHighlight.x == 32 * 16){
        inventoryHighlight.x = 32 * 18;
      } else {
        inventoryHighlight.x = 32 * 16;
      }
    }
    
    public function clearInventory(stage:Object):Item{
      var item:Item = inventory;
      inventory = null;
      inventoryClass = null;
      if(inventorySlot != null && item != null){
        stage.removeChild(inventorySlot)
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