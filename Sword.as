package{
  public class Sword extends Item{
    public function Sword(related_node:Node) {
      super(related_node, true)
      tile = 9;
      itemSheet = new piratesSheetClass()
      emptyTile = 26
      equipable = true
      takeable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}