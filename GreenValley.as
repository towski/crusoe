package
{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.events.*;
  import flash.display.StageQuality;
  import flash.utils.*;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;

  [SWF(backgroundColor="#ffffff", frameRate="24", width="800", height="800")]
  public class GreenValley extends Sprite
  {   
    private var world:World;
    private var openList:Array;
    private var closedList:Array;
    private var currentNode:Object;
    private var movieClip:Sprite;
    public var energy:int;
    public var wood:int;
    public var food:int;
    public var world_index_y:int;
    public var world_index_x:int;
    public var moving:Boolean;
    public var mode:int;
    public var energy_text : TextField;
    public var wood_text : TextField;
    public var food_text : TextField;
    public var bed:Bed;
    public var klass:Class;
    public function GreenValley():void{
      world_index_x = 0;
      world_index_y = 1;
      moving = false;
      mode = 0;
      world = new World(this);
      world.setup(this);
      stage.addEventListener(MouseEvent.CLICK, myClick);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keypress);
      energy = 50;
      food = 5;
      wood = 15;
      energy_text = new TextField();
      energy_text.text = "energy:" + energy;
      energy_text.autoSize = TextFieldAutoSize.LEFT;
      energy_text.x = stage.stageWidth / 2 - energy_text.width / 2;
      energy_text.y = 0
      addChild(energy_text);
      wood_text = new TextField();
      wood_text.text = "wood:" + wood;
      wood_text.autoSize = TextFieldAutoSize.LEFT;
      wood_text.x = stage.stageWidth / 2 - wood_text.width / 2 + 50;
      wood_text.y = 0
      addChild(wood_text);
      food_text = new TextField();
      food_text.text = "food:" + food;
      food_text.autoSize = TextFieldAutoSize.LEFT;
      food_text.x = stage.stageWidth / 2 - food_text.width / 2 + 100;
      food_text.y = 0
      addChild(food_text);
      //var pic:Bitmap = new Picture();
    }
    
    public function path(start:Object, end:Object, closure:Function, closureParam:Object):void{
      start.F = 0;
      start.G = 0;
      openList.push(start);
      while(openList.length != 0){
        currentNode = openList.shift();
        trace(currentNode.G);
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
        var index:int = 0;
        while(currentNode.child){
          setTimeout(world.movePerson, index * 500, currentNode.x, currentNode.y, graphics, true, this);
          index += 1;
          var child:Object = currentNode.child;
          currentNode.child = null;
          currentNode = child;  
        }
        setTimeout(world.movePerson, index * 500, currentNode.x, currentNode.y, graphics, false, this)
        if (closure){
          setTimeout(closure, index * 500 + 500, closureParam)
        }
      } else {
        moving = false;
      }
    }

    public function sortOpenList(first:Object, second:Object){
      return first.F - second.F;
    }
    
    public function replenishEnergy(node:Object):void{
      energy = 50;
      food -= 1;
      energy_text.text = "energy:" + energy;
      food_text.text = "food:" + food;
    }
    
    public function take(node:Object):void{
      energy -= 1;
      world.buffer[node.y][node.x].take(this, world, after_take);
      energy_text.text = "energy:" + energy;
      wood_text.text = "wood:" + wood;
    }
    
    public function after_take(node:Object){
      world.breakGround = false;
      var ground:Ground = new Ground(node.x, node.y, this, world);
      world.breakGround = true;
      swapChildren(ground.groundSprite, world.buffer[node.y][node.x].sprite)
      if(world.buffer[node.y][node.x].sprite){
        removeChild(world.buffer[node.y][node.x].sprite);
      }
      removeChild(world.buffer[node.y][node.x].groundSprite);
      world.buffer[node.y][node.x] = ground
      if(energy == 0){
        moving = true;
        openList = new Array();
        closedList = new Array();
        path(world.buffer[world.player.y][world.player.x], world.buffer[bed.y][bed.x], replenishEnergy, null);
      }
    }
    
    public function place(node:Object){
       var object:Node = new klass(node.x, node.y, this, world);
       if(object.requirements_met(this)){
         object.place(this, world);
         energy_text.text = "energy:" + energy;
         wood_text.text = "wood:" + wood;
       }
       if(energy <= 0){
         moving = true;
         openList = new Array();
         closedList = new Array();
         path(world.buffer[world.player.y][world.player.x], world.buffer[bed.y][bed.x], replenishEnergy, null);
       }
    }
    
    public function myClick(eventObject:MouseEvent):void {
      var x:int = Math.floor(eventObject.stageX / 32);
      var y:int = Math.floor(eventObject.stageY / 32); 
      if(!moving){
        var currentPosition:Object = world.buffer[world.player.y][world.player.x];
        openList = new Array();
        closedList = new Array();
        if(world.buffer[y][x].walkable && mode == 0){
          moving = true;
          path(currentPosition, world.buffer[y][x], null, null);
        } else {
          var targetNeighbors:Array = world.neighbors(world.buffer[y][x]);
          var target:Object;
          for(var i:int = 0; i < targetNeighbors.length; i++){
            if(targetNeighbors[i].walkable){
              target = targetNeighbors[i];
              break;
            }
          }
          if(target){
            if((mode == 1 || mode == 2) && world.buffer[y][x].walkable){
              moving = true;
              path(currentPosition, target, place, world.buffer[y][x]);
            } else if(mode == 0) {
              moving = true;
              path(currentPosition, target, take, world.buffer[y][x]);
            }
          }
        }
      }
    }
    
    public function keypress(keyEvent:KeyboardEvent):void {
      var keyPressed:int;
      keyPressed = keyEvent.keyCode;
      trace(keyPressed);
      if(keyPressed == 48){
        mode = 0;
        klass = Ground;
      } else if(keyPressed == 49){
        mode = 1;
        klass = Fence;
      } else if(keyPressed == 50){
        mode = 2;
        klass = Bed;
      } else if(keyPressed == 87){ //up
        world_index_y -= 1;
        for(var x:int = 0; x < 25; x++){
          var object:Node = world.buffer[24][x];
          removeChild(object.groundSprite);
          if(object.sprite != object.groundSprite){
            removeChild(object.sprite);
          }
        }
        world.buffer.splice(24,1);
        world.player.y += 1;
        world.player.sprite.y += 32;
        world.buffer.push(new Array());
        for(var x:int = 0; x < 25; x++){
          world.buffer[0].push(new world.world[world_index_y][x](x, 0, this, world));
        }
        for(var x:int = 0; x < 25; x++){
          for(var y:int = 0; y < 24; y++){
            world.buffer[y][x].update(x,y);
          }
        }
      } else if(keyPressed == 83 || keyPressed == 40){ //down
        world_index_y += 1;
        for(var x:int = 0; x < 25; x++){
          var object:Node = world.buffer[0][x];
          removeChild(object.groundSprite);
          if(object.sprite != object.groundSprite){
            removeChild(object.sprite);
          }
        }
        world.buffer.splice(0,1);
        world.player.y -= 1;
        world.player.sprite.y -= 32;
        world.buffer.push(new Array());
        for(var x:int = 0; x < 25; x++){
          world.buffer[24].push(new world.world[world_index_y][x](x, 24, this, world));
        }
        for(var x:int = 0; x < 25; x++){
          for(var y:int = 0; y < 24; y++){
            world.buffer[y][x].update(x,y);
          }
        }
      } else if(keyPressed == 65){ //left
        world_index_x -= 1;
      } else if(keyPressed == 68){ //right
        world_index_x += 1;
      }
    }
  }
}