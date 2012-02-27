package{
  import flash.utils.*;
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
	
  public class World {
    public var world:Array;
    public var buffer:Array;
    public var animals:Array;
    public var items:Array;
    public var terrain:Array;
    public var player:Player;
    public var breakGround:Boolean;
    public var derail:Boolean = false;
    public var map:Array;
    public var cumulative_x:int;
    public var cumulative_y:int;
    public var interval:Number;
    public var stage:Object;
    public function World(myStage:Object) {
      breakGround = true;
      world = new Array()
      buffer = new Array();
      items = new Array()
      animals = new Array();
      cumulative_x = 0;
      cumulative_y = 0;
      stage = myStage
    }
    
    public function setup(stage:Object):void {
      var mapObject:Map = new Map();
      map = mapObject.toString().split(/\n/);
      
      var klass:Class;
      var char:String;
      for(var y:int=0; y < map.length; y++){ 
        world.push(new Array());
        items.push(new Array());
        for(var x:int = 0; x < map[0].length; x++){
          char = map[y].charAt(x);
          if(char == 'u'){
            var random:int = Math.floor(Math.random() * 101);
            klass = Water;
          } else if (char == '.'){
            klass = Sand;
          } else if (char == ':'){
            klass = Desert;
          } else if (char == 'V'){
            klass = Cliff;
          } else if (char == 'v'){
            klass = DarkCliff;
          } else if (char == '_'){
            klass = Mud;
          } else if (char == 'f'){
            klass = ForestGround;
            random = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 32){
              items[y][x] = Tree
            } else if(random < 90){
              items[y][x] = Bush
            }
          } else if (char == 'T'){
            klass = Mud;
            items[y][x] = Sword
          } else if (char == 'a'){
            klass = Mud;
            items[y][x] = Axe
          } else if (char == 't'){
            klass = Ground;
            items[y][x] = Table
          } else if (char == 'o'){
            klass = Sand;
            items[y][x] = Gold
          } else if (char == 'd'){
            klass = Sand;
            items[y][x] = Skull
          } else if (char == 'D'){
            klass = Mud;
            items[y][x] = Bed
          } else if (char == 'B'){
            klass = Sand;
            items[y][x] = Barrel
          } else if (char == 'r'){
            klass = Sand;
            items[y][x] = Rum
          } else if (char == 'X'){
            klass = Ground;
            stage.world_index_y = y
            stage.world_index_x = x
          } else if (char == 'G'){
            items[y][x] = Goat
            animals.push(new Animal(Goat, x, y, null))
          } else if (char == 'C'){
            klass = Mud;
            items[y][x] = Cannibal
            animals.push(new Animal(Cannibal, x, y, null))
          } else if (char == 'S'){
            items[y][x] = SheGoat
            animals.push(new Animal(SheGoat, x, y, null))
          } else if (char == 'M'){
            items[y][x] = Monkey
            animals.push(new Animal(Monkey, x, y, null))
          } else if (char == 'F'){
            items[y][x] = Fowl
            animals.push(new Animal(Fowl, x, y, null))
          } else if (char == 's'){
            items[y][x] = SheKid
            animals.push(new Animal(SheKid, x, y, null))          
          } else {
            random = Math.floor(Math.random() * 201);
            klass = Ground
            random = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 4) {
              klass = RedFlowerGround
            } else if(random < 5) {
              klass = WhiteFlowerGround
            } else if(random < 32){
              items[y][x] = Tree
            } else if(random < 34){
              items[y][x] = GoldTree
            } else if(random < 90){
              items[y][x] = Bush
            }
          }
          world[y].push(klass);
        }
      }
      
      items[stage.world_index_y + 10][stage.world_index_x + 10] = null
      
      for(var i:int = 0; i < 20 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 20; j++){ 
          y = i + stage.world_index_y
          x = j + stage.world_index_x
          var object:Object = new world[y][x](j, i, stage, this)
          buffer[i][j] = object
        }
      }
      
      player = new Player(10, 10, stage);
      
      interval = setInterval(move, 1000, items, stage)
    }
    
    public function playerNeighbor(animal:Animal):Boolean {
      var distance:Number = Math.sqrt((Math.pow(animal.y - (stage.world_index_y + 10), 2) + Math.pow(animal.x - (stage.world_index_x + 10), 2)))
      return distance <= Math.sqrt(2)
    }
    
    public function lineOfSight(animal:Animal):Boolean {
      if(animal.y == (stage.world_index_y + 10)){
        
      } else if (animal.x == (stage.world_index_x + 10)){
      }
      return false
    }
    
    public function move(items:Array, stage:Object):void{
      for(var i:int = 0; i < animals.length; i++){
        var animal:Animal = animals[i];
        var backtrace:String;
        var random:int = Math.floor(Math.random() * animal.moveChances());
        if(random < 1){
          var newY:int
          var newX:int
          try {
            var oldNode:Node = null
            if(onMap(animal.x, animal.y, stage)){
              oldNode = buffer[animal.y - stage.world_index_y][animal.x - stage.world_index_x]
            }
            if(animal.attacked && playerNeighbor(animal)){
              newY = stage.world_index_y + player.y
              newX = stage.world_index_x + player.x
            } else {
              var results:Array = globalNeighbors(animal.x, animal.y, items)
              random = Math.floor(Math.random() * results.length);

              newY = results[random][0][0]
              newX = results[random][0][1]
            }
            if(onMap(newX, newY, stage)){
              var node:Node = buffer[newY - stage.world_index_y][newX - stage.world_index_x]
              var playerIntersect:Boolean = (player.x + stage.world_index_x) == newX && (player.y + stage.world_index_y) == newY
              if(node.isWalkable() && !playerIntersect){
                items[animal.y][animal.x] = null
                animal.x = newX;
                animal.y = newY;
                items[animal.y][animal.x] = animal.animalClass
                if(oldNode != null){
                  oldNode.removeItem(stage)
                }
                node.addItem(animal.animal, stage)
              } else if(animal.attacked && playerIntersect) {
                animal.animal.node = oldNode
                var random:int = Math.floor(Math.random() * 100)
                if(random < 50 + animal.animal.attackSkill){
                  player.hit()
                  stage.updateHealth(-0.5)
                }
                if(player.handItemName() == "Sword"){
                  player.useItem(animal.animal.node, stage)
                }
              }
            } else {
              if(items[newY][newX] == null && world[newY][newX] != Cliff && world[newY][newX] != Water){
                items[animal.y][animal.x] = null
                animal.x = newX
                animal.y = newY
                items[newY][newX] = animal.animalClass
                if(oldNode != null){
                  oldNode.removeItem(stage)
                }
              } 
            }
          } catch(e:Error){
            //trace(e)
            trace(animal.animal)
            trace(backtrace)
            throw(e)
          }
          animal.move(stage)
        }
      }
    }
    
    public function onMap(x:int, y:int, stage:Object):Boolean{
      return x >= stage.world_index_x && x <= (stage.world_index_x + 19) && y >= stage.world_index_y && y <= (stage.world_index_y + 19)
    }
    
    public function globalNeighbors(x:int, y:int, items:Array):Array{
      var results:Array = new Array();
      if(items[y - 1][x - 1] == null){
        results.push(new Array([y - 1, x - 1]))  
      }
      if(items[y - 1][x] == null){
        results.push(new Array([y - 1, x]))
      }
      if(items[y - 1][x + 1] == null){
        results.push(new Array([y - 1, x + 1]))  
      }
      if(items[y][x - 1] == null){
        results.push(new Array([y, x - 1]))
      }
      if(items[y][x + 1] == null){
        results.push(new Array([y, x + 1])) 
      }
      if(items[y + 1][x - 1] == null){
        results.push(new Array([y + 1, x - 1]))
      }
      if(items[y + 1][x] == null){
        results.push(new Array([y + 1, x]))
      }
      if(items[y + 1][x + 1] == null){
        results.push(new Array([y + 1, x + 1]))
      }
      return results;
    }
    
    public function neighbors(obj:Object):Array{
      var x:int = obj.x;
      var y:int = obj.y;
      var results:Array = new Array();
      if(y > 0){
        results.push(buffer[y - 1][x]);
        if(x > 0){
          results.push(buffer[y - 1][x - 1]);
        }
        if(x < 19){
          results.push(buffer[y - 1][x + 1]);
        }
      }
      if(x > 0){
        results.push(buffer[y][x - 1]);
      }
      if(x < 19){
        results.push(buffer[y][x + 1]);
      }
      if(y < 19){
        results.push(buffer[y + 1][x]);
        if(x > 0){
          results.push(buffer[y + 1][x - 1]);
        }
        if(x < 19){
          results.push(buffer[y + 1][x + 1]);
        } 
      }
      return results;
    }
    
    public function closestNeighbor(obj:Object):Node{
      var results:Array = new Array();
      results = neighbors(obj)
      var shortestDistance:Number = 10000;
      var distance:Number;
      var target:Node;
      for(var i:int = 0; i < results.length; i++){
        distance = Math.sqrt((Math.pow(results[i].y - player.y, 2) + Math.pow(results[i].x - player.x, 2)))
        if(results[i].isWalkable() && distance < shortestDistance){
          shortestDistance = distance
          target = results[i];
        }
      }
      return target;
    }
    
    public function finishMoving(stage:Object):void{
      if(!stage.moving){
        player.sprite.drawTile(493);
        cumulative_x = 0;
        cumulative_y = 0;
        player.darken(stage.shadeFromBase())
      }
    }
    
    public function darken(shade:Number):void{
      for(var y:int = 0; y < 20; y++){
        for(var x:int = 0; x < 20; x++){
          buffer[y][x].darken(shade)
        }
      }
    }
    
    public function moveCameraDown(stage:Object, move:Boolean = true):void{
      stage.world_index_y += 1;
       for(var x:int = 0; x < 20; x++){
         var object:Node = buffer[0][x];
         object.groundSprite.canvasBitmapData.dispose();
         stage.removeChild(object.groundSprite);
         if(object.sprite != null && object.sprite != object.groundSprite){
           object.sprite.canvasBitmapData.dispose();
           stage.removeChild(object.sprite);
           object.sprite = null
         }
         if(object.flower != null){
           object.flower.canvasBitmapData.dispose();
           stage.removeChild(object.flower);
           object.flower = null
         }
         object.groundSprite = null
       }
       buffer.splice(0,1);
       buffer.push(new Array());
       for(x = 0; x < 20; x++){
         buffer[19].push(new world[stage.world_index_y + 19][stage.world_index_x + x](x, 19, stage, this));
       }
       for(x = 0; x < 20; x++){
         for(var y:int = 0; y < 20; y++){
           buffer[y][x].update(x,y);
         }
       }
       if(move){
        player.y -= 1;
        player.sprite.y -= 32;
      }
    }
    
    public function moveCameraUp(stage:Object, move:Boolean = true):void{
      stage.world_index_y -= 1;
      for(var x:int = 0; x < 20; x++){
        var object:Node = buffer[19][x];
        object.groundSprite.canvasBitmapData.dispose();
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          object.sprite.canvasBitmapData.dispose()
          stage.removeChild(object.sprite)
          object.sprite = null
        }
        if(object.flower != null){
          object.flower.canvasBitmapData.dispose();
          stage.removeChild(object.flower);
          object.flower = null
        }
        object.groundSprite = null
      }
      buffer.splice(19,1);
      buffer.unshift(new Array());
      var node:Node;
      var item:Item;
      for(x = 0; x < 20; x++){
        node = new world[stage.world_index_y][x + stage.world_index_x](x, 0, stage, this)
        buffer[0].push(node)
        //item = items[stage.world_index_y][stage.world_index_x + x]
        //if (item != null){
        //  node.addItem(item, stage)
        //}
      }
      for(var y:int = 0; y < 20; y++){
        for(x = 0; x < 20; x++){
          buffer[y][x].update(x,y);
        }
      }
      if(move){
         player.y += 1;
         player.sprite.y += 32; 
       }
    }
    
    public function moveCameraLeft(stage:Object, move:Boolean = true):void{
      stage.world_index_x -= 1;
      for(var y:int = 0; y < 20; y++){
        var object:Node = buffer[y][19];
        object.groundSprite.canvasBitmapData.dispose();
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          object.sprite.canvasBitmapData.dispose();
          stage.removeChild(object.sprite);
          object.sprite = null
        }
        if(object.flower != null){
          object.flower.canvasBitmapData.dispose();
          stage.removeChild(object.flower);
          object.flower = null
        }
        object.groundSprite = null
        buffer[y].pop();
      }
      for(y = 0; y < 20; y++){
        buffer[y].unshift(new world[stage.world_index_y + y][stage.world_index_x](0, y, stage, this));
      }
      for(var x:int = 0; x < 20; x++){
        for(y = 0; y < 20; y++){
          buffer[y][x].update(x,y);
        }
      }
      if(move){
        player.x += 1;
        player.sprite.x += 32;
      }
    }
    
    public function moveCameraRight(stage:Object, move:Boolean = true):void{
      stage.world_index_x += 1;
      for(var y:int = 0; y < 20; y++){
        var object:Node = buffer[y][0];
        object.groundSprite.canvasBitmapData.dispose();
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          object.sprite.canvasBitmapData.dispose();
          stage.removeChild(object.sprite);
          object.sprite = null
        }
        if(object.flower != null){
          object.flower.canvasBitmapData.dispose();
          stage.removeChild(object.flower);
          object.flower = null
        }
        object.groundSprite = null
        buffer[y].shift();
      }
      for(y = 0; y < 20; y++){
        buffer[y].push(new world[stage.world_index_y + y][stage.world_index_x + 19](19, y, stage, this));
      }
      for(var x:int = 0; x < 20; x++){
        for(y = 0; y < 20; y++){
          buffer[y][x].update(x,y);
        }
      }
      if(move){
        player.x -= 1;
        player.sprite.x -= 32;
      }
    }
    
    public function clearLocalItem(x:int, y:int, stage:Object):void{
      items[stage.world_index_y + y][stage.world_index_x + x] = null
    }
    
    public function localItem(x:int, y:int, stage:Object):Object{
      return items[stage.world_index_y + y + cumulative_y][stage.world_index_x + x + cumulative_x]
    }
    
    public function movePerson(x:int, y:int, setMoving:Boolean, stage:Object, follow:Boolean = true):void{
      if (!setMoving){
        setTimeout(finishMoving, 500, stage);
      }
      if((localItem(x,y, stage) == null || localItem(x,y, stage).walkable) && !derail){
        if(follow){
          if (x + cumulative_x > player.x){
            player.drawTile(492);
          } else if (x + cumulative_x < player.x){
            player.drawTile(494);
          } else if (y + cumulative_y < player.y){
            player.drawTile(495);
          } else {
            player.drawTile(493);
          }
          player.darken(stage.shadeFromBase())
          if ((y + cumulative_y) < player.y){
            cumulative_y += 1
            moveCameraUp(stage, false);
          } else if ((y + cumulative_y) > player.y){
            cumulative_y -= 1
            moveCameraDown(stage, false);
          }
          if ((x + cumulative_x) < player.x){
            cumulative_x += 1
            moveCameraLeft(stage, false);
          } else if ((x + cumulative_x) > player.x){
            cumulative_x -= 1
            moveCameraRight(stage, false);
          }
          stage.moving = setMoving;
          stage.addChild(player.sprite);
        } else if(!stage.moving){
          var node:Node = buffer[y][x]
          if(node.isWalkable()){
            var moved:Boolean = false
            if (x > player.x){
              player.drawTile(492);
              moveCameraRight(stage, false);
              moved = true
            } else if (x < player.x){
              player.drawTile(494);
              moveCameraLeft(stage, false);
              moved = true
            } 
            if (y < player.y){
              player.drawTile(495);
              moveCameraUp(stage, false);
              moved = true
            } else if (y > player.y) {
              player.drawTile(493);
              moveCameraDown(stage, false);
              moved = true
            }
            if(moved){
              player.darken(stage.shadeFromBase())
            }
            
            stage.addChild(player.sprite);
          }
          //player.x = x;
          //player.y = y;
          //player.sprite.x = 32 * x;
          //player.sprite.y = 32 * y; 
        }
      } else if(follow) {
        derail = true
        stage.moving = false
			}
			if(!setMoving){
        derail = false
      }
    }
  }
}