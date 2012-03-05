package{
  public class Mushroom extends Food{
    public function Mushroom(related_node:Node) {
      super(related_node)
      tile = 108
      useable = true
      takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      return super.useItem(stage, used)
    }
  }
}