package{  
  public class Ground extends Node{
    
    public function Ground(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 70) {
      super(obj_x, obj_y, stage, world, groundColor);
			//sprite = groundSprite;
			
  			//flower.drawTile(111);
        //stage.addChild(currentSprite);
        //stage.addChild(flower)
    }
    
    override public function afterTake(stage:Object, world:World):void{
      super.afterTake(stage, world)
    } 
  }
}