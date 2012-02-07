package{
  public class Mushroom extends Item{
    public function Mushroom(related_node:Node) {
      super(related_node)
      tile = 108
      delay = 10000
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object):Boolean{
      stage.energy += 20;
      return true;
    }
  }
}