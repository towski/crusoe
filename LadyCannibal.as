package{
  import flash.utils.*;
  
  public class LadyCannibal extends Item{
    public function LadyCannibal(related_node:Node) {
      super(related_node, true)
      tile = 37;
      sheetClass = piratesSheetClass
      emptyTile = 26
		  useable = true
		  takeable = false
		  attacked = true
		  health = 5
		  attackSkill = 25
		  deadAnimalClass = Skull
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      if(animal != null){
        animal.attacked = true
      }
      stage.updateEnergy(-10);
      removeAnimal(stage)
      rotation = 45
      return false
    }
  }
}