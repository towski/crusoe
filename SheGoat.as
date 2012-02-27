package{
  import flash.utils.*;
  
  public class SheGoat extends Item{
    public function SheGoat(related_node:Node) {
      super(related_node, true)
      tile = 218;
      sheetClass = charSheetClass
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  useable = true
		  takeable = false
		  deadAnimalClass = DeadSheGoat
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      if(animal != null){
        animal.attacked = true
      }
      stage.updateEnergy(-10);
      var random:int = Math.floor(Math.random() * 3);
      if(random < 1){
        removeAnimal(stage)
        node.addItem(new DeadGoat(node), stage);
      }
      return false
    }
    
    override public function move(stage:Object):void{
      var random:int = Math.floor(Math.random() * 600);
      if(random < 1){
        stage.world.animals.push(new Animal(SheKid, animal.x, animal.y, node))
      } else if(random < 2){
        stage.world.animals.push(new Animal(Kid, animal.x, animal.y, node))
      }
    }
  }
}