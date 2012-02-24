package{
  public class Wall extends Item{
    public function Wall(related_node:Node) {
      super(related_node)
      tile = 12; //187
      wood = 2
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}