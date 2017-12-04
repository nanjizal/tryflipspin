package tryflipspin.lattice;
import flash.display.Sprite;
import flash.display.Graphics;
import tryflipspin.lattice.TriLattice;
import tryflipspin.DispatchTo;
import nme.events.MouseEvent;
import nme.events.Event;
typedef Zone = {
    var a: Position;
    var b: Position;
    var c: Position;
}
class Corners {
    public static var sp:                   Sprite;
    private var s0:                         Sprite;
    private var s1:                         Sprite;
    private var s2:                         Sprite;
    private var _count:                     Int;
    private var _updown:                    UpDown;
    public static var     flip:             DispatchTo   = new DispatchTo();
    public static var     count:            Int;
    public static var     color:            RGB;
    public static var     updown:           UpDown;
    public function new( p0: Position
                                , p1: Position
                                , p2: Position
                                , count_: Int
                                , updown_:UpDown 
                                ){
            var _count = count_;
            var _updown = updown_;
            var p01 = midPoint( p0, p1 );
            var p12 = midPoint( p1, p2 );
            var p20 = midPoint( p2, p0 );
            s0 = createZone( { a:clone(p0), b:clone(p01), c:clone(p20) }, 0xff0000, 0.4 );
            s1 = createZone( { a:clone(p1), b:clone(p12), c:clone(p01) }, 0x00ff00, 0.4 );
            s2 = createZone( { a:clone(p2), b:clone(p20), c:clone(p12) }, 0x0000ff, 0.4 );
            var counta = _count;
            var updowna = _updown;
            s0.addEventListener( MouseEvent.CLICK, function( e: Event ) {       Corners.count = counta; 
                                                                                                        Corners.color = Red;  
                                                                                                        Corners.updown = updowna;
                                                                                                        Corners.flip.dispatch(); } );
            s1.addEventListener( MouseEvent.CLICK, function( e: Event ) {       Corners.count = counta; 
                                                                                                        Corners.color = Green; 
                                                                                                        Corners.updown = updowna;
                                                                                                        Corners.flip.dispatch(); } );
            s2.addEventListener( MouseEvent.CLICK, function( e: Event ) {       Corners.count = counta; 
                                                                                                        Corners.color = Blue; 
                                                                                                        Corners.updown = updowna;
                                                                                                        Corners.flip.dispatch(); } );
        s0.alpha = 0.;
        s1.alpha = 0.;
        s2.alpha = 0.;
    }
    private function createZone( zone: Zone, col: Int, alp: Float ): Sprite {
            var mc:   Sprite = new Sprite();
            var a = zone.a;
            var b = zone.b;
            var c = zone.c;
            var mx = Math.min( Math.min( a.x, b.x ), c.x );
            var my = Math.min( Math.min( a.y, b.y ), c.y );
            mc.x = mx;
            mc.y = my;
            var g: Graphics= mc.graphics;
            g.lineStyle( 0, col, 0 );
            g.beginFill( col, alp );
            g.moveTo( a.x - mx, a.y - my );
            g.lineTo( b.x - mx, b.y - my );
            g.lineTo( c.x - mx, c.y - my );
            g.lineTo( a.x - mx, a.y - my );
            sp.addChild( mc );
            return mc;
    }
    private function clone( p: Position ): Position {
            return { x: p.x, y: p.y };
    }
    
    private function midPoint( pA: Position, pB: Position ): Position {
            return { x: ( pA.x + pB.x ) / 2, y: ( pA.y + pB.y )/2 };
    }
}