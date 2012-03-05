package{
  import flash.utils.getDefinitionByName
  public class Barrel extends Item{
    public function Barrel(related_node:Node) {
      super(related_node, true)
      tile = 0;
      sheetClass = itemSheetClass
      useable = true
      takeable = true
      wood = 2
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      if(stage.barrel.length == 0){
        world.player.addToInventory(this, stage)
        return null
      } else {
        if(stage.barrel.length > 0 && !stage.world.player.handFull()){
          var klass:Object = flash.utils.getDefinitionByName(stage.barrel.pop())
          stage.world.player.addToInventory(new klass(null), stage)
        }
        return new Barrel(node)
      }
    }
  }
}