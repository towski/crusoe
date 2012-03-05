package{
  import flash.utils.*;
  
  public class Pirate extends Item{
    public function Pirate(related_node:Node) {
      super(related_node, true)
      tile = 2;
      sheetClass = piratesSheetClass
      emptyTile = 26
		  useable = true
		  takeable = false
		  attacked = true
		  health = 6
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