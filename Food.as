package{
  import flash.utils.getQualifiedClassName
  
  public class Food extends Item{
    
    public function Food(related_node:Node) {
      super(related_node)
      useable = true
      takeable = true
      energy = 1.0
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Barrel"){
        stage.food += 1
        stage.barrel.push( flash.utils.getQualifiedClassName(stage.player.clearInventory(stage)))
        stage.food_text.text = "food:" + stage.food;
      } else {
        stage.updateHunger(energy);
        stage.world.player.clearInventory(stage)
      }
      return true;
    }
  }
}