package tryflipspin;
import nme.display.Sprite;
import nme.display.Shape;
import nme.geom.Matrix;
import nme.display.GradientType;
import nme.display.Bitmap;
class BlueBgGrad extends Sprite {
    public var scenery: Sprite;
    public function new(  w: Int, h: Int ) {
        super();
        var bg: Shape = new Shape();
        var matrix:Matrix=new Matrix();
        matrix.createGradientBox( w, h, -Math.PI/2 );
        bg.graphics.beginGradientFill(GradientType.LINEAR,[0x1584DE,0xFF],[100,100],[0x33,0xff],matrix);
        bg.graphics.drawRect(0,0,w,h);
        bg.graphics.endFill();
        addChild( bg ); 
    }
}