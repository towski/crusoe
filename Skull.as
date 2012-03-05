package{
  public class Skull extends Item{
    public function Skull(related_node:Node) {
      super(related_node, true)
      tile = 11;
      sheetClass = piratesSheetClass
      emptyTile = 26
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}