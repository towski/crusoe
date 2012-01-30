package{
  public class Barrel extends Item{
    public function Barrel() {
      tile = 0;
      useItemSheet = true;
    } 
    
    override public function place(stage:Object, x:int, y:int):void{
      super.place(stage, x, y);
      //stage.bed = this;
    }
  }
}