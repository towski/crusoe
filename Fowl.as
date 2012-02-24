package{
  import flash.utils.*;
  
  public class Fowl extends Item{
    public function Fowl(related_node:Node) {
      super(related_node, true)
      tile = 13;
      itemSheet = new piratesSheetClass()
      emptyTile = 26
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
        node.addItem(new Meat(node), stage);
      }
      return false
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(Fowl, stage.world_index_x + x, stage.world_index_y + y))
    }
  }
}