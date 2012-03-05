package{
  import flash.utils.*;
  
  public class Goat extends Item{
    public static var isAnimal:Boolean = true
    public function Goat(related_node:Node) {
      super(related_node, true)
      tile = 217;
      sheetClass = charSheetClass
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  health = 5
		  useable = true
		  takeable = false
		  deadAnimalClass = DeadGoat
    }
  }
}