package{
  import flash.utils.*;
  
  public class EggMarker extends ItemMarker {
    public function EggMarker(myX:int, myY:int) {
      super(myX, myY, Egg)
    }
    
    override public function grow(stage:Object):void{
      super.grow(stage)
    }
  }
}