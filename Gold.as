package{
  public class Gold extends Item{
    public function Gold(related_node:Node) {
      super(related_node, true)
      tile = 23;
      itemSheet = new itemSheetClass()
    } 
  }
}