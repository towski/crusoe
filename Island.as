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

  [SWF(backgroundColor="#000000", frameRate="24", width="640", height="760")]
  public class Island extends Sprite
  {   
    public var world:World;
    private var openList:Array;
    private var closedList:Array;
    private var currentNode:Object;
    private var movieClip:Sprite;
    public var energy:int;
    public var maxEnergy:int;
    public var maxHunger:int;
    public var maxHealth:int;
    public var wood:int;
    public var food:int;
    public var hunger:Number;
    public var health:Number;
    public var storage:Object
    
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
    public var hunger_text : TextField;
    public var health_text : TextField;
    
    public var bed_x:int;
    public var bed_y:int;
    public var klass:Class;
    public var gameOver:Boolean = true;
    public var barrel:Array;
    public var item:Item;
    public var player:Player;
    public var darkenInterval:Number;
    public var shadeVariablesFromBase:Array = [0.800, 1.000, 0.800, 0.400]
    public var shadeVariables:Array = [1.2500, 0.800, 0.500, 2.000];
    public var craftScreen:CraftScreen;
    
    [Embed(source="FFFHARMO.TTF", fontFamily="Harmony")]
    private var _arial_str:String;

    private var harmony_format:TextFormat;
    private var text_format:TextFormat;
    private var title_text:TextField;
    private var _text_interval:int;
    
    private var locked:Boolean = true;
    
    [Embed(source='previewenv.png')]
		public var sheetClass:Class;
		public var sheet:Bitmap = new sheetClass();
    
    public function Island():void{
      harmony_format = new TextFormat();
      harmony_format.font = "Harmony";
      harmony_format.size = 100;
      
      title_text = new TextField();
      title_text.autoSize = TextFieldAutoSize.LEFT;
      title_text.defaultTextFormat = harmony_format;
      title_text.text = "Robinson \n Crusoe";
      title_text.x = 50;
      title_text.y = 100;
      title_text.textColor = 0xffffffff;
      title_text.embedFonts = true
      title_text.alpha = 2.0
      addChild(title_text);
      
      stage.addEventListener(MouseEvent.CLICK, myClick);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keypress);
      //_text_interval = setInterval(hideIntroText, 50)
    }
    
    public function start():void{
      if(gameOverText != null && contains(gameOverText)){
        removeChild(gameOverText)
      }
      barrel = new Array();
      gameOver = false;
      world_index_x = 145;
      world_index_y = 104;
      moving = false;
      mode = 'left';
      daytime = true
      interval = 0;
      world = new World(this);
      world.setup(this);
      player = world.player
      energy = 100;
      maxEnergy = 100;
      maxHealth = 3;
      maxHunger = 10
      hunger = 10.0;
      health = 3.0
      food = 0;
      wood = 0;
      day = 0
      storage = new Object()
      
      text_format = new TextFormat();
      text_format.font = "Harmony";
      text_format.size = 10;
      
      health_text = new TextField();
      setupTextField(health_text)
      health_text.text = "health:" + health;
      health_text.x = stage.stageWidth / 2 - health_text.width / 2 - 270;
      
      hunger_text = new TextField();
      setupTextField(hunger_text)
      hunger_text.text = "hunger:" + hunger;
      hunger_text.x = stage.stageWidth / 2 - hunger_text.width / 2 - 200;

      energy_text = new TextField();
      setupTextField(energy_text)
      energy_text.text = "energy:" + energy;
      energy_text.x = stage.stageWidth / 2 - hunger_text.width / 2 - 100;
      
      wood_text = new TextField();
      wood_text.text = "wood:" + wood;
      wood_text.x = stage.stageWidth / 2 - wood_text.width / 2;
      setupTextField(wood_text)
      
      food_text = new TextField();
      food_text.x = stage.stageWidth / 2 - food_text.width / 2 + 100;
      setupTextField(food_text)
      food_text.text = "food:" + food;
      setLightInterval()
    }
    
    public function setLightInterval():void {
      darkenInterval = setInterval(darken, 20000);
    }
    
    public function clearLightInterval():void {
      clearInterval(darkenInterval)
    }
    
    public function setupTextField(textField:TextField):void {
      textField.autoSize = TextFieldAutoSize.LEFT;
      textField.defaultTextFormat = text_format;
      textField.embedFonts = true
      textField.y = 20 * 32
      textField.textColor = 0xffffffff;
      addChild(textField);
    }
    
    public function hideIntroText():void{
      title_text.alpha -= 0.04
      if(title_text.alpha <= 0){
        clearInterval(_text_interval)
        removeChild(title_text)
      }
    }
    
    public function updateEnergy(energyAddition:int):Boolean{
      var newEnergy:int = energy + energyAddition
      if(newEnergy > maxEnergy){
        energy = maxEnergy
        return true
      } else if(newEnergy >= 0) {
        energy += energyAddition;
        energy_text.text = "energy:" + energy;
        return true
      } else {
        return false
      }
    }
    
    public function updateHunger(hungerAddition:Number):void{
      if(hunger + hungerAddition < maxHunger){
        hunger += hungerAddition
      } else {
        hunger = maxHunger
      }
      if(hunger < 0){
        hunger = 0
      }
      hunger_text.text = "hunger:" + hunger;
    }
    
    public function updateHealth(healthAddition:Number):void{
      if(health + healthAddition < maxHealth){
        health += healthAddition
      } else {
        health = maxHealth
      }
      health_text.text = "health:" + health;
      if(health <= 0){
        endGame()
      }
    }
    
    public function darken():void{
      world.darken(shade());
      player.darken(shade());
      if(hunger <= 0){
        updateHealth(-0.5)
      }
      interval += 1;
      updateHunger(-0.5)
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
          if(node.isWalkable() && closedList.indexOf(node) == -1){
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
          setTimeout(world.movePerson, 200 + index * 400, currentNode.x, currentNode.y, true, this);
          index += 1;
          var child:Object = currentNode.child;
          currentNode.child = null;
          currentNode = child;  
        }
        setTimeout(world.movePerson, 200 + index * 400, currentNode.x, currentNode.y, false, this)
        if (closure != null){
          setTimeout(closure, index * 400 + 500, closureParam)
        }
      } else {
        moving = false;
      }
    }

    public function sortOpenList(first:Object, second:Object){
      return first.F - second.F;
    }
    
    public function replenishEnergy():void{
      updateEnergy(100);
      if(hunger > 0){
        updateHealth(1)
      }
      energy_text.text = "energy:" + energy;
    }
    
    public function take(node:Object):void{
      if(node.item != null && node.item.takeable){
        moving = true
        //stage.world.items[y + stage.world_index_y][x + stage.world_index_x] = null
        setTimeout(afterTake, node.item.delay, node)
      }
    }
    
    public function afterTake(node:Node):void {
      player.take(node, this);
      moving = false
      //  moving = true;
      //  openList = new Array();
      //  closedList = new Array();
      //  path(world.buffer[player.y][player.x], world.buffer[bed_y][bed_x], replenishEnergy, null);
      //}
    }
    
    public function useHand(node:Node):void{
      player.useHand(node, this)
    }
    
    public function endGame():void{
      gameOver = true;
      while (numChildren) removeChildAt(0);
      gameOverText = new TextField();
      setupTextField(gameOverText)
      gameOverText.x = stage.stageWidth / 2 
      clearInterval(world.interval)
      clearInterval(darkenInterval);
      addChild(gameOverText);
      gameOverText.text = "You have died \n click to shipwreck again"
    }
    
    public function place(node:Node):void{
      player.place(node, this);
      //if(object.requirements_met(this)){
      //object.place(this, world);
      energy_text.text = "energy:" + energy;
      wood_text.text = "wood:" + wood;
      //if(false){
      //  moving = true;
      //  openList = new Array();
      //  closedList = new Array();
      //  path(world.buffer[player.y][player.x], world.buffer[bed_y][bed_x], replenishEnergy, null);
      //}
    }
    
    public function myClick(eventObject:MouseEvent):void {
      if(gameOver){
        start()
        return
      }
      var x:int
      var y:int
      if(craftScreen == null){
        x = Math.floor(eventObject.stageX / 32)
        y = Math.floor(eventObject.stageY / 32)
        if(!moving){
          var currentPosition:Object = world.buffer[player.y][player.x];
          openList = new Array();
          closedList = new Array();
          if(world.buffer[y][x].isWalkable() && !player.handFull()){
            moving = true;
            path(currentPosition, world.buffer[y][x], null, null);
          } else {
            var targetItem:Item = world.buffer[y][x].item
            var target:Object = world.closestNeighbor(world.buffer[y][x]);
            if(target != null){
              if(player.handFull()){
                moving = true;
                if(targetItem == null){
                  if(player.bothHandsFull()){
                    path(currentPosition, target, place, world.buffer[y][x]);
                  } else if(player.currentHand() != null && player.currentHand().equipable) {
                    path(currentPosition, target, useHand, world.buffer[y][x]);
                  } else {
                    path(currentPosition, target, place, world.buffer[y][x]);
                  }
                } else {
                  path(currentPosition, target, useHand, world.buffer[y][x]);
                }
              } else {
                moving = true;
                //if(target.item != null){
                  path(currentPosition, target, take, world.buffer[y][x]);
                //} else {
                  //path(currentPosition, target, useHand, world.buffer[y][x]);
                //}
              }
            }
          }
        }
      } else {
        x = Math.floor((eventObject.stageX - craftScreen.startX - 16) / 48)
        y = Math.floor((eventObject.stageY - craftScreen.startY - 16) / 48)
        if(craftScreen.slot == x){
          var klass:Class = craftScreen.getOption()
          var object:Item = new klass(null)
          if(wood >= object.wood){
            //player.switchInventory()
            if(updateEnergy(-object.energyCost)){
              player.addToInventory(object, this)
              wood -= object.wood
              wood_text.text = "wood:" + wood;
            }
          }
          craftScreen.dispose(this)
          craftScreen = null
          moving = false
        } else if(y == 0) {
          craftScreen.highlightSlot(x)
        } else {
          craftScreen.dispose(this)
          craftScreen = null
          moving = false
        }
      }
    }
    
    public function keypress(keyEvent:KeyboardEvent):void {
      var keyPressed:int;
      keyPressed = keyEvent.keyCode;
      trace(keyPressed);
      if(keyPressed == 9){
        player.switchInventory()
      } else if(keyPressed == 50){
        //if(craftScreen == null && !player.hasInventory()){
        //  craftScreen = new CraftScreen(this)
        //  moving = true
        //} else if(craftScreen != null) {
        //  craftScreen.dispose(this)
        //  craftScreen = null
        //  moving = false
        //}
      } else if(keyPressed == 32){
        //var item:Item = player.clearInventory();
        if(gameOver){
          start()
        } else {
          player.useHand(null, this);
          energy_text.text = "energy:" + energy;
        }
      } else if(keyPressed == 52){
        player.hit()
        //if(!gameOver){
        //  endGame()
        //}
      } else if(keyPressed == 53){
        player.clearInventory(this);
        player.addToInventory(new Barrel(null), this);
      } else if(keyPressed == 87){ //up
        world.movePerson(player.x, player.y - 1, false, this, false)
       } else if(keyPressed == 83 || keyPressed == 40){ //down
        world.movePerson(player.x, player.y + 1, false, this, false)
       } else if(keyPressed == 65){ //left
        world.movePerson(player.x - 1, player.y, false, this, false)
      } else if(keyPressed == 68){ //right
        world.movePerson(player.x + 1, player.y, false, this, false)
      } else if(keyPressed == 81){ //up + left
        world.movePerson(player.x - 1, player.y - 1, false, this, false)
      } else if(keyPressed == 69){ //up + right
        world.movePerson(player.x + 1, player.y - 1, false, this, false)
      } else if(keyPressed == 90){ //down + left
        world.movePerson(player.x - 1, player.y + 1, false, this, false)
      } else if(keyPressed == 67){ //down + right
        world.movePerson(player.x + 1, player.y + 1, false, this, false)
      }
    }
  }
}