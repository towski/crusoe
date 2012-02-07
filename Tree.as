package{
  public class Tree extends Item{
    
    public function Tree(related_node:Node) {
      super(related_node)
      tile = 73
      delay = 10000
    }
    
    override public function take(stage:Object, world:World):Item{
//      super.take(stage, world, closure);
      stage.moving = false;
      stage.updateEnergy(-4);
      return new Log(node)
    }
  }
}