package tryflipspin;
import tryflipspin.BlueBgGrad;
import nme.Assets;
import tryflipspin.lattice.TriLattice;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
class Main extends Sprite {
    public function new() {
        super();
        #if iphone
        Lib.current.stage.addEventListener(Event.RESIZE, init);
        #else
        addEventListener(Event.ADDED_TO_STAGE, init);
        #end
    }
    private function init(e) {
        var bm = new Bitmap( Assets.getBitmapData( 'img/tablecloth.jpg' ) );
        addChild( new BlueBgGrad( stage.stageWidth, stage.stageHeight ) );
        var surface = new Sprite();
        addChild( surface );
        surface.scaleX = 7;
        surface.scaleY = 7;
        new TriLattice( surface, bm, 20, 8, 35 );
    }
    static public function main() {
        var stage = Lib.current.stage;
        stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
        stage.align = nme.display.StageAlign.TOP_LEFT;
        Lib.current.addChild(new Main());
    }
}
