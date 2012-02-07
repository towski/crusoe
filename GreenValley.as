package
{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;  
  import flash.display.BlendMode;  
  
  import flash.events.*;
  import flash.display.StageQuality;
  import flash.utils.*;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;

  [SWF(backgroundColor="#ffffff", frameRate="24", width="640", height="800")]
  public class GreenValley extends Sprite
  {   
    public var world:World;
    private var openList:Array;
    private var closedList:Array;
    private var currentNode:Object;
    private var movieClip:Sprite;
    public var energy:int;
    public var maxEnergy:int;
    public var wood:int;
    public var food:int;
    public var day:int;
    public var interval:int;
    public var daytime:Boolean;
    public var world_index_y:int;
    public var world_index_x:int;
    public var moving:Boolean;
    public var mode:String;
    public var energy_text : TextField;
    public var gameOverText : TextField;
    public var wood_text : TextField;
    public var food_text : TextField;
    public var bed_x:int;
    public var bed_y:int;
    public var klass:Class;
    public var gameOver:Boolean;
    public var barrel:Array;
    public var item:Item;
    public var darkenInterval:Number;
    public var shadeVariablesFromBase:Array = [0.800, 1.000, 0.800, 0.400]
    public var shadeVariables:Array = [1.2500, 0.800, 0.500, 2.000];
    
    [Embed(source="FFFHARMO.TTF", fontFamily="Harmony")]
    private var _arial_str:String;

    private var _arial_fmt:TextFormat;
    private var _text_txt:TextField;
    private var _text_interval:int;
    
    [Embed(source='previewenv.png')]
		public var sheetClass:Class;
		public var sheet:Bitmap = new sheetClass();
    
    public function GreenValley():void{
      start()
      //var bitmapData:BitmapData = new BitmapData(800, 800, false, 0x88888888);
      //var bitmap:Bitmap = new Bitmap(bitmapData)
      //bitmap.blendMode = BlendMode.OVERLAY
      //addChild(bitmap);
      //var pic:Bitmap = new Picture();
    }
    
    public function start():void{
      barrel = new Array();
      gameOver = false;
      world_index_x = 145;
      world_index_y = 104;
      moving = false;
      mode = 'take';
      daytime = true
      interval = 0;
      world = new World(this);
      world.setup(this);
      stage.addEventListener(MouseEvent.CLICK, myClick);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keypress);
      energy = 100;
      maxEnergy = 100;
      food = 0;
      wood = 0;
      day = 0
      energy_text = new TextField();
      energy_text.text = "energy:" + energy;
      energy_text.autoSize = TextFieldAutoSize.LEFT;
      energy_text.x = stage.stageWidth / 2 - energy_text.width / 2;
      energy_text.y = 20 * 32
      addChild(energy_text);
      wood_text = new TextField();
      wood_text.text = "wood:" + wood;
      wood_text.autoSize = TextFieldAutoSize.LEFT;
      wood_text.x = stage.stageWidth / 2 - wood_text.width / 2 + 50;
      wood_text.y = 20 * 32
      addChild(wood_text);
      food_text = new TextField();
      food_text.text = "food:" + food;
      food_text.autoSize = TextFieldAutoSize.LEFT;
      food_text.x = stage.stageWidth / 2 - food_text.width / 2 + 100;
      food_text.y = 20 * 32
      addChild(food_text);
      darkenInterval = setInterval(darken, 20000);
      
      _arial_fmt = new TextFormat();
      _arial_fmt.font = "Harmony";
      _arial_fmt.size = 40;
      
      _text_txt = new TextField();
      _text_txt.embedFonts = true;
      _text_txt.autoSize = TextFieldAutoSize.LEFT;
      _text_txt.defaultTextFormat = _arial_fmt;
      _text_txt.text = "Robinson Crusoe";
      _text_txt.x = (stage.stageWidth  / 2 - _text_txt.width / 2);
      _text_txt.y = (stage.stageHeight / 2 - _text_txt.height / 2);
      _text_txt.textColor = 0xffffffff;
      _text_txt.embedFonts = true
      _text_txt.alpha = 2.0
      addChild(_text_txt);
      _text_interval = setInterval(hideIntroText, 100)
    }
    
    public function hideIntroText():void{
      _text_txt.alpha -= 0.075
      if(_text_txt.alpha <= 0){
        clearInterval(_text_interval)
        removeChild(_text_txt)
      }
    }
    
    public function updateEnergy(energyAddition:int):void{
      if(energy + energyAddition < maxEnergy){
        energy += energyAddition;
      } else {
        energy = maxEnergy
      }
      energy_text.text = "energy:" + energy;
      if(energy <= 0){
        endGame()
      }
    }
    
    public function darken():void{
      world.darken(shade());
      world.player.darken(shade());
      updateEnergy(-5)
      interval += 1;
      if(interval % 4 == 0){
        day += 1;
      }
    }
    
    public function shade():Number{
      return shadeVariables[interval % 4]
    }
    
    public function shadeFromBase():Number{
      return shadeVariablesFromBase[interval % 4]
    }
    
    public function path(start:Object, end:Object, closure:Function, closureParam:Object):void{
      start.F = 0;
      start.G = 0;
      openList.push(start);
      while(openList.length != 0){
        currentNode = openList.shift();
        if(currentNode === end){
          break;
        }
        closedList.push(currentNode);
        var currentNeighbors:Array = world.neighbors(currentNode);
        for(var i:int = 0; i < currentNeighbors.length; i++){ 
          var node:Object = currentNeighbors[i];
          if(node.walkable && closedList.indexOf(node) == -1){
            if(openList.indexOf(node) == -1){
              openList.push(node);
              node.parent = currentNode;
              node.G = node.parent.G;
              if(node.x != node.parent.x && node.y != node.parent.y){
                node.G = node.G + 14;
              } else {
                node.G = node.G + 10;
              }
              node.H = Math.abs(end.x - node.x) * 10 + Math.abs(end.y - node.y) * 10;
              node.F = node.G + node.H;
              openList.sort(sortOpenList);
            } else {
              var G:int = node.parent.G;
              if(node.x != currentNode.x && node.y != currentNode.y){
                G = G + 14;
              } else {
                G = G + 10;
              }
              if(G < node.G){
                node.parent = currentNode;
                node.G = G;
                node.F = node.G + node.H;
                openList.sort(sortOpenList);
              }
            }
          }
        }
      }
      if(currentNode === end){
        while(currentNode.parent && currentNode !== start){
          currentNode.parent.child = currentNode;
          var parent:Object = currentNode.parent;
          currentNode.parent = null;
          currentNode = parent;
        }
        //if(currentNode.child){
        //  recurse(currentNode.x, currentNode.y, graphics, true, this);
        //}
        var index:int = 0;
        while(currentNode.child){
          setTimeout(world.movePerson, index * 500, currentNode.x, currentNode.y, graphics, true, this);
          index += 1;
          var child:Object = currentNode.child;
          currentNode.child = null;
          currentNode = child;  
        }
        setTimeout(world.movePerson, index * 500, currentNode.x, currentNode.y, graphics, false, this)
        if (closure != null){
          setTimeout(closure, index * 500 + 500, closureParam)
        }
      } else {
        moving = false;
      }
    }
    
    public function recurse(x:int, y:int, graphics:Object, setMoving:Boolean, stage:Object):void{
      world.movePerson(currentNode.x, currentNode.y, graphics, true, this)
      if(currentNode.child){
        var child:Object = currentNode.child;
        currentNode.child = null;
        currentNode = child;
        recurse(currentNode.x, currentNode.y, graphics, true, this)
      } else {
        world.movePerson(currentNode.x, currentNode.y, graphics, false, this)
        //recurse(currentNode.x, currentNode.y, graphics, false, this)
      }
    }

    public function sortOpenList(first:Object, second:Object){
      return first.F - second.F;
    }
    
    public function replenishEnergy(node:Object):void{
      updateEnergy(50);
      food -= 1;
      energy_text.text = "energy:" + energy;
      food_text.text = "food:" + food;
    }
    
    public function take(node:Object):void{
      if(node.takeable){
        //stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = null
        setTimeout(afterTake, node.delay, node)
      }
    }
    
    public function afterTake(node:Node){
      world.player.take(node, this);
      moving = false
      //  moving = true;
      //  openList = new Array();
      //  closedList = new Array();
      //  path(world.buffer[world.player.y][world.player.x], world.buffer[bed_y][bed_x], replenishEnergy, null);
      //}
    }
    
    public function useItem(node:Object):void{
      world.player.useItem(node, this)
    }
    
    public function endGame():void{
      gameOver = true;
      while (numChildren) removeChildAt(0);
      gameOverText = new TextField();
      gameOverText.text = "Game over"
      gameOverText.autoSize = TextFieldAutoSize.LEFT;
      gameOverText.x = stage.stageWidth / 2 
      gameOverText.y = stage.stageHeight / 2
      clearInterval(world.interval)
      clearInterval(darkenInterval);
      addChild(gameOverText);
    }
    
    public function place(node:Object){
      world.player.place(node, this);
      //if(object.requirements_met(this)){
      //object.place(this, world);
      energy_text.text = "energy:" + energy;
      wood_text.text = "wood:" + wood;
      moving = false
      //if(false){
      //  moving = true;
      //  openList = new Array();
      //  closedList = new Array();
      //  path(world.buffer[world.player.y][world.player.x], world.buffer[bed_y][bed_x], replenishEnergy, null);
      //}
    }
    
    public function myClick(eventObject:MouseEvent):void {
      var x:int = Math.floor(eventObject.stageX / 32);
      var y:int = Math.floor(eventObject.stageY / 32); 
      if(!moving){
        var currentPosition:Object = world.buffer[world.player.y][world.player.x];
        openList = new Array();
        closedList = new Array();
        if(world.buffer[y][x].isWalkable() && !world.player.hasInventory()){
          moving = true;
          path(currentPosition, world.buffer[y][x], null, null);
        } else {
          var target:Object = world.closestNeighbor(world.buffer[y][x]);
          if(target){
            if(world.player.hasInventory()){
              moving = true;
              if(mode == "take"){
                path(currentPosition, target, place, world.buffer[y][x]);
              } else {
                path(currentPosition, target, useItem, world.buffer[y][x]);
              }
            } else if(!world.player.hasInventory()) {
              moving = true;
              if(mode == "take"){
                path(currentPosition, target, take, world.buffer[y][x]);
              } else {
                path(currentPosition, target, useItem, world.buffer[y][x]);
              }
            }
          }
        }
      }
    }
    
    public function keypress(keyEvent:KeyboardEvent):void {
      var keyPressed:int;
      keyPressed = keyEvent.keyCode;
      trace(keyPressed);
      if(keyPressed == 49){
        
          mode = 'take';
          trace("take")
      } else if(keyPressed == 50){
                mode = 'use';
                trace("use")
      } else if(keyPressed == 51){
        mode = 'use';
        //world.player.clearInventory();
        //world.player.addToInventory(new Log(null), this);
      } else if(keyPressed == 32){
        //var item:Item = world.player.clearInventory();
        if(gameOver){
          start()
        }
        world.player.useItem(null, this);
        energy_text.text = "energy:" + energy;
      } else if(keyPressed == 52){
        if(!gameOver){
          endGame()
        }
      } else if(keyPressed == 53){
        world.player.clearInventory();
        world.player.addToInventory(new Barrel(null), this);
      } else if(keyPressed == 51){
        for(var y:int = 0; y < 20; y++){
          for(var x:int = 0; x < 20; x++){
            world.buffer[y][x].sprite.drawTile(world.items[ world_index_y + y][ world_index_x + x])
            world.buffer[y][x].groundSprite.drawTile(world.terrain[ world_index_y + y][ world_index_x + x])
           

            //buffer[y][x].sprite.drawTile(terrain[x][y])
          }
        }
        //inventorySlot.drawTile(135);
        klass = Bed;
      } else if(keyPressed == 87){ //up
        world.moveCameraUp(this);
       } else if(keyPressed == 83 || keyPressed == 40){ //down
         world.moveCameraDown(this);
       } else if(keyPressed == 65){ //left
         world.moveCameraLeft(this);
      } else if(keyPressed == 68){ //right
        world.moveCameraRight(this);
      }
    }
  }
}