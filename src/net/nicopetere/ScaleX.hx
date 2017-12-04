package net.nicopetere;

	/**
	 * @author nicoptere
         * please check his github, I am unsure on the licence it may not be covered by MIT.
	 */
	import flash.display.BitmapData;
    
 class ScaleX 
{
	
	static public function scale2x( bd:BitmapData ):BitmapData
	{
		var dest:BitmapData = new BitmapData( bd.width*2, bd.height*2, true );
			
			var E: Int;
			var E0: Int;
			var E1: Int;
			var E2: Int;
			var E3: Int;
			
			var B: Int;
			var D: Int;
			var F: Int;
			var H: Int;
			
			var i:Int;
			var j:Int;
			var i2:Int;
			var j2:Int;
			
			var w:Int = bd.width;
			var h: Int= bd.height;
			bd.lock();
			dest.lock();
			for ( i in 0...w )
			{
				for ( j in 0...h )
				{
					
					E = bd.getPixel32( i, j );
					
					//on est sur un bord
					if( i==0 || j==0 || i == w-1 || j == h-1 )
					{
						
						E0 = E;
						E1 = E;
						E2 = E;
						E3 = E;
						
					}else{
					
						B = bd.getPixel32( i, j-1 );
						D = bd.getPixel32( i-1, j );
						F = bd.getPixel32( i+1, j );
						H = bd.getPixel32( i, j+1 );
						
						if (B != H && D != F ) 
						{
							
							E0 = ( D == B ) ? D : E;
							E1 = ( B == F ) ? F : E;
							E2 = ( D == H ) ? D : E;
							E3 = ( H == F ) ? F : E;
							
						}else{
							
							E0 = E;
							E1 = E;
							E2 = E;
							E3 = E;
							
						}
					}
					
					i2 = i*2;
					j2 = j*2;
					dest.setPixel32(   i2,   j2, E0 );
					dest.setPixel32( i2+1,   j2, E1 );
					dest.setPixel32(   i2, j2+1, E2 );
					dest.setPixel32( i2+1, j2+1, E3 );
					
				}
			}
			bd.lock();
			dest.unlock();
			return dest;
		}
		
		static public function scale3x( bd:BitmapData ):BitmapData
		{
			var dest:BitmapData = new BitmapData( bd.width*3, bd.height*3, true );
			
			var E:Int;
			
			var E0:Int;
			var E1:Int;
			var E2:Int;
			var E3:Int;
			var E4:Int;
			var E5:Int;
			var E6:Int;
			var E7:Int;
			var E8:Int;
			
			var A:Int;
			var B:Int;
			var C:Int;
			var D:Int;
			var F:Int;
			var G:Int;
			var H:Int;
			var I: Int;
			
			var i: Int;
			var j: Int;
			
			var i3:Int;
			var j3: Int;
			
			var w: Int = bd.width;
			var h: Int = bd.height;
			
			bd.lock();
			dest.lock();
			for ( i in 0...w )
			{
				for ( j in 0...h )
				{
		
					E = bd.getPixel32( i, j );
					
					//on est sur un bord
					if( i==0 || j==0 || i == w-1 || j == h-1 )
					{
						
						E0 = E;
						E1 = E;
						E2 = E;
						E3 = E;
						E4 = E;
						E5 = E;
						E6 = E;
						E7 = E;
						E8 = E;
						
					}else{

						A = bd.getPixel32( i-1, j-1 );
						B = bd.getPixel32(   i, j-1 );
						C = bd.getPixel32(   i, j+1 );
						D = bd.getPixel32( i-1, j );
						F = bd.getPixel32( i+1, j );
						G = bd.getPixel32( i-1, j+1 );
						H = bd.getPixel32(   i, j+1 );
						I = bd.getPixel32( i+1, j+1 );
						
						if ( B != H && D != F ) 
						{
							
							E0 = ( D == B ) ? D : E;
							E1 = ( ( D == B && E != C ) || ( B == F && E != A ) ) ? B : E;
							E2 = ( B == F )? F : E;
							E3 = ( ( D == B && E != G ) || ( D == H && E != A ) ) ? D : E;
							E4 = E;
							E5 = ( ( B == F && E != I ) || ( H == F && E != C ) ) ? F : E;
							E6 = ( D == H ) ? D : E;
							E7 = ( ( D == H && E != I ) || ( H == F && E != G ) ) ? H : E;
							E8 = ( H == F ) ? F : E;
							
						} else {
							
							E0 = E;
							E1 = E;
							E2 = E;
							E3 = E;
							E4 = E;
							E5 = E;
							E6 = E;
							E7 = E;
							E8 = E;
						
						}
					}
					i3 = i*3;
					j3 = j*3;
					
					dest.setPixel32(   i3, j3, E0 );
					dest.setPixel32( i3+1, j3, E1 );
					dest.setPixel32( i3+2, j3, E2 );
					
					dest.setPixel32(   i3, j3+1, E3 );
					dest.setPixel32( i3+1, j3+1, E4 );
					dest.setPixel32( i3+2, j3+1, E5 );
					
					dest.setPixel32(   i3, j3+2, E6 );
					dest.setPixel32( i3+1, j3+2, E7 );
					dest.setPixel32( i3+2, j3+2, E8 );
					
				}
			}
			bd.unlock();
			dest.unlock();
			return dest;
		}
	}

