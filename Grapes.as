package{
  public class Grapes extends Item{
    
    public function Grapes() {
      tile = 127
    }
    
    override public function take(stage:Object, world:World):Item{
      stage.food += 1;
      return null;
    }
  }
}