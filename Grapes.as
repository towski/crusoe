package{
  public class Grapes extends Item{
    
    public function Grapes(related_node:Node) {
      super(related_node)
      tile = 127
      useable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object):void{
      stage.energy += 20;
    }
  }
}