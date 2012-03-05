package{
  import flash.utils.getQualifiedClassName
  
  public class Sword extends Item{
    public function Sword(related_node:Node) {
      super(related_node, true)
      tile = 9;
      sheetClass = piratesSheetClass
      emptyTile = 26
      equipable = true
      takeable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Chest"){
        stage.chest.push(flash.utils.getQualifiedClassName(stage.player.clearInventory(stage)))
        stage.addAchievement(Achievements.STORE_AN_ITEM)
      } else if(used != null && used.animal != null){
        if(stage.updateEnergy(-10)){
          var random:int = Math.floor(Math.random() * 100)
          if(random < 50 + stage.player.swordSkill){
            if(used.animal.health - 1 <= 0){
              used.removeAnimal(stage)
              used.node.addItem(new used.deadAnimalClass(used.node), stage);
              if(usedName == "Goat" || usedName == "SheGoat"){
                stage.goatsKilled += 1
                stage.addAchievement(Achievements.KILL_1_GOAT)
                if(stage.goatsKilled >= 2){
                  stage.addAchievement(Achievements.KILL_10_GOATS)
                }
                if(stage.goatsKilled >= 3){
                  stage.addAchievement(Achievements.KILL_25_GOATS)
                }
              } else if(usedName == "Fowl" || usedName == "BlueFowl") {
                stage.fowlsKilled += 1
                stage.addAchievement(Achievements.KILL_1_FOWL)
                if(stage.fowlsKilled >= 2){
                  stage.addAchievement(Achievements.KILL_10_FOWLS)
                }
                if(stage.fowlsKilled >= 3){
                  stage.addAchievement(Achievements.KILL_25_FOWLS)
                }
              } else if(usedName == "Cannibal" || usedName == "Cannibal") {
                stage.cannibalsKilled += 1
                stage.addAchievement(Achievements.KILL_1_CANNIBAL)
                if(stage.cannibalsKilled >= 2){
                  stage.addAchievement(Achievements.KILL_5_CANNIBALS)
                }
                if(stage.cannibalsKilled >= 3){
                  stage.addAchievement(Achievements.KILL_15_CANNIBALS)
                }
              }
            } else {
              used.animal.health -= 1
            }
            used.hit()
          } else {
            used.miss()
          }
          used.animal.attacked = true
          stage.player.swordSkill += 1
        }
      } else if(usedName == "DeadGoat" || usedName == "DeadFowl" || usedName == "DeadMonkey"){
        used.node.removeItem(stage)
        used.node.addItem(new Meat(used.node), stage);
      }
      return true;
    }
  }
}