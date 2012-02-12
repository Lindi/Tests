package tests.geometry
{
	public class CameraTest
	{
		import geometry.BspNode;
		import geometry.Polygon2d;
		import geometry.Vector2d;
		
		import org.flexunit.Assert;
		

		[Test]
		public function CreateNode():void
		{
			//	Create a polygon
			var polygon:Polygon2d;
			for ( var j:int = 0; j < 10; j++ )
			{
				polygon = createPolygon( new Vector2d());
				Assert.assertTrue( polygon != null ) ;
				
				//	Get the extreme vertex in the direction
				//	of each normal.  The index returned by the getExtremeVertex
				//	method should be the same as the normal index
				for ( var i:int = 0; i < polygon.normals.length; i++ )
				{
					var index:int = Polygon2d.getExtremeIndex( polygon, polygon.normals[i] );
					var a:Number = polygon.getEdge( index - 1 ).dot( polygon.getNormal(i) );
					var b:Number = polygon.getEdge( index ).dot( polygon.getNormal(i) );
					Assert.assertTrue( a * b <= 0 );
				}
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
			
			//	Create the polygon tree
			polygon.createTree();
			
			//	Return the polygon
			return polygon ;
			
		}
	}
}