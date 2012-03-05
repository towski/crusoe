package{
  public class ForestTree extends Item{
    
    public function ForestTree(related_node:Node) {
      super(related_node)
      tile = 77
      delay = 4500
      useable = true
      takeable = false
    }
    
    override public function take(stage:Object, world:World):Item{
      return null
    }
  }
}