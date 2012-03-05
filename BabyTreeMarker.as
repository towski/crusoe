package{
  import flash.utils.*;
  
  public class BabyTreeMarker extends ItemMarker {
    public function BabyTreeMarker(myX:int, myY:int) {
      super(myX, myY, BabyTree)
    }
    
    override public function grow(stage:Object):void{
      super.grow(stage)
    }
  }
}