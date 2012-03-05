package{
  import flash.utils.*;
  
  public class Captain extends Item{
    public function Captain(related_node:Node) {
      super(related_node, true)
      tile = 6;
      sheetClass = piratesSheetClass
      emptyTile = 26
		  useable = true
		  takeable = false
		  attacked = true
		  health = 10
		  attackSkill = 25
		  deadAnimalClass = Skull
    }
  }
}