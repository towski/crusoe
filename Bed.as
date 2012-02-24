package{
  public class Bed extends Item{
    public function Bed(related_node:Node) {
      super(related_node)
      tile = 135;
      useable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      stage.updateEnergy(100)
      //world.player.addToInventory(this, stage)
      return new Bed(node);
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.replenishEnergy()
      return false
    }
  }
}