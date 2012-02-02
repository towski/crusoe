package{
  public class Bed extends Item{
    public function Bed(related_node:Node) {
      super(related_node)
      
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