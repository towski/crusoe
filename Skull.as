package{
  public class Skull extends Item{
    public function Skull(related_node:Node) {
      super(related_node, true)
      tile = 11;
      itemSheet = new piratesSheetClass()
      emptyTile = 24
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}