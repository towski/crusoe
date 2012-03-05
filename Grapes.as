package{
  public class Grapes extends Food{
    
    public function Grapes(related_node:Node) {
      super(related_node)
      tile = 127
      useable = true
      takeable = true
      energy = 0.5
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