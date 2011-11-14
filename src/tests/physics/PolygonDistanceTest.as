package tests.physics
{
	import geometry.Polygon2d;
	import geometry.Vector2d;
	
	import org.flexunit.Assert;
	
	import physics.PolygonDistance;

	public class PolygonDistanceTest
	{
		[Test]
		public function distance():void
		{
			var polygon0:Polygon2d = new Polygon2d();
			polygon0.addVertex( new Vector2d( 1, 2 ));
			polygon0.addVertex( new Vector2d( 3, 1 ));
			polygon0.addVertex( new Vector2d( 2, 3 ));
			polygon0.orderVertices();
			polygon0.updateLines();
				
			var polygon1:Polygon2d = new Polygon2d();
			polygon1.addVertex( new Vector2d( 2, 5 ));
			polygon1.addVertex( new Vector2d( 3, 7 ));
			polygon1.addVertex( new Vector2d( 1, 6 ));
			polygon1.orderVertices();
			polygon1.updateLines();
			
			var solution:Object = PolygonDistance.distance( polygon0, polygon1 );
			var M:Vector.<Vector.<Number>> = ( solution.M as Vector.<Vector.<Number>> );
			
			var n:int = ( M.length - 4 ) * 4;
			var m:int = int( n / 4 );
			var r:int, c:int ;
			var row:Vector.<Number> ;
			var value:Number ;
			
			for ( var i:int = 0; i < 16; i++ )
			{
				r = ( i / 4 );
				c = ( i % 4 );
				row = M[r] ;
				
				//	If the sum of the row and column indices is even
				//	the value should be 1, otherwise zero (checkerboard)
				if ( ( r + c ) % 2 > 0 )
					Assert.assertTrue( row[c] == 0 );
				else Assert.assertTrue( row[c] != 0 );
				
				//	If the quadrant of the row and column
				//	is not divisible by 3, multiply -1
				m = int( Math.floor( r / 2 ) + Math.floor( c / 2 ));
				if ( ( m % 3 ) % 2 > 0 )
					Assert.assertTrue( row[c] <= 0 );
				else Assert.assertTrue( row[c] >= 0 );
				
			}
			//	Test that A and A-transpose were copied correctly
			m = int( n / 4 );
			for ( i = 0; i < n; i++)
			{
				r = ( i % m ) ;
				c = ( i / m ) ;
				row = M[ c ] ;
				value = row[ r + 4 ] ;
				row = M[ r + 4 ] ;
				Assert.assertEquals( -value, row[ c ] );
			}
			
			//	Test that the 4th 'quadrant' of the matrix is all zero
			n = m * m ;
			for ( i = 0; i < n; i++ )
			{
				r = ( i / m );
				c = ( i % m );
				row = M[ r + 4 ] ;
				Assert.assertEquals( row[ c + 4 ], 0 );
			}
		}
		
		/**
		 * Creates a polygon with a number of vertices between
		 * 3 and 6 ; 
		 * 
		 */		
		private function createPolygon( centroid:Vector2d ):Polygon2d
		{
			
			//	Create a polygon
			var polygon:Polygon2d = new Polygon2d( );
			
			//	The polygon should have at least 3 and at most six points
			var points:int = 3 + int( Math.random() * 3 );
			
			//	Add points to the polygon
			var angle:Number = ( Math.PI / 180 ) * ( 360 / points ) ;
			var scale:Number = 40 ;
			for ( var i:int = 0; i < points; i++ )
			{
				var alpha:Number = angle * i ;
				var x:Number = Math.cos( alpha ) - Math.sin( alpha ) ;
				var y:Number = Math.sin( alpha ) + Math.cos( alpha ) ; 
				polygon.addVertex( new Vector2d(( x * scale ) + centroid.x, ( y * scale ) + centroid.y ));
			}
			
			//	Order the polygon vertices counter-clockwise
			polygon.orderVertices();
			
			//	Create the collection of polygon edges
			polygon.updateLines();
			
			//	Create the tree used to determine the extreme vertices
			polygon.createTree();
			
			//	Return the polygon
			return polygon ;
			
		}

	}
}