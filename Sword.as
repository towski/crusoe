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
      if(used != null){
        var usedName:String = flash.utils.getQualifiedClassName(used)
        if(used.animal != null){
          if(stage.updateEnergy(-10)){
            var random:int = Math.floor(Math.random() * 100)
            if(random < 50 + stage.player.swordSkill){
              if(used.animal.health - 1 <= 0){
                used.removeAnimal(stage)
                used.node.addItem(new used.deadAnimalClass(used.node), stage);
              } else {
                used.animal.health -= 1
              }
              used.hit()
            }
            used.animal.attacked = true
            stage.player.swordSkill += 1
          }
        }
        if(usedName == "DeadGoat" || usedName == "DeadFowl" || usedName == "DeadMonkey"){
          used.node.removeItem(stage)
          used.node.addItem(new Meat(used.node), stage);
        }
      }
      return true;
    }
  }
}