package{
  public class Gold extends Item{
    public function Gold(related_node:Node) {
      super(related_node, true)
      tile = 23;
      sheetClass = itemSheetClass
      takeable = true
      //emptyTile = 1
    } 
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
  }
}