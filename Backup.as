package
{
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.events.*;
  import flash.display.StageQuality;

  //[SWF(backgroundColor="#ffffff", frameRate="24", width="400", height="224")]
  [SWF(backgroundColor="#ffffff", frameRate="24", width="800", height="600")]
  public class Backup extends Sprite
  {   
    [Embed(source="cow.png")]
    private var Picture:Class;
    private var pic:Bitmap;
    private var Origin:Object;
    private var FocalLength:int;
    private var speed:int;
    private var pic_dir:int;
    private var pic_z:int;
    public function backAndForth(keyEvent:KeyboardEvent):void {
      // alter the z value based on speed in the direction
      // defined for pic clip
      pic_z += speed*pic_dir;
      // check for boundries, if hit, make sure the boundry
      // isnt passed and change direction
      if (pic_z > 500){
        pic_z = 500;
        pic_dir = -1; // moving forward now
      }else if (pic_z < 0){
          pic_z = 0;
          pic_dir = 1; // now moving back again
      }
      trace("keyboard click detected");
      // develop a scale ratio based on focal length and the
      // z value of pic movieclip.
      var scaleRatio:Number = FocalLength/(FocalLength + pic_z);
      // appropriately scale each x and y position based on the
      // location of the origin and the scale ratio
      trace("scaleRatio = " + scaleRatio)
      pic.x = Origin.x + pic.x * scaleRatio;
      trace("pic.x = " + pic.x)
      pic.y = Origin.y + pic.y * scaleRatio;
      trace("pic.y = " + pic.y)
      // similarly adjust the scale of the clip, but _xscale and
      // _yscale to be 100% times the scale ratio.
      pic.scaleX = pic.scaleY = 3.0 * scaleRatio;
      // lastly swap the depths of pic clip to match its position
      // back in space.  Because z increases as you go back, you
      // need to reverse its value when applied in swapDepths
      //pic.swapDepths(-pic.z);
    }
    
    public function myClick(eventObject:MouseEvent):void {
      trace("mouse click detected");
    }
    
    public function Backup():void
    {
      Origin = new Object();
      Origin.x = 15;
      Origin.y = 15;
      
      pic = new Picture();
      pic.width *= 4;
      pic.height *= 4;
      pic.x = stage.stageWidth / 2 - pic.width / 2;
      pic.y = stage.stageHeight / 2 - pic.height / 2;
      pic.smoothing = true;
      trace("pic.x = " + pic.x)
      trace("pic.y = " + pic.y)
      pic_z = 500; // far in the distance
      pic_dir = 1;
      // focal length to determine perspective scaling
      FocalLength = 300;

      // speed of movement for the figures
      speed = 20;
      stage.addEventListener(KeyboardEvent.KEY_DOWN, backAndForth);
      stage.addEventListener(MouseEvent.CLICK, myClick);
       
      addChild( pic );
    }
  }
}
