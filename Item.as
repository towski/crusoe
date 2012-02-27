package{
  import flash.display.Bitmap;
  import flash.utils.getQualifiedClassName
  
  public class Item{
    static public var walkable:Boolean = false;
    
    [Embed(source='previewenv.png')]
  	public var environmentSheetClass:Class;
    
    [Embed(source='items.png')]
  	public var itemSheetClass:Class;
  	
  	[Embed(source='pirates.png')]
  	public var piratesSheetClass:Class;
  	
  	[Embed(source='char.png')]
  	public var charSheetClass:Class;
  	
  	public var itemSheet:Bitmap;
  	
  	public var sheetClass:Class;
  	public var deadAnimalClass:Class;
    
    public var sprite:SpriteSheet;
    public var spriteSheet:SpriteSheet;
    public var useItemSheet:Boolean;
    
    public var delay:int;
    public var tile:int;
    public var emptyTile:int;
    public var useable:Boolean;
    public var takeable:Boolean;
    public var equipable:Boolean;
    public var walkable:Boolean;
    public var attacked:Boolean;
    
    public var node:Node;
    public var bits:int;
    public var wood:int;
    public var energyCost:int;
    public var seconds:int;
    public var health:int;
    
    public var animal:Animal;
    public var scaleX:int;
    public var scaleY:int;
    public var rotation:int = 0;
    public var attackSkill = 0;
    
    public function Item(related_node:Node, customSheet:Boolean = false) {
      node = related_node
      if(!customSheet){
        sheetClass = environmentSheetClass
      }
      emptyTile = 14;
      tile = 14
      bits = 32
      useable = false
      takeable = true
      equipable = false
      walkable = false
      wood = 0
      seconds = 0
      health = 1
      energyCost = 0
		  scaleX = 1
		  scaleY = 1
    }
    
    public function getSprite():SpriteSheet{
      return new SpriteSheet(new sheetClass(), bits, bits);
    }

    public function requirements_met(stage:Object):Boolean{
      return true;
    }
    
    public function removeAnimal(stage:Object):void{
      var index:int = 0;
      for(var i:int; i < stage.world.animals.length; i++){
        if (stage.world.animals[i].y == (animal.y) && stage.world.animals[i].x == (animal.x)){
          index = i;  
          break;
        }
      }
      stage.world.animals.splice(index, 1)
      if(node != null){
        node.removeItem(stage)
      }
    }
    
    public function place(stage:Object, x:int, y:int):void{
      //stage.updateEnergy(-1);
    }
    
    public function take(stage:Object, world:World):Item{
      return null;
    }
    
    public function move(stage:Object):void{
    }
    
    public function hit():void{
      if(node != null){
        node.hit()
      }
    }
    
    public function useItem(stage:Object, used:Item):Boolean{
      return true
    }
  }
}