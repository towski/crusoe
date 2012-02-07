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
    public var player:Object;
    public var breakGround:Boolean;
    public var follow:Boolean;
    public var map:Array;
    public var cumulative_x:int;
    public var cumulative_y:int;
    public var interval:Number;
    public function World(stage:Object) {
      breakGround = true;
      world = new Array()
      buffer = new Array();
      items = new Array()
      animals = new Array();
      follow = true;
      cumulative_x = 0;
      cumulative_y = 0;
    }
    
    public function setup(stage:Object) {
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
          } else if (char == 'V'){
            klass = Cliff;
          } else if (char == 'v'){
            klass = DarkCliff;
          } else if (char == '_'){
            klass = Mud;
          } else if (char == 'f'){
            klass = ForestGround;
            var random:int = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 32){
              items[y][x] = Tree
            } else if(random < 90){
              items[y][x] = Bush
            }
          } else {
            klass = Ground;
            var random:int = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 32){
              items[y][x] = Tree
            } else if(random < 90){
              items[y][x] = Bush
            }
          }
          world[y].push(klass);
        }
      }
      
      items[stage.world_index_y + 9][stage.world_index_x + 9] = Barrel
      items[stage.world_index_y + 9][stage.world_index_x + 10] = Rum
      items[stage.world_index_y + 8][stage.world_index_x + 9] = Sword
      items[stage.world_index_y + 8][stage.world_index_x + 11] = Table
      items[stage.world_index_y + 8][stage.world_index_x + 10] = Skull
      items[stage.world_index_y + 4][stage.world_index_x + 4] = Goat
      items[stage.world_index_y + 10][stage.world_index_x + 10] = null
      
      
      for(var i:int = 0; i < 20 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 20; j++){ 
          var y:int = i + stage.world_index_y;
          var x:int = j + stage.world_index_x;
          var object:Object = new world[y][x](j, i, stage, this);
          buffer[i][j] = object;
        }
      }
      animals.push(new Animal(Goat, stage.world_index_x + 4, stage.world_index_y + 4))
      //animals.push(new Animal(Goat, stage.world_index_x - 10, stage.world_index_y - 4))
      //animals.push(new Animal(Goat, stage.world_index_x - 20, stage.world_index_y + 5))
      //animals.push(new Animal(Goat, stage.world_index_x + 6, stage.world_index_y + 6))
      
      player = new Player(10, 10, stage);
      
      interval = setInterval(move, 1000, items, stage)
    }
    
    public function move(items:Array, stage:Object):void{
      for(var i:int = 0; i < animals.length; i++){
        var animal:Animal = animals[i];
        var random:int = Math.floor(Math.random() * 3);
        if(random < 1){
          var results:Array = globalNeighbors(animal.x, animal.y, items)
          random = Math.floor(Math.random() * results.length);
          var oldNode:Node
          if(onMap(animal.x, animal.y, stage)){
            oldNode = buffer[animal.y - stage.world_index_y][animal.x - stage.world_index_x]
          }
          var newY:int = results[random][0][0]
          var newX:int = results[random][0][1]
          if(onMap(newX, newY, stage)){
            var node:Node = buffer[newY - stage.world_index_y][newX - stage.world_index_x]
            if(node.walkable && (player.x + stage.world_index_x) != newX && (player.y + stage.world_index_y) != newY){
              items[animal.y][animal.x] = null
              animal.x = newX;
              animal.y = newY;
              items[animal.y][animal.x] = animal.animalClass
              if(oldNode != null){
                oldNode.removeItem(stage)
              }
              node.addItem(new animal.animalClass(node), stage)
            }
          } else {
            if(items[newY][newX] == null){
              items[animal.y][animal.x] = null
              animal.x = newX;
              animal.y = newY;
              items[newY][newX] = animal.animalClass
              if(oldNode != null){
                oldNode.removeItem(stage)
              }
            } 
          }
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
      var shortestDistance:int = 10000;
      var distance:int;
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
    
    public function finishMoving(stage):void{
      if(!stage.moving){
        player.sprite.drawTile(493);
        cumulative_x = 0;
        cumulative_y = 0;
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
         stage.removeChild(object.groundSprite);
         if(object.sprite != null && object.sprite != object.groundSprite){
           stage.removeChild(object.sprite);
         }
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
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          stage.removeChild(object.sprite);
        }
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
        for(var x:int = 0; x < 20; x++){
          buffer[y][x].update(x,y);
        }
      }
      if(move){
         player.y += 1;
         player.sprite.y += 32; 
       }
    }
    
    public function moveCameraUpNew(stage:Object, move:Boolean = true):void{
      stage.world_index_y -= 1;
      
      for(var y:int = 0; y < 11; y++){
        for(var x:int = 0; x < 20; x++){
          buffer[y][x].sprite.drawTile(items[stage.world_index_y + y][stage.world_index_x + x])
          buffer[y][x].groundSprite.drawTile(terrain[stage.world_index_y + y][stage.world_index_x + x])
          //buffer[y][x].groundSprite.drawTile(terrain[stage.world_index_y + y][stage.world_index_x + x])
          //buffer[y][x].sprite.drawTile(terrain[x][y])
        }
      }
      
      for(var y:int = 11; y < 20; y++){
        for(var x:int = 0; x < 20; x++){
          buffer[y][x].groundSprite.drawTile(terrain[stage.world_index_y + y][stage.world_index_x + x])
          buffer[y][x].sprite.drawTile(items[stage.world_index_y + y][stage.world_index_x + x])
          //buffer[y][x].sprite.drawTile(items[stage.world_index_y + y][stage.world_index_x + x])
          //buffer[y][x].sprite.drawTile(terrain[x][y])
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
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          stage.removeChild(object.sprite);
        }
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
        stage.removeChild(object.groundSprite);
        if(object.sprite != null && object.sprite != object.groundSprite){
          stage.removeChild(object.sprite);
        }
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
    
    public function movePerson(x:int, y:int, graphics:Object, setMoving:Boolean, stage:Object):void{
      if (!setMoving){
        setTimeout(finishMoving, 500, stage);
      }
      if(follow){
        if (x + cumulative_x > player.x){
          player.sprite.drawTile(492);
        } else if (x + cumulative_x < player.x){
          player.sprite.drawTile(494);
        } else if (y + cumulative_y < player.y){
          player.sprite.drawTile(495);
        } else {
          player.sprite.drawTile(493);
        }
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
      } else {
        if (x > player.x){
          player.sprite.drawTile(492);
        } else if (x < player.x){
          player.sprite.drawTile(494);
        } else if (y < player.y){
          player.sprite.drawTile(495);
        } else {
          player.sprite.drawTile(493);
        }
        player.x = x;
        player.y = y;
        player.sprite.x = 32 * x;
        player.sprite.y = 32 * y; 
      }
      stage.moving = setMoving;
      stage.addChild(player.sprite);
			
    }
  }
}