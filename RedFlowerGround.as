package{  
  public class RedFlowerGround extends Ground{
    public function RedFlowerGround(obj_x:int, obj_y:int, stage:Object, world:World, groundColor:int = 70) {
      super(obj_x, obj_y, stage, world, groundColor);
      flower = new SpriteSheet(sheet, 32, 32);
		  flower.x = 32 * x;
		  flower.y = 32 * y;
		  flower.drawTile(111);
		  stage.addChild(flower)
		  darkenFlower(stage.shadeFromBase())
	  }
  }
}