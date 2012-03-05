package{
  import flash.utils.*;
  
  public class SheKid extends Item{
    public static var isAnimal:Boolean = true
    
    public function SheKid(related_node:Node) {
      super(related_node, true)
      tile = 218;
      sheetClass = charSheetClass
      emptyTile = 461
		  scaleX = 3
		  scaleY = 3
		  bits = 8
		  useable = false
		  takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      stage.world.player.addToInventory(this, stage)
      removeAnimal(stage)
      return null;
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(SheKid, stage.world_index_x + node.x, stage.world_index_y + node.y, null))
    }
    
    override public function move(stage:Object):void{
      if(animal.age >= 1000){
        removeAnimal(stage)
        stage.world.animals.push(new Animal(SheGoat, animal.x, animal.y, node))
      }
    }
  }
}