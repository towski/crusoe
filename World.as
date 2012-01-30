package{
  import flash.utils.*;
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
	
  public class World {
    public var world:Array;
    public var buffer:Array;
    public var items:Array;
    public var terrain:Array;
    public var player:Object;
    public var breakGround:Boolean;
    public var follow:Boolean;
    public var map:Array;
    public var cumulative_x:int;
    public var cumulative_y:int;
    public function World(stage:Object) {
      breakGround = true;
      world = new Array()
      buffer = new Array();
      items = new Array()
      terrain = new Array();
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
        terrain.push(new Array());
        for(var x:int = 0; x < map[0].length; x++){
          char = map[y].charAt(x);
          if(char == 'u'){
            var random:int = Math.floor(Math.random() * 101);
            if(random < 50){
              terrain[y][x] = 114 
            } else {
              terrain[y][x] = 130 
            }
            klass = Water;
          } else if (char == '.'){
            klass = Sand;
          } else if (char == 'V'){
            klass = Cliff;
          } else if (char == 'v'){
            klass = DarkCliff;
          } else if (char == 'f'){
            var random:int = Math.floor(Math.random() * 101);
            if(random < 30){
              klass = ForestTree;
            } else if(random < 50){
              klass = ForestBush;
            } else {
              klass = ForestGround;
            }
          } else {
            klass = Ground;
            var random:int = Math.floor(Math.random() * 101);
            if(random < 8){
              items[y][x] = new Tree()
            } else if(random < 30){
              items[y][x] = new Bush()
            }
          }
          world[y].push(klass);
        }
      }

      for(var i:int = 0; i < 20 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 20; j++){ 
          var y:int = i + stage.world_index_y;
          var x:int = j + stage.world_index_x;
          var object:Object = new world[y][x](j, i, stage, this);
          buffer[i][j] = object;
        }
      }
        
      player = new Player(10, 10, stage);
    }
    
    public function oldsetup(stage:Object) {
      var klass:Class;
      for(var y:int=0; y < 100 ;y++){ 
        world.push(new Array());
        for(var x:int = 0; x < 100; x++){ 
          var random:int = Math.floor(Math.random() * 101);
          if(y == stage.world_index_y && x == stage.world_index_x){ 
            klass = Ground; 
          } else if(x <= 4 || x >= 96 || y <=4 || y >= 96){
            klass = SeaWater;
          } else if(x <= 5 || x >= 95 || y <= 5 || y >= 95){
            klass = Water;
          } else if(x <= 7 || x >= 93 || y <= 7 || y >= 93){
            if(x != 58){
              klass = Sand
            } else {
              klass = Water
            }
          }else if(x == 61 && (y >= 75 && y < 83)) {
            klass = Water;
          } else if(x == 58 && (y >= 83 && y < 95)) {
            klass = Water;
          } else if(x >= 58 && x <= 62 && y >= 83 && y <= 83){ 
            if((y == 60 && x == 55) || (y == 60 && x == 62) || (y == 63 && x == 55) || (y == 63 && x == 62)){
              klass = Ground;
            } else {
              klass = Water;
            }
          } else if(random < 8){
            klass = Tree;
          } else if(random < 30){
            klass = Bush;
          } else {
            klass = Ground;
          }
          world[y].push(klass);
          //obxect.place(stage, this);
        }
      }
      for(var i:int = 0; i < 20 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 20; j++){ 
          var y:int = i + stage.world_index_y;
          var x:int = j + stage.world_index_x;
          var object:Object = new world[y][x](j, i, stage, this);
          buffer[i][j] = object;
        }
      }
      player = new Player(7, 18, stage);
      
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
        if(x < 18){
          results.push(buffer[y - 1][x + 1]);
        }
      }
      if(x > 0){
        results.push(buffer[y][x - 1]);
      }
      if(x < 18){
        results.push(buffer[y][x + 1]);
      }
      if(y < 18){
        results.push(buffer[y + 1][x]);
        if(x > 0){
          results.push(buffer[y + 1][x - 1]);
        }
        if(x < 18){
          results.push(buffer[y + 1][x + 1]);
        } 
      }
      return results;
    }
    
    public function finishMoving(stage):void{
      if(!stage.moving){
        player.sprite.drawTile(493);
        cumulative_x = 0;
        cumulative_y = 0;
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
        //  node.addItem(item, this)
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
          trace(y + ":" + x)
          trace(terrain[stage.world_index_y + y][stage.world_index_x + x])
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