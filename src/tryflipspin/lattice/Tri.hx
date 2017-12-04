package tryflipspin.lattice;
import tryflipspin.lattice.Corners;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.display.BitmapData;
import nme.geom.Matrix;
using tryflipspin.lattice.TriLattice;
using nme.Vector;
class Tri {   
    public static var radius:             Float;
    public static var radiusSmall:        Float;
    public static var sideLenBy2:         Float;
    public static var surface:            Graphics;
    public static var sp:                 Sprite;
    private var position:                 Position;
    public var mat:                       Matrix;
    public var imgOrig:                   BitmapData;
    public var imgSurface:	              BitmapData;
    public var count:                     Int;
    public var currentCount:              Int;
    private var updown:                   UpDown;
    private var corners:                  Corners;
    public function new (  position_: 	        Position
                                 ,  imgSurface_:   	BitmapData 
                                 ,  surface_:           Graphics
                                 ,  updown_:           UpDown
                                 ,  count_:              Int ) {
        position        = position_;
        imgSurface      = imgSurface_;
        surface         = surface_;
        updown          = updown_;
        count           = currentCount = count_;
    }
    
    public function drawTri(){
        
        surface.lineStyle( 0, 0x0000ee, 1);
        
        // [  a   c  tx  ]
        // [  b   d  ty  ]
        // [  u   v   w  ]
        // (a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0)
            
        var dx = position.x + radius;
        var dy = position.y + radius;
        
        var mat=  new Matrix( 1, 0, 0, 1 ); 
        /*if( !even )*/
        switch( updown )
        { 
            case Up:
                
                var difY = radius - radiusSmall;
                dy = dy - difY;
                mat.translate(  position.x,  position.y - difY );
                surface.beginBitmapFill ( imgSurface, mat, false, true );
                /*
                surface.drawPath(    Vector.ofArray([ 1, 2, 2, 2 ]) 
                                           ,    Vector.ofArray([   dx,                       dy + radius
                                                                        ,   dx - sideLenBy2,   dy - radiusSmall 
                                                                        ,   dx + sideLenBy2,  dy - radiusSmall
                                                                        ,   dx,                       dy + radius
                                                                        ])
                                                 
                                            );
                */
                surface.moveTo( dx,                   dy + radius );
                surface.lineTo( dx - sideLenBy2,   dy - radiusSmall  );
                surface.lineTo( dx + sideLenBy2,  dy - radiusSmall  ); 
                surface.lineTo( dx,                     dy + radius);
                
                if ( corners == null )
                {
                    corners = new Corners( { x: dx, y: dy + radius }, { x: dx - sideLenBy2, y: dy - radiusSmall   }, { x: dx + sideLenBy2, y: dy - radiusSmall  }, count, updown );
                }
            case Down:
                
                mat.translate(  position.x,  position.y  ); 
                surface.beginBitmapFill ( imgSurface, mat , false, true );

                //surface.drawCircle( dx, dy, radius ); 
                surface.moveTo( dx,                     dy - radius );
                surface.lineTo( dx + sideLenBy2 ,   dy+ radiusSmall  ); 
                surface.lineTo( dx - sideLenBy2 ,   dy + radiusSmall  );
                surface.lineTo( dx,                      dy - radius );
                if ( corners == null )
                {
                    new Corners( { x: dx, y: dy - radius }, { x: dx + sideLenBy2 , y: dy + radiusSmall  }, { x: dx - sideLenBy2 , y: dy + radiusSmall  }, count, updown );
                }
        }
        surface.endFill();
    }
    
    
}