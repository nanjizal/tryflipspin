package tryflipspin.lattice;
import tryflipspin.lattice.Tri;
import tryflipspin.lattice.Corners;
import net.nicopetere.ScaleX;
import nme.display.PixelSnapping;
import nme.events.Event;
import nme.geom.Matrix;
import flash.display.Graphics;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.geom.Point;
import nme.geom.Rectangle;
import tryflipspin.DispatchTo;
import nme.events.MouseEvent;
import nme.Vector;
using tryflipspin.lattice.TriLattice;
enum Triquetra {	
	Earth;	    // South West
	Sky; 		// North 
	Sea; 		// South East
} 
enum RGB {	
	Red;	
	Green; 
	Blue; 		
}
enum Orientation {
    Horizontal;
    Vertical;
}
typedef Position = {
    var x: Float;
    var y: Float;
}
enum UpDown {
    Up;
    Down;
}
class TriLattice {
    private var sideLen:            Float;
    private var hi:                 Float;
    private var pieceWide:          Int;
    private var pieceHi:            Int;
    private var lattice:            Array<Array<Tri>>;
    public static var radius:       Float;
    private static var diaInt:      Int;
    private static var radInt:      Int;
    private var dia:                Float;
    private var radiusSmall:        Float;
    private var holder:             Sprite;
    private var bmSrc:              Bitmap;
    public static var latticeCount: Array<{ x: Int, y: Int}>;
    public function new(    holder_:          Sprite
                        ,   bmSrc_:           Bitmap                            
                        ,   pieceWide_:     Int
                        ,   pieceHi_:         Int
                        ,   sideLen_:         Float
                        ) {
        //var flipGame = new FlipGame();
        var temp = holder_;
        holder      = new Sprite();
        temp.addChild( holder );
        bmSrc       = bmSrc_;
        pieceWide = pieceWide_;
        pieceHi     = pieceHi_;
        sideLen     = sideLen_;
        latticeCount = new Array();
        //
        Corners.flip.add( flip );
        
        var srcSurface = new Sprite();
        srcSurface.addChild( bmSrc );
        holder.parent.addChild( srcSurface );
        holder.parent.swapChildren( holder, srcSurface );
        // sine rule used to calculate radius
        // 60 degrees = Math.PI / 3 
        // sideLen / Math.sin( Math.PI / 3 ) = radius / Math.sin( Math.PI / 6 );
        radius = sideLen * Math.sin( Math.PI / 6 ) / Math.sin( Math.PI / 3 );
        dia = radius * 2;
        var sideLenBy2 = sideLen / 2;
        // trig to calculate the distance from centre to middle of edge.
        //  o/a = tan( theta ) , a = sideLen/2 , theta is 60/2
        radiusSmall = ( sideLen / 2) * Math.tan( Math.PI / 6 );
        
        hi = radius + radiusSmall;
        // for rotation we need the bitmap to be enclose the radius
        
        Tri.radius            = radius;
        Tri.sideLenBy2     = sideLenBy2;
        Tri.radiusSmall     = radiusSmall;
        Tri.sp                 = Corners.sp = holder;
        lattice                = new Array<Array<Tri>>();
        var difY               = radius - radiusSmall;
        var count           = 0;
        createTransforms();
         
        for ( j in 0...pieceHi )
        {
            
            lattice[ j ] = new Array<Tri>();
            var evenLayer = ( j & 1 == 0 );
            for ( i in 0...pieceWide )
            {
                
                latticeCount.push( { x: i, y: j } );
                var even =  ( i & 1 == 0 );
                if ( evenLayer )  even = !even ;
               
                var arr = Type.allEnums( Triquetra );
                var rnd = arr[ Math.round( Math.random() * (arr.length-1) ) ];
                var tri = new Tri(     if ( even ) { x: i * sideLenBy2 , y: j * hi   } else  { x: i * sideLenBy2 , y: j * hi   } 
                                        ,   new BitmapData( Std.int( dia ), Std.int( dia ), false, #if(flash) 0xff000000 #else BitmapData.createColor( 0xff, 0x000000 ) #end )
                                        ,   holder.graphics 
                                        ,   if ( even ) Down else Up
                                        ,   count++
                                        /*,   threeD*/
                                        );
                
                var subArea:Rectangle = new Rectangle( 0, 0, dia, dia );
                
                if ( even )
                {
                    tri.imgSurface.draw( bmSrc.bitmapData, new Matrix( 1, 0, 0, 1, -( i * sideLenBy2 ) , -(j * hi )  ) , null, null, subArea, true );// rec, point , bmSrc.bitmapData, point, false ) ;
                    tri.imgOrig = tri.imgSurface.clone();
                }
                else
                {
                   tri.imgSurface.draw( bmSrc.bitmapData, new Matrix( 1, 0, 0, 1, -( i * sideLenBy2 ) , - ( j * hi - difY )  ) , null, null, subArea, true );
                   tri.imgOrig = tri.imgSurface.clone();
                }
                tri.mat = new Matrix();
                tri.drawTri();
                            
                lattice[ j ].push( tri );
                
            }
                  
        }
       swapMix();
       
      }
    public static var earthRotate:  Matrix;
    public static var seaRotate:     Matrix;
    public static var vertFlip:         Matrix;
    public static var vertEarth:      Matrix;
    public static var vertEarth2:     Matrix;
    public static var vertSea:         Matrix;
    public static function transform(   bd:             BitmapData
                                    ,   ?mat:           Matrix
                                    ):  BitmapData {
        var flipped  = new BitmapData( diaInt , diaInt,true, 0 );
        flipped.draw( bd, mat, null, null, null, true );
        return flipped;
    }
    public static function createTransforms()
    {
        diaInt = Std.int( TriLattice.radius * 2 );
        radInt = Std.int( TriLattice.radius );
        vertFlip  = new Matrix(  1, 0, 0, -1, 0,  diaInt );
        seaRotate = new Matrix( 1, 0, 0, 1, -radInt, -radInt );
        seaRotate.rotate( 2*Math.PI/3 );
        seaRotate.translate( radInt, radInt );
        earthRotate = new Matrix( 1, 0, 0, 1, -radInt, -radInt );
        earthRotate.rotate( 2*2*Math.PI/3 );
        earthRotate.translate( radInt, radInt );
        vertEarth = vertFlip.clone();
        vertEarth.concat( earthRotate );
        vertEarth2 = vertEarth.clone();
        vertEarth2.concat( vertFlip );
        vertEarth2.concat( earthRotate );
        vertSea = vertFlip.clone();
        vertSea.concat( seaRotate );
    }
    private function flip(){
        var pos: { x: Int, y: Int } = latticeCount[ Corners.count];
        //trace( pos.x + ' ' + pos.y );
        //trace( Corners.color );
        if ( Corners.color == Red )
        {
            if ( Corners.updown == Up )
            {
                if (!(pos.y - 1 < 0) )
                {
                    swap( pos.x, pos.y- 1, pos.x, pos.y  );
                }
            }
            else
            {
                if( pos.y+1 < pieceHi )
                {
                    swap( pos.x, pos.y, pos.x, pos.y + 1 );
                }
            }
        } 
        else
        {
            if ( Corners.updown == Up )
            {
                if ( Corners.color == Green )
                {
                    if ( pos.x + 1 < pieceWide )
                    {
                        swap( pos.x, pos.y, pos.x+1, pos.y );
                    }
                }
                else
                {
                    if ( !(pos.x - 1 < 0) )
                    {
                        swap( pos.x-1, pos.y, pos.x, pos.y );
                    }
                }
            }
            else if ( Corners.updown == Down )
            {
                if ( Corners.color == Blue )
                {
                    if ( pos.x + 1 < pieceWide )
                    {
                        swap( pos.x, pos.y, pos.x+1, pos.y );
                    }
                }
                else
                {
                    if ( !( pos.x - 1 < 0 ))
                    {
                        swap( pos.x-1, pos.y, pos.x, pos.y );
                    }
                }
            }
        }
        
    }
    private function swapMix(){
      checkEnabled = false;
       var tot = ( pieceWide * pieceHi );
       var allCol =  Type.allEnums( RGB );
       var allUpdown = Type.allEnums( UpDown );
       
       for ( i in 0...100 )//( Std.int( tot/2.2 )) )
       {
           
           Corners.color = allCol[ Std.int( Math.random() * 2 ) ];
           Corners.count = Std.int( (tot - 1) * Math.random() );
           Corners.updown = allUpdown[ Std.int( Math.random() ) ];
           Corners.flip.dispatch();
           
       }
        checkEnabled = true;
    }
     
    private function swap( x0: Int, y0: Int, x1: Int, y1: Int )
    {
        var mat: Matrix; 
        if ( y0 == y1 )
        {
            // horizontal
            var even = ( y0 & 1 == 0 );
            if( Std.int( Math.max( x0, x1 ) ) & 1 == 0 )  even = !even;
            mat = if ( even ) vertEarth else vertSea;
        }
        else
        {
            // vertical
            mat = vertFlip;
        }
        var lat0          = lattice[ y0 ][ x0 ];
        var lat1          = lattice[ y1 ][ x1 ];
        var orig0         = lat0.imgOrig;
        var swap0         = lat0.imgSurface.clone();
        swap0             = swap0.transform( mat );
        var orig1         = lat1.imgOrig;
        var swap1         = lat1.imgSurface.clone();
        swap1             = swap1.transform( mat );
        lat0.imgOrig      = orig1;
        lat1.imgOrig      = orig0;

        lat0.mat.concat( mat );
        lat1.mat.concat( mat );
        lat0.imgSurface = swap1;// .transform( lat0.mat );
        lat1.imgSurface = swap0;// .transform( lat1.mat );
        lat0.drawTri();
        lat1.drawTri();

        var count0 = lat0.currentCount;
        var count1 = lat1.currentCount;
        lat0.currentCount = count1;
        lat1.currentCount = count0;
        checkCount();
    }
    public static var checkEnabled: Bool;
    public function checkCount() 
    {
        var good = true;
        if ( checkEnabled == true )
        {
            for ( i in latticeCount )
            {
                var lat = lattice[ i.y ][ i.x ];
                if ( !( lat.count == lat.currentCount) )
                {
                    good = false;
                }
            }
            if ( good ) holder.visible = false;
        }
    }

}

