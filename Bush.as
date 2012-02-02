package{
  public class Bush extends Item{
    public function Bush(related_node:Node) {
      super(related_node)
      tile = 78;
      delay = 400;
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      var random:int = Math.floor(Math.random() * 101);
      if(random < 40){
        return new Grapes(node);
      } else {
        return null;
      }
    }
  }
}