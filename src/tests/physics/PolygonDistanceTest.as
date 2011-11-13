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
			var polygon0:Polygon2d = createPolygon( new Vector2d());
			var polygon1:Polygon2d = createPolygon( new Vector2d());
			
			var M:Vector.<Vector.<Number>> = PolygonDistance.distance( polygon0, polygon1 );
			
			var n:int = ( M.length - 4 ) * 4;
			var m:int = int( n / 4 );
			var r:int, c:int ;
			var row:Vector.<Number> ;
			var value:Number ;
			
			//	Test that A and A-transpose were copied correctly
			for ( var i:int = 0; i < n; i++)
			{
				r = ( i / m ) ;
				c = ( i % m ) ;
				row = M[ r ] ;
				value = row[ c + 4 ] ;
				row = M[ c + 4 ] ;
				Assert.assertEquals( value, row[ 3 - r ] );
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