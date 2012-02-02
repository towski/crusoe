package{
  public class Barrel extends Item{
    public function Barrel(related_node:Node) {
      super(related_node, true)
      tile = 0;
      itemSheet = new itemSheetClass()
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}