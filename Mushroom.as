package{
  public class Mushroom extends Item{
    public function Mushroom(related_node:Node) {
      super(related_node)
      tile = 108
      useable = true
      takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.updateHunger(0.5)
      if(node == null){
        stage.world.player.clearInventory(stage)
      } else {
        node.removeItem(stage)
      }
      return true;
    }
  }
}