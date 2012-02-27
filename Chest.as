package{
  public class Chest extends Item{
    public var items:Array
    
    public function Chest(related_node:Node) {
      super(related_node)
      sheetClass = piratesSheetClass
      var random:int = Math.floor(Math.random() * 2);
      tile = 22
      emptyTile = 26
      takeable = true
      //items = node.store(stage)
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
  }
}