package{
  public class Bush extends Item{
    public function Bush() {
      tile = 78;
      delay = 400;
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      return null;
    }
  }
}