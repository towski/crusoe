package{
  import flash.utils.*;
  public class World {
    public var world:Array;
    public var buffer:Array;
    public var player:Object;
    public var breakGround:Boolean;
    public function World(stage:Object) {
      breakGround = true;
      world = new Array()
      buffer = new Array();
    }
    
    public function setup(stage:Object) {
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
          }else if(x == 61 && (y >= 75 && y < 80)) {
            klass = Water;
          } else if(x == 58 && (y >= 78 && y < 95)) {
            klass = Water;
          } else if(x >= 57 && x <= 63 && y >= 80 && y <= 83){ 
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
      for(var i:int = 0; i < 25 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 25; j++){ 
          var y:int = i + stage.world_index_y;
          var x:int = j + stage.world_index_x;
          var object:Object = new world[y][x](j, i, stage, this);
          buffer[i][j] = object;
        }
      }
      player = new Player(7, 18, stage);
      //new Cow(Math.floor(Math.random() * 24), Math.floor(Math.random() * 24), stage, this);
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
        if(x < 23){
          results.push(buffer[y - 1][x + 1]);
        }
      }
      if(x > 0){
        results.push(buffer[y][x - 1]);
      }
      if(x < 23){
        results.push(buffer[y][x + 1]);
      }
      if(y < 23){
        results.push(buffer[y + 1][x]);
        if(x > 0){
          results.push(buffer[y + 1][x - 1]);
        }
        if(x < 23){
          results.push(buffer[y + 1][x + 1]);
        } 
      }
      return results;
    }
    
    public function finishMoving(stage):void{
      if(!stage.moving){
        player.sprite.drawTile(493);
      }
    }
    
    public function movePerson(x:int, y:int, graphics:Object, setMoving:Boolean, stage:Object):void{
      if (!setMoving){
        setTimeout(finishMoving, 500, stage);
      }
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
      stage.moving = setMoving;
      stage.addChild(player.sprite);
			
    }
  }
}