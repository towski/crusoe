package{
  public class Meat extends Item{
    
    public function Meat(related_node:Node) {
      super(related_node)
      tile = 17
      itemSheet = new piratesSheetClass()
      useable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object):void{
      stage.updateEnergy(20);
    }
  }
}