package{
  public class Fence extends Item{
    public function Fence(related_node:Node) {
    }
    
    public function draw(x:int, y:int):void{
      sprite = new SpriteSheet(sheet, 32, 32);
			sprite.x = 32 * x;
			sprite.y = 32 * y;
      sprite.drawTile(143);
    }

    override public function requirements_met(stage:Object):Boolean{
      if(stage.wood > 0){
        return true;
      } else {
        return false;
      }
    }
  }
}