package{
  import flash.utils.*;
  
  public class SheGoat extends Item{
    public function SheGoat(related_node:Node) {
      super(related_node, true)
      tile = 218;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  useable = true
		  takeable = false
    }
    
    override public function useItem(stage:Object):Boolean{
      if(animal != null){
        animal.attacked = true
      }
      stage.updateEnergy(-10);
      var random:int = Math.floor(Math.random() * 3);
      if(random < 1){
        var index:int = 0;
        for(var i:int; i < stage.world.animals.length; i++){
          if (stage.world.animals[i].y == (stage.world_index_y + node.y) && stage.world.animals[i].x == (stage.world_index_x + node.x)){
            index = i;  
            break;
          }
        }
        stage.world.animals.splice(index, 1)
        node.removeItem(stage)
        node.addItem(new DeadGoat(node), stage);
      }
      return false
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(SheGoat, stage.world_index_x + x, stage.world_index_y + y))
    }
  }
}