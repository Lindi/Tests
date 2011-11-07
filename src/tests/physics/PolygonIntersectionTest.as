package tests.physics
{
	import geometry.Polygon2d;
	import geometry.Vector2d;
	
	import org.flexunit.Assert;
	
	import physics.PolygonIntersection;

	public class PolygonIntersectionTest
	{
		[Test]
		public function PolygonsIntersect():void
		{
			//	Create a polygon a
			var a:Polygon2d = createPolygon( new Vector2d( 0, 0 ));

			//	Create a polygon b
			var b:Polygon2d = createPolygon( new Vector2d( 100, 100 ));
			
			//	Give polygon a a 'velocity'
			var u:Vector2d = new Vector2d( 1, 1 ) ;

			//	Give polygon b a 'velocity'
			var v:Vector2d = new Vector2d( -1, -1 ) ;
			
			//	Create variables to store the time interval
			var tmax:Number =  1/30;
			
			//	These polygons shouldn't intersect
			Assert.assertEquals( PolygonIntersection.PolygonsIntersect( a, b, u, v, tmax ), testIntersection( a, b ));
			

			//	Create a polygon a
			a = createPolygon( new Vector2d( 0, 0 ));
			
			//	Create a polygon b
			b = createPolygon( new Vector2d( 1, 1 ));
			
			//	Give polygon a a 'velocity'
			u = new Vector2d( 1, 1 ) ;
			
			//	Give polygon b a 'velocity'
			v = new Vector2d( -1, -1 ) ;
			
			//	Create variables to store the time interval
			tmax =  1/30;
			
			//	These polygons shouldn't intersect
			Assert.assertTrue( testIntersection( a, b ));
			Assert.assertTrue( PolygonIntersection.PolygonsIntersect( a, b, u, v, tmax ));
		}
		
		[Test]
		public function PassByReference():void
		{
			var value:Object = { value: 0 };
			foo( value ) ;
			Assert.assertEquals( value.value, 100 );
		}
		
		private function foo( value:Object ):void
		{
			value.value = 100 ;
		}
		
		/**
		 * Returns the extreme index of the polygon 
		 * @param polygon
		 * @return 
		 * 
		 */		
		private function getExtremeIndex( polygon:Polygon2d, direction:Vector2d ):int
		{
			var i:int, j:int = 0 ;
			while ( true ) 
			{
				var mid:int = getMiddleIndex( i, j, polygon.vertices.length );
				if ( polygon.getEdge( mid ).dot( direction ) > 0 )
				{
					if ( i != mid )
					{
						i = mid ;
					} else
					{
						return j ;
					}
				} else {
					if ( polygon.getEdge( mid-1 ).dot( direction ) < 0 )
					{
						j = mid ;
					} else {
						
						return mid ;
					}
				}
			}
			return 0 ;
		}
		
		/**
		 * Returns the index 'between' i and j 
		 * @param i
		 * @param j
		 * 
		 */		
		private function getMiddleIndex( i:int, j:int, n:int ):int
		{
			if ( i < j )
				return int( i + j ) / 2 ;
			return int(( i + j + n ) / 2 ) % n ;
		}

		/**
		 * Returns true if two polygons intersect, and false if not 
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		private function testIntersection( a:Polygon2d, b:Polygon2d ):Boolean
		{
			for ( var i:int = a.vertices.length-1, j:int = 0; j < a.vertices.length; i = j++ )
			{
				var p:Vector2d = a.getVertex( j ) ;
				var n:Vector2d = a.getNormal( i ) ;
				var index:int = Polygon2d.getExtremeIndex( b, n.Negate() );
				var q:Vector2d = b.vertices[index] ;
				if ( n.dot( q.Subtract( p )) > 0)
				{
					return false ;
				}
			}
			for ( i = b.vertices.length-1, j = 0; j < b.vertices.length; i = j++ )
			{
				p = b.getVertex( j ) ;
				n = b.getNormal( i ) ;
				index = Polygon2d.getExtremeIndex( a, n.Negate() );
				q = a.vertices[index] ;
				if ( n.dot( q.Subtract( p )) > 0)
				{
					return false ;
				}  
			}
			
			return true ;
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
			
			//	Create the polygon tree
			polygon.createTree();
			
			//	Return the polygon
			return polygon ;
			
		}
	}
}