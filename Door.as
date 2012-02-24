package{
  public class Door extends Item{
    static public var walkable:Boolean = true;
    
    public function Door(related_node:Node) {
      super(related_node)
      tile = 208; //209
      walkable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}