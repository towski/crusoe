package{
  public class ForestGround extends Node{
    public var flower:SpriteSheet;
    
    public function ForestGround(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffff);
			sprite = groundSprite;
			groundSprite.drawTile(86);
			
			var random:int = Math.floor(Math.random() * 101);
      if(random < 4){
        flower = new SpriteSheet(sheet, 32, 32);
  			flower.x = 32 * x;
  			flower.y = 32 * y;
  			flower.drawTile(110);
        //stage.addChild(currentSprite);
        //stage.addChild(flower)
      } else if (random < 8){
        flower = new SpriteSheet(sheet, 32, 32);
  			flower.x = 32 * x;
  			flower.y = 32 * y;
  			flower.drawTile(111);
        //stage.addChild(currentSprite);
        //stage.addChild(flower)
      }
    } 
  }
}