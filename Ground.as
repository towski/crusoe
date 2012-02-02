package{  
  public class Ground extends Node{
    public var flower:SpriteSheet;
    
    public function Ground(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 70) {
      super(obj_x, obj_y, stage, world, groundColor);
			//sprite = groundSprite;
			
			var random:int = Math.floor(Math.random() * 101);
      if(random < 4 && world.breakGround){
        flower = new SpriteSheet(sheet, 32, 32);
  			flower.x = 32 * x;
  			flower.y = 32 * y;
  			flower.drawTile(110);
      } else if (random < 8 && world.breakGround){
        flower = new SpriteSheet(sheet, 32, 32);
  			flower.x = 32 * x;
  			flower.y = 32 * y;
  			flower.drawTile(111);
        //stage.addChild(currentSprite);
        //stage.addChild(flower)
      }
    }
    
    override public function after_take(stage:Object, world:World):void{
      super.after_take(stage, world)
    } 
  }
}