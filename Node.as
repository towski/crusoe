package{
  import flash.utils.*;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  
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
			stage.addChild(groundSprite);
    }
    
    public function drawItem(stage:Object):void{
      if(sprite == null){
        if(item != null){
			    sprite = item.getSprite();
			    sprite.x = 32 * x;
			    sprite.y = 32 * y;
			    sprite.drawTile(item.tile);
			    stage.addChild(sprite);
		    }
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
      //stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = object;
      object.place(stage, x, y)
      walkable = !walkable
      item = object
      drawItem(stage)
      sprite.drawTile(item.tile)
    }
    
    public function place(stage:Object, world:World):void{
      stage.addChild(sprite)
      //stage.swapChildren(sprite, world.world[y][x].sprite)
      //stage.removeChild(world.world[y][x].sprite)
      world.buffer[y][x] = this;
    }
    
    public function take(stage:Object, world:World, closure:Function):void{
      //stage.moving = true
      if(takeable){
        stage.energy -= 1;
        setTimeout(closure, delay, this)
      }
    }
    
    public function isWalkable():Boolean{
      return walkable == true && item == null
    }
    
    public function after_take(stage:Object, world:World):void{
      item = item.take(stage, world)
      if(item != null){
        walkable = false;
        sprite.drawTile(item.tile)
      } else {
        walkable = true
        sprite.drawTile(14)
      }
    }
    
    public function setColor():void{
    }
  }
}