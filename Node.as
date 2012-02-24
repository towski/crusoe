package{
  import flash.utils.*;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Rectangle;
  import flash.geom.ColorTransform;
  import flash.utils.getQualifiedClassName
  
  import flash.events.*;
  
  public class Node 
  {
    public var sprite:SpriteSheet;
		public var groundSprite:SpriteSheet;
     
    [Embed(source='previewenv.png')]
		public var sheetClass:Class;
		public var sheet:Bitmap = new sheetClass();
		
    public var parent:Object;
    public var child:Object;
    public var x:int;
    public var y:int;
    public var F:int;
    public var G:int;
    public var H:int;
    public var walkable:Boolean;
    public var takeable:Boolean;
    public var groundTile:int;
    public var itemTile:int;
    
    public var delay:int;
    
    public var item:Item;
    public var world:World;
    public function Node(obj_x:int, obj_y:int, stage:Object, world:World, my_color:int = 70){ 
      world = world;
      walkable = true;
      takeable = true;
      x = obj_x;
      y = obj_y;
      delay = 500;
      groundTile = my_color;
      groundSprite = new SpriteSheet(sheet, 32, 32);
			groundSprite.x = 32 * x;
			groundSprite.y = 32 * y;
			groundSprite.drawTile(groundTile);
			darken(stage.shadeFromBase())
			stage.addChild(groundSprite);
			var itemClass:Class = world.items[stage.world_index_y + obj_y][stage.world_index_x + obj_x]
			if(itemClass != null){
			  item = new itemClass(this)
		  }
			//drawItem(stage)
			addItem(item, stage)
    }
    
    public function darken(shade:Number):void {
      groundSprite.canvasBitmapData.colorTransform(new Rectangle(0, 0, 32, 32), new ColorTransform(shade, shade, shade));
      //trace(groundSprite.canvasBitmapData.getPixel(0,0))
	    darkenItem(shade);
    }
    
    public function darkenItem(shade:Number):void {
      if(sprite != null){
	      sprite.canvasBitmapData.colorTransform( new Rectangle(0, 0, 32, 32), new ColorTransform(shade, shade, shade));
      }
    }
    
    public function drawItem(stage:Object):void{
      if(item != null){
        if(sprite != null && stage.contains(sprite)){
          stage.removeChild(sprite)
        }
        sprite = item.getSprite();
			  sprite.x = 32 * x;
			  sprite.y = 32 * y;
			  sprite.scaleX = item.scaleX;
        sprite.scaleY = item.scaleY;
			  sprite.rotation = item.rotation;
			  sprite.drawTile(item.tile);
			  darkenItem(stage.shadeFromBase())
			  stage.addChild(sprite);
		  }
    }
    
    public function update(local_x:int, local_y:int):void{
      x = local_x;
      y = local_y;
      if(sprite != null){
        sprite.x = 32 * x;
        sprite.y = 32 * y;
      }
      groundSprite.x = 32 * x;
			groundSprite.y = 32 * y;
    }
    
    public function requirements_met(stage:Object):Boolean{
      return true;
    }
    
    public function addItem(object:Item, stage:Object):void{
      //object.place(stage, x, y)
      if(object != null){
        stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(object));
        item = object
        drawItem(stage)
      } else {
        stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = null
      }
    }
    
    public function place(stage:Object):void{
      if(item != null){
        item.place(stage, x, y)
      }
      //stage.swapChildren(sprite, world.world[y][x].sprite)
      //stage.removeChild(world.world[y][x].sprite)
      //world.buffer[y][x] = this;
    }
    
    public function forceUseItem(stage:Object):void{
      if(item.useItem(stage, item)){
        stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = null
        sprite.drawTile(item.emptyTile)
        item = null
      }
    }
    
    public function useItem(stage:Object):void{
      if(item != null && item.useable){
        forceUseItem(stage)
      }
    }
    
    public function removeItem(stage:Object):void{
      if(item != null){
        stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = null
        sprite.drawTile(item.emptyTile)
        item = null
      }
    }
    
    public function isWalkable():Boolean{
      return walkable && (item == null || item.walkable)
    }
    
    public function afterTake(stage:Object, world:World):void{
      var emptyTile:int = item.emptyTile;
      item = item.take(stage, world)
      if(item != null){
        sprite.drawTile(item.tile)
      } else {
        world.clearLocalItem(x, y, stage)
        sprite.drawTile(emptyTile)
      }
    }
    
    public function setColor():void{
    }
  }
}