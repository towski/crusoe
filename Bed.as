package{
  public class Bed extends Item{
    public function Bed() {
      tile = 135;
    } 
    
    override public function place(stage:Object, x:int, y:int):void{
      super.place(stage, x, y);
      stage.bed_x = x;
      stage.bed_y = y;
      //stage.bed = this;
    }
  }
}