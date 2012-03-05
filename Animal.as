package{
  import flash.display.Bitmap;
  public class Animal{
    public var y:int;
    public var x:int;
    public var attacked:Boolean = false;
    public var health:int = 3;
    public var animal:Item;
    public var age:int;

    public var animalClass:Class;
    public function Animal(localAnimalClass:Class, world_x:int, world_y:int, node:Node){
      animalClass = localAnimalClass;
      x = world_x;
      y = world_y;
      animal = newAnimal(node)
      if(node != null){
        node.item = animal
      }
    }
    
    public function newAnimal(node:Node):Item{
      var newAnimal:Item = new animalClass(node)
      newAnimal.animal = this
      attacked = newAnimal.attacked
      health = newAnimal.health
      return newAnimal;
    }
    
    public function moveChances():int{
      if(attacked){
        return 1;
      } else {
        return 3;
      }
    }
    
    public function move(stage:Object):void{
      age += 1
      if(animal != null){
        animal.move(stage)
      }
    }
  }
}