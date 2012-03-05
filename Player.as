package{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.utils.getQualifiedClassName
  import flash.utils.getDefinitionByName
  import flash.geom.ColorTransform;
  import flash.geom.Rectangle;
  import flash.utils.*;
  
  public class Player{ 
		[Embed(source='char.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		public var sprite:SpriteSheet;
		
		public var inventorySlot:SpriteSheet;
		public var equipmentSlot:SpriteSheet;
		
    public var x:int;
    public var y:int;
    public var tile:int;
    
    public var inventory:Item;
    public var inventoryClass:Object;
    public var equipment:Item;
    public var equipmentClass:Object;
    
    public var hand:String;
    
    public var swordSkill:int = 0
    
    public var inventoryHighlight:Sprite;
    public var stage:Object;
    public function Player(obj_x:int, obj_y:int, myStage:Object) {
      x = obj_x;
      y = obj_y;
			hand = "left"
      stage = myStage
      tile = 493
      drawSprite();
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
    
    public function hit():void {
      sprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(1, 0, 0)); 
      setTimeout(drawSprite, 500)
    }
    
    public function miss():void {
      sprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(0, 1, 0)); 
      setTimeout(drawSprite, 500)
    }
    
    public function drawInventory(stage:Object):void{
      inventorySlot = inventory.getSprite();
			inventorySlot.x = 32 * 16.5;
			inventorySlot.y = 32 * 20.5;
			inventorySlot.drawTile(inventory.tile);
      stage.addChild(inventorySlot)
    }
    
    public function drawEquipment(stage:Object):void{
      equipmentSlot = equipment.getSprite();
			equipmentSlot.x = 32 * 18;
			equipmentSlot.y = 32 * 20.5;
			equipmentSlot.drawTile(equipment.tile);
      stage.addChild(equipmentSlot)
    }
    
    public function useItem(node:Node, stage:Object):void{
      if(hand == "left" && inventory != null){
        inventory.useItem(stage, node == null ? null : node.item)
      } else if(equipment != null) {
        equipment.useItem(stage, node == null ? null : node.item)
      }
    }
    
    public function take(node:Node, stage:Object):void{
      if(!handFull()){
        if(node.item != null){
          node.item.node = null
        }
        node.afterTake(stage, stage.world);
      }
    }
    
    public function handItemName():String{
      if(hand == "left"){
        return flash.utils.getQualifiedClassName(inventory);
      } else {
        return flash.utils.getQualifiedClassName(equipment);
      }
    }
    
    public function place(node:Node, stage:Object):void{
      if(node.item == null){
        if(hand == "left"){
          if(node.isWalkable()){
            node.addItem(new inventoryClass(node), stage);
            clearInventory(stage)
            node.place(stage)
          }
        } else {
          if(node.isWalkable()){
            node.addItem(new equipmentClass(node), stage);
            clearInventory(stage)
            node.place(stage)
          }
        }
      }
    }
    
    public function createInventory():void{
      if(inventoryClass != null){
        inventory = new inventoryClass(null)
      }
      if(equipmentClass != null){
        equipment = new equipmentClass(null)
      }
    }
    
    public function addToInventory(object:Item, stage:Object):void{
      if(hand == "left"){
        inventory = object;
        inventoryClass = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(inventory))
        drawInventory(stage)
        inventorySlot.drawTile(object.tile);
      } else {
        equipment = object;
        equipmentClass = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(equipment))
        drawEquipment(stage)
        equipmentSlot.drawTile(object.tile);
      }
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
      if(hand == 'left'){
        hand = 'right'
      } else {
        hand = 'left'
      }
    }
    
    public function clearInventory(stage:Object):Item{
      if(hand == 'left'){
        var item:Item = inventory;
        inventory = null;
        inventoryClass = null;
        if(inventorySlot != null && item != null){
          stage.removeChild(inventorySlot)
        }
        return item;
      } else {
        var item:Item = equipment;
        equipment = null;
        equipmentClass = null;
        if(equipmentSlot != null && item != null){
          stage.removeChild(equipmentSlot)
        }
        return item;
      }
    }
    
    public function useHand(node:Node, stage:Object):void{
      if(hand == "left"){
        if(hasInventory()){
          useItem(node, stage)
        }
      } else {
        if(hasEquipment()){
          useItem(node, stage)
        }
      }
    }
    
    public function handFull():Boolean{
      if(hand == "left"){
        return hasInventory()
      } else {
        return hasEquipment()
      }      
    }
    
    public function bothHandsFull():Boolean{
      return inventory != null && equipment != null
    }
    
    public function currentHand():Item{
      if(hand == "left"){
        return inventory
      } else {
        return equipment
      }
    }
    
    public function hasInventory():Boolean{
      return inventory != null;
    }
    
    public function hasEquipment():Boolean{
      return equipment != null;
    }
    
    public function drawTile(newTile:int):void{
      sprite.drawTile(newTile)
      tile = newTile
    }
    
    public function drawSprite():void{
      if(sprite != null && stage.contains(sprite)){
        stage.removeChild(sprite)
      }
      sprite = new SpriteSheet(new sheetClass(), 8, 8);
      sprite.scaleX = 4;
      sprite.scaleY = 4;
			sprite.x = 32 * x;
			sprite.y = 32 * y;
			sprite.drawTile(tile);
			stage.addChild(sprite);
    }
  }
}