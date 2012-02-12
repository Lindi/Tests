package tests._3d
{
	import _3d.Camera;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import math.Matrix4x4;
	import math.Utils;
	
	import org.flexunit.Assert;
	
	
	public class CameraTest
	{
		
		
		[Test]
		public function clipping():void
		{
			//	Make a new camera
			var camera:Camera = new Camera();
			camera.position = new Vector3D( );
			camera.position.x = 0 ;
			camera.position.y = 0 ;
			camera.position.z = 0 ;
			camera.position.w = 1 ;
			camera.width = 400 ;
			camera.height = 400 ;
			camera.setPerspective( 65, camera.width/camera.height, 10, 200 ) ; 
			camera.getScreenTransformMatrix( 400, 400 ) ;
			
			
			//	If both points are outside the frustum
			//	it should return two null points
			var a:Vector3D, b:Vector3D ;
			var vector:Vector.<Vector3D> ;
			a = new Vector3D( ) ;
			b = new Vector3D( 0, 0, 300 ) ;
			vector = camera.clip( a, b ) ;
			Assert.assertTrue( vector[0] != null ) ;
			Assert.assertTrue( vector[1] != null ) ;
			Assert.assertTrue( Utils.AreEqual( vector[0].z, 10 ) ) ;
			Assert.assertTrue( Utils.AreEqual( vector[1].z, 200 ) ) ;
			
			//	If both points are inside the frustum, the
			//	clipper should return them
			a = new Vector3D( 0, 0, 10 ) ;
			b = new Vector3D( 0, 0, 200 ) ;
			vector = camera.clip( a, b ) ;
			Assert.assertTrue( vector[0] != null ) ;
			Assert.assertTrue( vector[1] != null ) ;
			Assert.assertTrue( Utils.AreEqual( vector[0].z, 10 ) ) ;
			Assert.assertTrue( Utils.AreEqual( vector[1].z, 200 ) ) ;
			Assert.assertEquals( a, vector[0] ) ;
			Assert.assertEquals( b, vector[1] ) ;
			
			//	TODO: Test two negative points
		}
		
		[Test]
		public function lookAt():void
		{
			//	Make a new camera
			var camera:Camera = new Camera();
			camera.position = new Vector3D( );
			camera.position.x = 0 ;
			camera.position.y = 0 ;
			camera.position.z = -100 ;
			camera.position.w = 1 ;
			camera.width = 400 ;
			camera.height = 400 ;
			camera.setPerspective( 65, camera.width/camera.height, 10, 200 ) ; 
			camera.getScreenTransformMatrix( 400, 400 ) ;
			
			
			//	If both points are outside the frustum
			//	it should return two null points
			var a:Vector3D, b:Vector3D ;
			a = new Vector3D( 0, 0, 200, 1 ) ;
			var worldToView:Matrix4x4 = camera.lookAt( a, Vector3D.Y_AXIS );
			b = worldToView.transform( a ) ;
			Assert.assertTrue( Utils.AreEqual( b.z, -300 ) ) ;
		}
	}
}