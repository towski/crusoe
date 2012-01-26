package
{
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;

  [SWF(backgroundColor="#ffffff", frameRate="24", width="400", height="224")]
  public class HelloFlash extends Sprite
  {
    public function HelloFlash():void
    {
      var textfield : TextField = new TextField();

      textfield.text = "Hello Flash!!";
      textfield.autoSize = TextFieldAutoSize.LEFT;
      textfield.setTextFormat(new TextFormat(null,48));
      textfield.x = stage.stageWidth / 2 - textfield.width / 2;
      textfield.y = stage.stageHeight / 2 - textfield.height / 2;

      addChild( textfield );
    }
  }
}