package{
  public class Leaf extends Item{
    public function Leaf(related_node:Node) {
      super(related_node)
      tile = 23
      emptyTile = 24
      itemSheet = new piratesSheetClass()
      useable = true
      takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.world.player.clearInventory(stage)
      return true;
    }
  }
}