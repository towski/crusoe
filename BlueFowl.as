package{
  import flash.utils.*;
  
  public class BlueFowl extends Item{
    public static var isAnimal:Boolean = true
    
    public function BlueFowl(related_node:Node) {
      super(related_node, true)
      tile = 12;
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
    
    override public function move(stage:Object):void{
      var random:int = Math.floor(Math.random() * 100);
      if(random < 1){
        if(stage.world.items[animal.y + 1][animal.x] == null){
          stage.world.items[animal.y + 1][animal.x] = Egg
          stage.world.markers.push(new EggMarker(animal.x, animal.y + 1))
          if (stage.world.onMap(animal.x, animal.y + 1, stage)){
            var node:Node = stage.world.buffer[(animal.y + 1) - stage.world_index_y][animal.x - stage.world_index_x]
            node.addItem(new Egg(node), stage)
          }
        }
      }
    }
  }
}