package{
  public class Log extends Item{
    
    public function Log(related_node:Node) {
      super(related_node)
      
      tile = 143
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}