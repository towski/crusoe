package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ButtonMat extends Sprite
	{
		//The size and amount of each sprite in the sprite sheet
		private var spriteWidth:Number = 32;
		private var spriteHeight:Number = 32;	
		private var spriteCount:int = 256;
		
		private var sheet:Bitmap;
		private var selector:Sprite;
		
		public function ButtonMat(spriteSheet:Bitmap)
		{
			sheet = spriteSheet;
			addChild(sheet);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);	
			
			//Create black square
			selector = new Sprite();
			selector.graphics.beginFill(0xFFFFFF, 0.4);
			selector.graphics.drawRect(0,0,spriteWidth,spriteHeight);
			selector.graphics.endFill();
			addChildAt(selector, 0);
		}
		
		/**
		 * Calculate and return a zone number equivalent to the clicked
		 * Sprite's numbering order
		 */
		public function checkZone():int
		{
			var rowLength:int = int(sheet.width / 32);
			var zone:int = int(this.mouseX / 32) + (int(this.mouseY / 32) * rowLength);
			
			if (zone < spriteCount) {
				return zone;
			}
			return -1;
		}
		
		/**
		 * Move a block highlighting each sprite based on the total
		 * number of sprites in the sprite sheet
		 */
		private function onMouseMove(e:MouseEvent):void
		{
			var rowLength:int = int(sheet.width / spriteWidth); //Number of sprites in a row
			var columnLength:int = int(sheet.height / spriteHeight); //Number of sprites in a column
			
			var xPosition:int = (int(this.mouseX / spriteWidth) * spriteWidth) % (rowLength * spriteWidth);
			var yPosition:int = (int(this.mouseY / spriteHeight) * spriteHeight) % (columnLength * spriteHeight);
			
			var zone:int = checkZone();
			
			//Move selector if sprite exists to highlight
			if ((this.mouseX < sheet.width) && (zone != -1)) {
				selector.x = xPosition
				selector.y = yPosition
			}			
		}		
	}
}