package{
  public class Table extends Item{
    public function Table(related_node:Node) {
      super(related_node)
      tile = 140;
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}