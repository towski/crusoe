package{
  import flash.utils.*;
  
  public class SheKid extends Item{
    public function SheKid(related_node:Node) {
      super(related_node, true)
      tile = 218;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 3
		  scaleY = 3
		  bits = 8
		  useable = false
		  takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      stage.world.player.addToInventory(this, stage)
      var index:int = 0;
      for(var i:int; i < stage.world.animals.length; i++){
        if (stage.world.animals[i].y == (stage.world_index_y + node.y) && stage.world.animals[i].x == (stage.world_index_x + node.x)){
          index = i;  
          break;
        }
      }
      stage.world.animals.splice(index, 1)
      node.removeItem(stage)
      return null;
    }
    
    override public function place(stage:Object, x:int, y:int):void{
      stage.world.animals.push(new Animal(SheKid, stage.world_index_x + x, stage.world_index_y + y))
    }
  }
}