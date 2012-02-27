package{
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
          stage.world.player.addToInventory(stage.barrel.pop(), stage)
        }
        return new Barrel(node)
      }
    }
  }
}