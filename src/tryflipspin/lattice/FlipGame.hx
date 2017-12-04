package tryflipspin.lattice;
import nme.geom.Matrix;
import nme.display.BitmapData;
import tryflipspin.lattice.TriLattice;
class FlipGame {    
    private static var diaInt:          Int;
    private static var radInt:          Int;   
    public static var earthRotate:      Matrix;
    public static var seaRotate:        Matrix;
    public static var vertFlip:         Matrix;
    public static var vertEarth:        Matrix;
    public static var vertEarth2:       Matrix;
    public static var vertSea:          Matrix;
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
        vertSea .concat( seaRotate );
        
    }
    public function new() 
    {
        checkEnabled = false;
    }
    /*
    private function flip()
    {
        
        var pos: { x: Int, y: Int } = TriLattice.latticeCount[ Corners.count ];
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
   
    */
   /*
    private function swapMix()
    {
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
        var lat0            = untyped lattice[ y0 ][ x0 ];
        var lat1            = untyped lattice[ y1 ][ x1 ];
        var swap0         = lat0.imgSurface.clone();
        swap0              = swap0.transform( mat );
        var swap1         = lat1.imgSurface.clone();
        swap1              = swap1.transform( mat );
        lat0.imgSurface = swap1;
        lat1.imgSurface = swap0;
        lat0.drawTri();
        lat1.drawTri();
        var count0 = lat0.currentCount;
        var count1 = lat1.currentCount;
        lat0.currentCount = count1;
        lat1.currentCount = count0;
        checkCount();
    }
    */
    public static var checkEnabled: Bool;
    /*
    public function checkCount() 
    {
        var good = true;
        if ( checkEnabled == true )
        {
            for ( i in TriLattice.latticeCount )
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
    */
    
}