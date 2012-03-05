package{
  import flash.utils.*;
  
  public class Monkey extends Item{
    public static var isAnimal:Boolean = true
    
    public function Monkey(related_node:Node) {
      super(related_node, true)
      tile = 215;
      sheetClass = charSheetClass
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  health = 3
		  useable = true
		  takeable = false
		  deadAnimalClass = DeadMonkey
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      if(animal != null){
        animal.attacked = true
      }
      stage.updateEnergy(-10);
      var random:int = Math.floor(Math.random() * 3);
      if(random < 1){
        removeAnimal(stage)
      }
      return false
    }
  }
}