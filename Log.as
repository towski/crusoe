package{
  public class Log extends Item{
    
    public function Log() {
      tile = 143
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}