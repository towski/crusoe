package{
  public class DeadGoat extends Item{
    
    public function DeadGoat(related_node:Node) {
      super(related_node)
      tile = 217;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  useable = true
		  rotation = 45
    }
    
    override public function take(stage:Object, world:World):Item{
      //world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      node.removeItem(stage)
      node.addItem(new Meat(node), stage);
      return false;
    }
  }
}