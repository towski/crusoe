package{
  import flash.utils.*;
  
  public class Fowl extends Item{
    public static var isAnimal:Boolean = true
    
    public function Fowl(related_node:Node) {
      super(related_node, true)
      tile = 13;
      sheetClass = piratesSheetClass
      emptyTile = 26
      health = 2
		  useable = true
		  takeable = false
		  deadAnimalClass = DeadFowl
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(Fowl, stage.world_index_x + x, stage.world_index_y + y, node))
    
    }
  }
}