package
{
	import com.bensilvis.spriteSheet.SpriteSheet;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	// Swf Metadata
	[SWF(width="522", height="602", frameRate="60", backgroundColor="#FFFFFF")]
	
	public class Program extends Sprite
	{
		private var currentSprite:SpriteSheet;
		
		[Embed(source='../assets/previewenv.png')]
		private var sheetClass:Class;
		private var sheet:Bitmap = new sheetClass();
		
		public function Program()
		{	
			//Create background gradient
			var colors:Array = [ 0xEAF3FA, 0x7BBFD8 ];
			var alphas:Array = [ 1, 1 ];
			var ratios:Array = [ 0, 255 ];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, (Math.PI / 2), 0, 0);
			var gradient:Sprite = new Sprite();
			gradient.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			gradient.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(gradient);
			
			//Add sprite sheet button mat
			var buttonMat:ButtonMat = new ButtonMat(sheet);
			buttonMat.x = (stage.stageWidth / 2) - (buttonMat.width / 2); //Centers the image horizontally
			buttonMat.y = (stage.stageHeight - buttonMat.height) - 5;
			addChild(buttonMat);
			buttonMat.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			//Instantiate SpriteSheet class
			currentSprite = new SpriteSheet(sheet, 32, 32);
			currentSprite.scaleX = 4;
			currentSprite.scaleY = 4;
			currentSprite.x = (stage.stageWidth / 2) - (currentSprite.width / 2);
			currentSprite.y = 5;
			addChild(currentSprite);
		}
		
		/**
		 * Redraw extracted Sprite based on the zone clicked on ButtonMap
		 */
		private function onMouseClick(e:MouseEvent):void
		{
			var spriteZone:int = e.currentTarget.checkZone();
			trace(spriteZone);
			currentSprite.drawTile(spriteZone);
		}
	}
}