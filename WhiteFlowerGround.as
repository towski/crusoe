package{  
  public class WhiteFlowerGround extends Ground{
    public function WhiteFlowerGround(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 70) {
      super(obj_x, obj_y, stage, world, groundColor);
      flower = new SpriteSheet(sheet, 32, 32);
		  flower.x = 32 * x;
		  flower.y = 32 * y;
		  flower.drawTile(110);
		  stage.addChild(flower)
		  darkenFlower(stage.shadeFromBase())
	  }
  }
}