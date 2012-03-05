package{
  public class BabyTree extends Item{
    
    public function BabyTree(related_node:Node) {
      super(related_node)
      tile = 79
      delay = 4500
      useable = true
      takeable = false
    }
    
    override public function take(stage:Object, world:World):Item{
      return null
    }
  }
}