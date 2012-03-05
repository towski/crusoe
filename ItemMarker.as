package{
  import flash.utils.*;
  
  public class ItemMarker {
    public var itemClass:Class
    public var x:int
    public var y:int
    public var age:int
    public var started:int
    public var present:Boolean
    public function ItemMarker(myX:int, myY:int, klass:Class) {
      x = myX
      y = myY
      itemClass = klass
      present = false
    }
    
    public function grow(stage:Object):void{
      age += 1
    }
  }
}