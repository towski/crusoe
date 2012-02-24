package{
  public class Table extends Item{
    public function Table(related_node:Node) {
      super(related_node)
      tile = 140;
      useable = true
      wood = 2
    } 
    
    override public function take(stage:Object, world:World):Item{
      //super.take(stage, world);
      if(stage.wood > 0){
        if(stage.craftScreen == null && !stage.player.handFull()){
          stage.craftScreen = new CraftScreen(stage)
          stage.moving = true
        } else if(stage.craftScreen != null) {
          stage.craftScreen.dispose(this)
          stage.craftScreen = null
          stage.moving = false
        }
        return new Table(node)
      } else {
        world.player.addToInventory(this, stage)
        return null
      }
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      if(stage.craftScreen == null && !stage.player.handFull()){
        stage.craftScreen = new CraftScreen(stage)
        stage.moving = true
      } else if(stage.craftScreen != null) {
        stage.craftScreen.dispose(this)
        stage.craftScreen = null
        stage.moving = false
      }
      return false
    }
  }
}