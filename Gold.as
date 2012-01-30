package{
  public class Gold extends Item{
    public function Gold() {
      tile = 23;
      useItemSheet = true;
    } 
    
    override public function place(stage:Object, x:int, y:int):void{
      super.place(stage, x, y);
      //stage.bed = this;
    }
  }
}