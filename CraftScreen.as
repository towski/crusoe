package{
  import flash.display.Sprite;
  
  public class CraftScreen{
    public var startX:int = 32 * 5
    public var startY:int = 32 * 5
    
    private var sprite:Sprite;
    private var array:Array;
    private var options:Array;
    public var slot:int;
    private var highlight:Sprite;
    public function CraftScreen(stage:Object) {
      sprite = new Sprite()
      array = new Array()
      options = new Array()
      options.push(Log)
      options.push(Wall)
      options.push(Door)
      options.push(Bed)
      options.push(Table)
      options.push(Chest)
      options.push(Barrel)
      options.push(WoodFloor)
      
      sprite.graphics.beginFill(0xEDC393);
      sprite.graphics.drawRect(0, 0, 32 * 13, 32 * 4);
      sprite.graphics.endFill();
      sprite.x = startX
      sprite.y = startY
      stage.addChild(sprite)
      for(var i:int = 0; i < options.length; i++){
        stage.addChild(addToSlot(i, options[i]))
      }
      
      highlight = new Sprite()
      highlight.graphics.beginFill(0xaaaaaa);
      highlight.graphics.drawRect(0, 0, 48, 48);
      highlight.graphics.endFill();
      highlight.alpha = 0.5;
      stage.addChild(highlight)
      highlight.x = startX + 8
      highlight.y = startY + 8
    }
    
    public function getOption():Class{
      return options[slot]
    }
    
    public function highlightSlot(newSlot:int):void{ 
      slot = newSlot
      highlight.x = startX + 48 * newSlot + 8
      highlight.y = startY + 8
    }
    
    private function addToSlot(slot:int, itemClass:Class):SpriteSheet{
      var item:Item = new itemClass(null);
      var sprite:SpriteSheet;
      sprite = item.getSprite();
			sprite.x = 48 * slot + startX + 16;
			sprite.y = startY + 16;
			sprite.scaleX = item.scaleX;
      sprite.scaleY = item.scaleY;
			sprite.rotation = item.rotation;
			sprite.drawTile(item.tile);
			array.push(sprite)
			return sprite;
    }
    
    public function dispose(stage:Object):void{
      for(var i:int = 0; i < array.length; i++){
        array[i].canvasBitmapData.dispose()
        stage.removeChild(array[i])
        array[i] = null
      }
      stage.removeChild(sprite)
      stage.removeChild(highlight)
      sprite = null
    }
  }
}