package{
  public class Sand extends Node{
    public function Sand(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 189);
      takeable = false;
      //walkable = true;
      //sprite = groundSprite;
			//var random:int = Math.floor(Math.random() * 101);
      //groundSprite.drawTile(189);
      //darken(stage.shadeFromBase())
    } 
  }
}