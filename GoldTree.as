package{
  public class GoldTree extends Item{
    
    public function GoldTree(related_node:Node) {
      super(related_node)
      tile = 74
      delay = 4500
      useable = true
      takeable = false
    }
    
    override public function take(stage:Object, world:World):Item{
      return null
    }
  }
}