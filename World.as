package{
  import flash.utils.*;
  import flash.events.Event;
  import flash.net.SharedObject
	
  public class World {
    public var world:Array;
    public var buffer:Array;
    public var animals:Array;
    public var items:Array;
    public var terrain:Array;
    public var markers:Array
    public var shipMarkers:Array
    public var player:Player;
    public var breakGround:Boolean;
    public var derail:Boolean = false;
    public var map:Array;
    public var cumulative_x:int;
    public var cumulative_y:int;
    public var interval:Number;
    public var finishInterval:int;
    public var stage:Object;
    public var saveData:Array
    
    public function World(myStage:Object) {
      breakGround = true;
      world = new Array()
      buffer = new Array();
      items = new Array()
      animals = new Array();
      cumulative_x = 0;
      cumulative_y = 0;
      markers = new Array()
      shipMarkers = new Array()
      stage = myStage
    }

    public function save(island:Object, sharedObject:SharedObject):void{
      saveData = new Array()
      for(var y:int=0; y < items.length; y++){ 
        saveData.push(new Array());
        for(var x:int = 0; x < items[y].length; x++){
          if(items[y][x] != null){
            saveData[y].push(flash.utils.getQualifiedClassName(items[y][x]))
          } else {
            saveData[y].push(null)
          }
        }
      }
      sharedObject.setProperty('saveData', saveData)
      sharedObject.setProperty('world_index_x'  , island.world_index_x)
      sharedObject.setProperty('world_index_y'  , island.world_index_y)
      sharedObject.setProperty('moving'         , island.moving)
      sharedObject.setProperty('mode'           , island.mode)
      sharedObject.setProperty('daytime'        , island.daytime)
      sharedObject.setProperty('interval'       , island.interval)
      sharedObject.setProperty('energy'         , island.energy)
      sharedObject.setProperty('maxEnergy'      , island.maxEnergy)
      sharedObject.setProperty('maxHealth'      , island.maxHealth)
      sharedObject.setProperty('maxHunger'      , island.maxHunger)
      sharedObject.setProperty('hunger'         , island.hunger)
      sharedObject.setProperty('health'         , island.health)
      sharedObject.setProperty('food'           , island.food)
      sharedObject.setProperty('wood'           , island.wood)
      sharedObject.setProperty('day'            , island.day)
      sharedObject.setProperty('barrel'         , island.barrel)
      sharedObject.setProperty('chest'          , island.chest)
      sharedObject.setProperty('achievements'   , stage.achievements.achievements)
      sharedObject.setProperty('choppedTrees'   , stage.choppedTrees)
      sharedObject.setProperty('goatsKilled'    , stage.goatsKilled)
      sharedObject.setProperty('fowlsKilled'    , stage.fowlsKilled)
      sharedObject.setProperty('cannibalsKilled', stage.cannibalsKilled)
      
      if(player.inventoryClass != null){
        sharedObject.setProperty('playerInventory'           , flash.utils.getQualifiedClassName(player.inventoryClass))
      }
      if(player.equipmentClass != null){
        sharedObject.setProperty('playerEquipment'           , flash.utils.getQualifiedClassName(player.equipmentClass))      
      }
    }
    
    public function load(sharedObject:SharedObject):void{
      items = new Array()
      for(var y:int=0; y < sharedObject.data.saveData.length; y++){ 
        items.push(new Array())
        for(var x:int = 0; x < sharedObject.data.saveData[y].length; x++){
          if(sharedObject.data.saveData[y][x] != null){
            items[y].push(flash.utils.getDefinitionByName(sharedObject.data.saveData[y][x]))
          } else {
            items[y].push(null)
          }
          if(items[y][x] != null && items[y][x].isAnimal){
            animals.push(new Animal(items[y][x], x, y, null))          
          }
        }
      }
    }
    
    public function setup(stage:Object, sharedObject:SharedObject):void {
      var mapObject:Map = new Map();
      map = mapObject.toString().split(/\n/)
      var klass:Class;
      var char:String;
      var random:int;
      for(var y:int=0; y < map.length; y++){ 
        world.push(new Array());
        for(var x:int = 0; x < map[0].length; x++){
          char = map[y].charAt(x);
          if(char == 'u'){
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
            klass = ForestGround
          } else if (char == 'T'){
            klass = Mud
          } else if (char == 'C'){
            klass = Mud
          } else if (char == 'a'){
            klass = Mud
          } else if (char == 't'){
            klass = Ground
          } else if (char == 'o'){
            klass = Sand
          } else if (char == 'd'){
            klass = Sand
          } else if (char == 'D'){
            klass = Mud
          } else if (char == 'B'){
            klass = Sand
          } else if (char == 'r'){
            klass = Sand
          } else if (char == 'X'){
            klass = Ground
          } else {
            klass = Ground
          }
          world[y].push(klass);
        }
      }
      if(sharedObject != null && sharedObject.data.saveData != null){
        load(sharedObject)
      } else {
        newItems()
      }
      map = null
      
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
    
    public function newItems():void{
      var char:String;
      var random:int;
      for(var y:int=0; y < map.length; y++){ 
        items.push(new Array());
        for(var x:int = 0; x < map[0].length; x++){
          char = map[y].charAt(x);
          if (char == 'f'){
            random = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 32){
              items[y][x] = ForestTree
            } else if(random < 90){
              items[y][x] = Bush
            }
          } else if (char == 'T'){
            items[y][x] = Sword
          } else if (char == 'a'){
            items[y][x] = Axe
          } else if (char == 't'){
            items[y][x] = Table
          } else if (char == 'o'){
            items[y][x] = Gold
          } else if (char == 'd'){
            items[y][x] = Skull
          } else if (char == 'D'){
            items[y][x] = Bed
          } else if (char == 'B'){
            items[y][x] = Barrel
          } else if (char == 'r'){
            items[y][x] = Rum
          } else if (char == 'X'){
            stage.world_index_y = y
            stage.world_index_x = x
          } else if (char == 'G'){
            items[y][x] = Goat
            animals.push(new Animal(Goat, x, y, null))
          } else if (char == 'C'){
            items[y][x] = Cannibal
            animals.push(new Animal(Cannibal, x, y, null))
          } else if (char == 'S'){
            items[y][x] = SheGoat
            animals.push(new Animal(SheGoat, x, y, null))
          } else if (char == 'M'){
            items[y][x] = Monkey
            animals.push(new Animal(Monkey, x, y, null))
          } else if (char == 'I'){
            shipMarkers.push(new ShipMarker(x, y))
          } else if (char == 'F'){
            random = Math.floor(Math.random() * 2);
            if(random < 1){
              items[y][x] = Fowl
              animals.push(new Animal(Fowl, x, y, null))
            } else {
              items[y][x] = BlueFowl
              animals.push(new Animal(BlueFowl, x, y, null))
            }
          } else if (char == 's'){
            items[y][x] = Kid
            animals.push(new Animal(Kid, x, y, null))          
          } else if (char == ' ') {
            random = Math.floor(Math.random() * 201);
            if(random < 1){
              items[y][x] = Mushroom
            } else if(random < 3){
              items[y][x] = Rock
            } else if(random < 4) {
              world[y][x] = RedFlowerGround
            } else if(random < 5) {
              world[y][x] = WhiteFlowerGround
            } else if(random < 25){
              items[y][x] = Tree
            } else if(random < 32){
              items[y][x] = BabyTree
              markers.push(new BabyTreeMarker(x, y))
            } else if(random < 34){
              items[y][x] = GoldTree
            } else if(random < 90){
              items[y][x] = Bush
            }
          }
        }
      }
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
      for(var i:int = 0; i < markers.length; i++){
        markers[i].grow(stage)
      }
      
      for(var i:int = 0; i < animals.length; i++){
        var animal:Animal = animals[i];
        var backtrace:String;
        random = Math.floor(Math.random() * animal.moveChances());
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
                } else {
                  player.miss()
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
        player.darken(stage.shadeFromBase())
      }
      finishInterval = 0
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
    
    public function movePerson(x:int, y:int, setMoving:Boolean, stage:Object, follow:Boolean, target:Object = null, nearTarget:Object = null, closure:Function = null, closureParam:Object = null):void{
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
            if (y < player.y){
              player.drawTile(495);
              moveCameraUp(stage, false);
              moved = true
            } else if (y > player.y) {
              player.drawTile(493);
              moveCameraDown(stage, false);
              moved = true
            }
            if (x > player.x){
              player.drawTile(492);
              moveCameraRight(stage, false);
              moved = true
            } else if (x < player.x){
              player.drawTile(494);
              moveCameraLeft(stage, false);
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
			if (!setMoving){
        if(finishInterval != 0){
          clearInterval(finishInterval)
        }
        if (closure != null){
          setTimeout(closure, buffer[target.y][target.x].delay(), closureParam)
        }
        cumulative_x = 0;
        cumulative_y = 0;
        if (target != null){
          finishInterval = setTimeout(finishMoving, buffer[target.y][target.x].delay(), stage)
        } else {
          finishInterval = setTimeout(finishMoving, 250, stage)
        }
        buffer[player.y][player.x].clearHighlight()
        buffer[y][x].clearHighlight()
        if(target != null){
          buffer[target.y][target.x].clearHighlight()
        }
        if(nearTarget != null){
          buffer[nearTarget.y][nearTarget.x].clearHighlight()
        }
      }
      stage.showCurrentAchievement()
			if(!setMoving){
        derail = false
      }
    }
  }
}