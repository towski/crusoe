package{
  public class StoneFloor extends Item{
    static public var walkable:Boolean = true;
    
    public function StoneFloor(related_node:Node) {
      super(related_node)
      tile = 206; //209
      walkable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}