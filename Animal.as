package{
  import flash.display.Bitmap;
  public class Animal{
    public var y:int;
    public var x:int;
    public var animalClass:Class;
    public function Animal(localAnimalClass:Class, world_x:int, world_y:int){
      animalClass = localAnimalClass;
      x = world_x;
      y = world_y;
    }
  }
}