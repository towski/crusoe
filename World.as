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
      for(var i:int=0; i < 40 ;i++){ 
        world.push(new Array());
        for(var j:int = 0; j < 40; j++){ 
          var random:int = Math.floor(Math.random() * 101);
          if(i == 0 && j == 0){ 
            klass = Ground; 
          } else if(random < 8){
            klass = Tree;
          } else if(random < 30){
            klass = Bush;
          } else {
            klass = Ground;
          }
          world[i].push(klass);
          //object.place(stage, this);
        }
      }
      for(var i:int = 0; i < 25 ;i++){ 
        buffer.push(new Array());
        for(var j:int = 0; j < 25; j++){ 
          var object:Object = new world[i][j](j, i, stage, this);
          buffer[i][j] = object;
        }
      }
      player = new Player(0, 0, stage);
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
    }
  }
}