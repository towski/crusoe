package{
  public class Monkey extends Item{
    public function Monkey(related_node:Node) {
      super(related_node, true)
      tile = 14;
      itemSheet = new piratesSheetClass()
      emptyTile = 24
    } 
  }
}