package{
  import flash.utils.*;
  
  public class Kid extends Item{
    public static var isAnimal:Boolean = true
    
    public function Kid(related_node:Node) {
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
      removeAnimal(stage)
      stage.world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      var newAnimal:Animal = new Animal(Kid, stage.world_index_x + node.x, stage.world_index_y + node.y, node)
      stage.world.animals.push(newAnimal)
    }
    
    override public function move(stage:Object):void{
      if(animal.age >= 1000){
        removeAnimal(stage)
        stage.world.animals.push(new Animal(Goat, animal.x, animal.y, node))
      }
    }
  }
}