package{
  public class Tree extends Item{
    
    public function Tree(related_node:Node) {
      super(related_node)
      tile = 73
      delay = 4500
      useable = true
      takeable = false
    }
    
    override public function take(stage:Object, world:World):Item{
      return null
    }
  }
}