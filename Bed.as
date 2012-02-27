package{
  public class Bed extends Item{
    public function Bed(related_node:Node) {
      super(related_node)
      tile = 135;
      useable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      stage.replenishEnergy()
      stage.darken()
      //world.player.addToInventory(this, stage)
      return new Bed(node);
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.replenishEnergy()
      stage.darken()
      return false
    }
  }
}