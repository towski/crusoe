package{
  import flash.utils.*;
  
  public class Goat extends Item{
    public function Goat(related_node:Node) {
      super(related_node, true)
      tile = 217;
      itemSheet = new charSheetClass()
      emptyTile = 461
		  scaleX = 4
		  scaleY = 4
		  bits = 8
		  useable = true
    }
    
    override public function useItem(stage:Object):Boolean{
      var index:int = 0;
      for(var i:int; i < stage.world.animals.length; i++){
        if (stage.world.animals[i].y == (stage.world_index_y + node.y) && stage.world.animals[i].x == (stage.world_index_x + node.x)){
          index = i;  
          break;
        }
      }
      stage.world.animals.splice(index, 1)
      node.removeItem(stage)
      node.addItem(new Meat(node), stage);
      return false
    }
  }
}