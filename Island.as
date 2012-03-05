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
  import flash.net.SharedObject

  [SWF(backgroundColor="#000000", frameRate="24", width="640", height="760")]
  public class Island extends Sprite
  {   
    public var world:World;
    private var openList:Array;
    private var closedList:Array;
    private var currentNode:Object;
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
    public var currentTarget:Object
    public var nearTarget:Object
    
    public var energy_text : TextField;
    public var gameOverText : TextField;
    public var wood_text : TextField;
    public var food_text : TextField;
    public var hunger_text : TextField;
    public var health_text : TextField;
    public var achievement_text : TextField;
    
    public var bed_x:int;
    public var bed_y:int;
    public var klass:Class;
    public var gameOver:Boolean = true;
    public var clearSharedObject:Boolean = false;
    public var barrel:Array;
    public var chest:Array;
    public var item:Item;
    public var player:Player;
    public var darkenInterval:Number;
    public var shadeVariablesFromBase:Array = [0.800, 1.000, 0.800, 0.400]
    public var shadeVariables:Array = [1.2500, 0.800, 0.500, 2.000];
    public var craftScreen:CraftScreen;
    
    public var firstText:String = "Ye! Have been SHIPWRECK'D! \n I pity ye fool! \n Ye are doomed to rot and smell horrible. Unless...\n"
    public var secondText:String = "I help ye with some old shipwrecked pirate tips. \n See I was once stuck on an island just like ye. \n I was bored with no other pirates around to get swagged with\n"
    public var tutorialStrings:Array;
    
    [Embed(source="FFFHARMO.TTF", fontFamily="Harmony", embedAsCFF='false')]
    private var _arial_str:String;

    private var harmony_format:TextFormat;
    private var text_format:TextFormat;
    private var title_text:TextField;
    private var _text_interval:int;
    
    private var locked:Boolean = true;
    
    [Embed(source='previewenv.png')]
		public var sheetClass:Class;
		public var sheet:Bitmap = new sheetClass();
    public var sharedObject:SharedObject
    
    public var achievements:Achievements
    public var currentAchievement:String
    public var choppedTrees:int
    public var goatsKilled:int
    public var fowlsKilled:int
    public var cannibalsKilled:int
    
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
      
      sharedObject = SharedObject.getLocal("savedData")
      tutorialStrings = new Array()
      tutorialStrings.push("Click on ye axe to pick it up")
      
      //_text_interval = setInterval(hideIntroText, 50)
    }
    
    public function start(load:Boolean):void{
      if(gameOverText != null && contains(gameOverText)){
        removeChild(gameOverText)
      }
      achievements = new Achievements(sharedObject.data.achievements, this)
      barrel = new Array();
      chest = new Array()
      gameOver = false;
      world = new World(this);
      trace(load)
      if(load){
        world_index_x   = sharedObject.data.world_index_x;
        world_index_y   = sharedObject.data.world_index_y;
        moving          = false
        mode            = sharedObject.data.mode;
        daytime         = sharedObject.data.daytime
        interval        = sharedObject.data.interval;
        energy          = sharedObject.data.energy;
        maxEnergy       = sharedObject.data.maxEnergy;
        maxHealth       = sharedObject.data.maxHealth;
        maxHunger       = sharedObject.data.maxHunger
        hunger          = sharedObject.data.hunger;
        health          = sharedObject.data.health
        food            = sharedObject.data.food;
        wood            = sharedObject.data.wood;
        day             = sharedObject.data.day 
        barrel          = sharedObject.data.barrel 
        chest           = sharedObject.data.chest 
        choppedTrees    = sharedObject.data.choppedTrees
        goatsKilled     = sharedObject.data.goatsKilled
        fowlsKilled     = sharedObject.data.fowlsKilled
        cannibalsKilled = sharedObject.data.cannibalsKilled
        
        world.setup(this, sharedObject);
        trace(sharedObject.data.playerInventory)
        if(sharedObject.data.playerInventory != null){
          world.player.inventoryClass = flash.utils.getDefinitionByName(sharedObject.data.playerInventory)
        }
        trace(sharedObject.data.playerEquipment)
        if(sharedObject.data.playerEquipment != null){
          world.player.equipmentClass = flash.utils.getDefinitionByName(sharedObject.data.playerEquipment)
        }
        player = world.player
        player.createInventory()
        if(player.equipmentClass != null){
          player.drawEquipment(this)
        }
        if(player.inventoryClass != null){
          player.drawInventory(this)
        }
    } else {
        world_index_x = 145;
        world_index_y = 104;
        moving = false;
        mode = 'left';
        daytime = true
        interval = 0;
        energy = 100;
        maxEnergy = 100;
        maxHealth = 3;
        maxHunger = 10
        hunger = 10.0;
        health = 3.0
        choppedTrees = 0
        food = 0;
        wood = 0;
        day = 0
        world.setup(this, null);
        player = world.player
        goatsKilled = 0
        fowlsKilled = 0
        cannibalsKilled = 0
      }
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
      
      //player_x_text = new TextField();
      //player_x_text.x = stage.stageWidth / 2 - food_text.width / 2 + 100;
      //setupTextField(player_x_text)
      //player_x_text.text = "player x:" + player.x;
      //
      //player_y_text = new TextField();
      //player_y_text.x = stage.stageWidth / 2 - food_text.width / 2 + 100;
      //setupTextField(player_y_text)
      //player_y_text.text = "player y:" + player.y;
      
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
      textField.textColor = 0x00ffffff;
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
      world.save(this, sharedObject)
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
          setTimeout(world.movePerson, 200 + index * 300, currentNode.x, currentNode.y, true, this, true, currentTarget, nearTarget, closure, closureParam);
          index += 1;
          var child:Object = currentNode.child;
          currentNode.child = null;
          currentNode = child;  
        }
        setTimeout(world.movePerson, 200 + index * 300, currentNode.x, currentNode.y, false, this, true, currentTarget, nearTarget, closure, closureParam)
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
      if(!gameOver){
        player.take(node, this);
        moving = false
      }
      //  moving = true;
      //  openList = new Array();
      //  closedList = new Array();
      //  path(world.buffer[player.y][player.x], world.buffer[bed_y][bed_x], replenishEnergy, null);
      //}
    }
    
    public function useItem(node:Node):void{
      node.useItem()
    }
    
    public function useHand(node:Node):void{
      player.useHand(node, this)
    }
    
    public function endGame():void{
      sharedObject.clear()
      gameOver = true;
      clearSharedObject = true
      while (numChildren) removeChildAt(0);
      clearInterval(world.interval)
      clearInterval(darkenInterval);
      
      gameOverText = new TextField();
      setupTextField(gameOverText)
      gameOverText.x = stage.stageWidth / 2 
      gameOverText.y = stage.stageHeight / 2 
      addChild(gameOverText);
      gameOverText.text = "You have died \n You survived " + Math.floor(interval / 4.0) + " days \n Click to shipwreck again"
    }
    
    public function placeShip():void{
      var random:int = Math.floor(Math.random() * world.shipMarkers.length);
      var shipMarker:ShipMarker = world.shipMarkers[random]
      world.items[shipMarker.y][shipMarker.x] = Ship
    }
    
    public function win():void{
      gameOver = true;
      while (numChildren) removeChildAt(0);
      gameOverText = new TextField();
      setupTextField(gameOverText)
      gameOverText.x = stage.stageWidth / 2 
      gameOverText.y = stage.stageHeight / 2 
      clearInterval(world.interval)
      clearInterval(darkenInterval);
      addChild(gameOverText);
      gameOverText.text = "Congratulations! \n You got off the island in " + Math.floor(interval / 4.0) + " days \n"
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
        if(clearSharedObject == true){
          sharedObject = SharedObject.getLocal("savedData")
          sharedObject.clear()
          clearSharedObject = false
        }
        start(sharedObject.data.day != null && sharedObject.data.day != undefined)
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
          trace("move")
          if(world.buffer[y][x].isWalkable() && !player.handFull()){
            world.buffer[y][x].highlightTile()
            moving = true;
            trace("move to: " + x + ":" + y)
            path(currentPosition, world.buffer[y][x], null, null);
          } else {
            var targetItem:Item = world.buffer[y][x].item
            currentTarget = world.buffer[y][x]
            var target:Object = world.closestNeighbor(world.buffer[y][x]);
            nearTarget = target
            trace("target: " + target.x + ":" + target.y)
            if(target != null){
              world.buffer[y][x].highlightTile()
              target.highlightTile()
              if(player.handFull()){
                moving = true;
                if(targetItem == null){
                  path(currentPosition, target, useHand, world.buffer[y][x]);
                  //if(player.bothHandsFull()){
                  //  path(currentPosition, target, place, world.buffer[y][x]);
                  //} else if(player.currentHand() != null && player.currentHand().equipable) {
                  //  
                  //} else {
                  //  path(currentPosition, target, place, world.buffer[y][x]);
                  //}
                } else {
                  if(targetItem.useable){
                    path(currentPosition, target, useItem, world.buffer[y][x])
                  } else {
                    path(currentPosition, target, useHand, world.buffer[y][x])
                  }
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
    
    public function addAchievement(text:String):void {
      achievements.addAchievement(text)
    }
    
    public function showCurrentAchievement():void {
      if(currentAchievement != null){
        if(achievement_text != null && contains(achievement_text)){
          removeChild(achievement_text)
        }
        achievement_text = new TextField()
        text_format.size = 20;
        setupTextField(achievement_text)
        achievement_text.x = stage.stageWidth - 400
        achievement_text.y = 10
        achievement_text.text = currentAchievement
        text_format.size = 10
      }
    }
    
    public function showAchievement(text:String):void {
      currentAchievement = text
      showCurrentAchievement()
      setTimeout(clearAchievement, 5000)
    }
    
    public function clearAchievement():void {
      achievement_text.text = ""
      currentAchievement = null
    }
    
    public function keypress(keyEvent:KeyboardEvent):void {
      var keyPressed:int;
      keyPressed = keyEvent.keyCode;
      if(keyPressed == 9){
        player.switchInventory()
      } else if(keyPressed == 50){
        world.save(this, sharedObject)
      } else if(keyPressed == 51){
        trace("clear sharedObject")
        sharedObject.clear()
      } else if(keyPressed == 32){
        //var item:Item = player.clearInventory();
        if(gameOver){
          start(true)
        } else {
          player.useHand(null, this);
          energy_text.text = "energy:" + energy;
        }
      } else if(keyPressed == 52){
        showAchievement("hey")
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