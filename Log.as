package{
  import flash.utils.getQualifiedClassName
  
  public class Log extends Item{
    
    public function Log(related_node:Node) {
      super(related_node)
      
      tile = 143
      useable = true
      wood = 1
    }
    
    override public function take(stage:Object, world:World):Item{
      trace('loggy')
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Table"){
        stage.wood += 1
        stage.player.clearInventory(stage)
        stage.wood_text.text = "wood:" + stage.wood;
      }
      return false
    }
  }
}