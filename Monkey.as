package{
  import flash.utils.*;
  
  public class Monkey extends Item{
    public function Monkey(related_node:Node) {
      super(related_node, true)
      tile = 215;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  useable = true
		  takeable = false
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
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(Monkey, stage.world_index_x + x, stage.world_index_y + y))
    }
  }
}