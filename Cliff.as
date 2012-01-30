package{
  public class Cliff extends Node{
    public function Cliff(obj_x:int, obj_y:int, stage:Object, world:World) {
      super(obj_x, obj_y, stage, world, 0xffffff);
      takeable = false;
      walkable = false;
      sprite = groundSprite;
  		groundSprite.drawTile(96);
      var random:int = Math.floor(Math.random() * 101);
      if(random < 10){
        sprite = new SpriteSheet(sheet, 32, 32);
  			sprite.x = 32 * x;
  			sprite.y = 32 * y;
  			sprite.drawTile(105);
  			stage.addChild(sprite)
      } else if(random < 20){
        sprite = new SpriteSheet(sheet, 32, 32);
  			sprite.x = 32 * x;
  			sprite.y = 32 * y;
  			sprite.drawTile(89);
  			stage.addChild(sprite)
      }
    }
  }
}