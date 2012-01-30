package{
  public class Tree extends Item{
    
    public function Tree() {
      tile = 73
      delay = 10000
    }
    
    override public function take(stage:Object, world:World):Item{
//      super.take(stage, world, closure);
      stage.moving = false;
      stage.energy -= 4;
      stage.wood += 5;
      return new Log()
    }
  }
}