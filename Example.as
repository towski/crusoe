
//sprite.graphics.beginFill(color);
//sprite.graphics.drawRect(0, 0, 25, 25);
//sprite.graphics.endFill();
//sprite.x = 25 * x;
//sprite.y = 25 * y;



//var random:int = Math.floor(Math.random() * 101);

//new Cow(Math.floor(Math.random() * 24), Math.floor(Math.random() * 24), stage, this);


//sheet.bitmapData.colorTransform( new Rectangle(0, 0, 32, 32), new ColorTransform(0.5, 0.5, 0.5));

/* 
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
*/