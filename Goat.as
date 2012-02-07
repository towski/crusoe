package{
  import flash.utils.*;
  
  public class Goat extends Item{
    public function Goat(related_node:Node) {
      super(related_node, true)
      tile = 217;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      return new Meat(node);
    }
  }
}