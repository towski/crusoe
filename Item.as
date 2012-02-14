package{
  import flash.display.Bitmap;
  
  public class Item{
    [Embed(source='previewenv.png')]
  	public var sheetClass:Class;
    
    [Embed(source='items.png')]
  	public var itemSheetClass:Class;
  	
  	[Embed(source='pirates.png')]
  	public var piratesSheetClass:Class;
  	
  	[Embed(source='char.png')]
  	public var charSheetClass:Class;
  	
  	public var itemSheet:Bitmap;
    
    public var sprite:SpriteSheet;
    public var spriteSheet:SpriteSheet;
    public var useItemSheet:Boolean;
    
    public var delay:int;
    public var tile:int;
    public var emptyTile:int;
    public var useable:Boolean;
    public var takeable:Boolean;
    public var equipable:Boolean;
    
    public var node:Node;
    public var bits:int;
    
    public var animal:Animal;
    public var scaleX:int;
    public var scaleY:int;
    public var rotation:int = 0;
    
    public function Item(related_node:Node, customSheet:Boolean = false) {
      node = related_node
      if(!customSheet){
        itemSheet = new sheetClass()
      }
      emptyTile = 14;
      tile = 14
      bits = 32
      useable = false
      takeable = true
      equipable = false
      
		  scaleX = 1
		  scaleY = 1
    }
    
    public function getSprite():SpriteSheet{
      return new SpriteSheet(itemSheet, bits, bits);
    }

    public function requirements_met(stage:Object):Boolean{
      return true;
    }
    
    public function place(stage:Object, x:int, y:int):void{
      //stage.updateEnergy(-1);
    }
    
    public function take(stage:Object, world:World):Item{
      return null;
    }
    
    public function useItem(stage:Object):Boolean{
      return true
    }
  }
}