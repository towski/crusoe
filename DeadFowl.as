package{
  public class DeadFowl extends Item{
    
    public function DeadFowl(related_node:Node) {
      super(related_node)
      tile = 13;
      sheetClass = piratesSheetClass
      emptyTile = 26
		  useable = true
		  takeable = false
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