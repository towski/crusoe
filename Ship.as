package{
  public class Ship extends Item{
    public function Ship(related_node:Node) {
      super(related_node, true)
      tile = 9;
      sheetClass = piratesSheetClass
      emptyTile = 26
      equipable = true
      takeable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}