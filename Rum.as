package{
  public class Rum extends Item{
    public function Rum(related_node:Node) {
      super(related_node, true)
      tile = 7;
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