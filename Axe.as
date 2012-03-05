package{
  import flash.utils.getQualifiedClassName
  
  public class Axe extends Item{
    public function Axe(related_node:Node) {
      super(related_node, true)
      tile = 25;
      sheetClass = piratesSheetClass
      emptyTile = 26
      equipable = true
      takeable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      stage.addAchievement(Achievements.PICKUP_AXE)
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Tree" || usedName == "GoldTree" || usedName == "ForestTree"){
        if(stage.updateEnergy(-10)){
          stage.choppedTrees += 1
          stage.addAchievement(Achievements.CHOP_1_TREE)
          if(stage.choppedTrees >= 2){
            stage.addAchievement(Achievements.CHOP_10_TREES)
          } 
          if(stage.choppedTrees >= 3){
            stage.addAchievement(Achievements.CHOP_25_TREES)
          } 
          if(stage.choppedTrees >= 4){
            stage.addAchievement(Achievements.CHOP_100_TREES)
          }          
          used.node.removeItem(stage)
          used.node.addItem(new Log(used.node), stage)
          return true
        }
      }
      return false
    }
  }
}