package{
  public class Meat extends Item{
    
    public function Meat(related_node:Node) {
      super(related_node)
      tile = 23
      emptyTile = 24
      itemSheet = new piratesSheetClass()
      useable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object):Boolean{
      stage.updateEnergy(50);
      return true;
    }
  }
}