package{
  public class Rum extends Item{
    public function Rum(related_node:Node) {
      super(related_node, true)
      tile = 7;
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