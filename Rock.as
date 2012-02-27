package{
  public class Rock extends Item{
    public function Rock(related_node:Node) {
      super(related_node)
      tile = 105
      delay = 1000
    }
    
    override public function take(stage:Object, world:World):Item{
      if(stage.updateEnergy(-10)){
        world.player.addToInventory(this, stage)
      }
      return null;
    }
  }
}