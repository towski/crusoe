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
    public var color:int;
    public var delay:int;
    public var world:World;
    public function Node(obj_x:int, obj_y:int, stage:Object, world:World, my_color:int){ 
      world = world;
      walkable = true;
      x = obj_x;
      y = obj_y;
      delay = 500;
      color = my_color;
      //sprite.graphics.beginFill(color);
      //sprite.graphics.drawRect(0, 0, 25, 25);
      //sprite.graphics.endFill();
      //sprite.x = 25 * x;
      //sprite.y = 25 * y;
      groundSprite = new SpriteSheet(sheet, 32, 32);
			groundSprite.x = 32 * x;
			groundSprite.y = 32 * y;
			groundSprite.drawTile(70);

			stage.addChild(groundSprite);
    }
    
    public function update(local_x:int, local_y:int):void{
      x = local_x;
      y = local_y;
      sprite.x = 32 * x;
      sprite.y = 32 * y;
      groundSprite.x = 32 * x;
			groundSprite.y = 32 * y;
    }
    
    public function requirements_met(stage:Object):Boolean{
      return true;
    }
    
    public function place(stage:Object, world:World):void{
      stage.addChild(sprite)
      //stage.swapChildren(sprite, world.world[y][x].sprite)
      //stage.removeChild(world.world[y][x].sprite)
      world.buffer[y][x] = this;
    }
    
    public function take(stage:Object, world:World, closure:Function):void{
      stage.energy -= 1;
      setTimeout(closure, delay, this)
    }
  }
}