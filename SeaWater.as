package{
  public class SeaWater extends Node{
    public function SeaWater(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffff);
      takeable = false;
      walkable = false;
      sprite = groundSprite;
			var random:int = Math.floor(Math.random() * 101);
      if(random < 50){
  			groundSprite.drawTile(188);
      } else {
  			groundSprite.drawTile(204);
      }
    } 
  }
}