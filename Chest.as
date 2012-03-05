package{
  import flash.utils.getDefinitionByName
  1
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
      if(stage.chest.length == 0){
        world.player.addToInventory(this, stage)
        return null
      } else {
        if(stage.chest.length > 0 && !stage.world.player.handFull()){
          var klass:Object = flash.utils.getDefinitionByName(stage.chest.pop())
          stage.world.player.addToInventory(new klass(null), stage)
        }
        return new Chest(node)
      }
    }
  }
}