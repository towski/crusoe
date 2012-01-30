package{
  public class DarkCliff extends Node{
    public function DarkCliff(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffff);
      takeable = false;
      walkable = false;
      sprite = groundSprite;
      sprite.drawTile(100);
    }
  }
}