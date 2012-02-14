package{
  import flash.display.Bitmap;
  public class Animal{
    public var y:int;
    public var x:int;
    public var attacked:Boolean = false;

    public var animalClass:Class;
    public function Animal(localAnimalClass:Class, world_x:int, world_y:int){
      animalClass = localAnimalClass;
      x = world_x;
      y = world_y;
    }
    
    public function newAnimal(node:Node):Item{
      var animal:Item = new animalClass(node)
      animal.animal = this
      return animal;
    }
    
    public function moveChances():int{
      if(attacked){
        return 1;
      } else {
        return 3;
      }
    }
  }
}