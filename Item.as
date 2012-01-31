package{
  import flash.display.Bitmap;
  
  public class Item{
    [Embed(source='previewenv.png')]
  	public var sheetClass:Class;
  	public var sheet:Bitmap = new sheetClass();
    
    [Embed(source='items.png')]
  	public var itemSheetClass:Class;
  	public var itemSheet:Bitmap = new itemSheetClass();
    
    public var sprite:SpriteSheet;
    public var spriteSheet:SpriteSheet;
    public var useItemSheet:Boolean;
    
    public var delay:int;
    public var tile:int;
    public function Item() {
      useItemSheet = false;
      tile = 14
    }
    
    public function getSprite():SpriteSheet{
      if(useItemSheet){
        return new SpriteSheet(itemSheet, 32, 32);
      } else {
        return new SpriteSheet(sheet, 32, 32);
      }
    }

    public function requirements_met(stage:Object):Boolean{
      return true;
    }
    
    public function place(stage:Object, x:int, y:int):void{
      stage.energy -= 1;
    }
    
    public function take(stage:Object, world:World):Item{
      return new Item();
    }
  }
}