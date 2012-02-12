package tests.geometry
{
	import flash.geom.Vector3D;
	
	import geometry.Quaternion;
	
	import math.Utils;
	
	import org.flexunit.Assert;
	
	public class QuaternionTest
	{
		
		[Test]
		public function inverse():void
		{
			var quaternion:Quaternion = new Quaternion( );
			var inverse:Quaternion = quaternion.Inverse();
			Assert.assertTrue( inverse != null ) ;
			Assert.assertTrue( inverse != quaternion ) ;
			var identity:Quaternion = quaternion.multiply( inverse );
			Assert.assertEquals( identity.w, 1 ) ;
			Assert.assertEquals( identity.x, 0 ) ;
			Assert.assertEquals( identity.y, 0 ) ;
			Assert.assertEquals( identity.z, 0 ) ;
		}
		
		[Test]
		public function vectorRotation():void
		{
			var quaternion:Quaternion = new Quaternion( );
			
			//	Be careful here.  The arguments of the Vector3D constructor
			//	are x, y, z, w.  The arguments of the Quaternion constructor
			//	are w, x, y, z
			quaternion.SetAxisAngle( new Vector3D( 0, 0, 1, 0 ), Math.PI / 2 );
			var vector:Quaternion = new Quaternion( 0, 1, 0, 0 );
			var inverse:Quaternion = quaternion.Inverse();
			Assert.assertTrue( inverse != null ) ;
			Assert.assertTrue( inverse != quaternion ) ;
			var product:Quaternion = vector.Multiply( inverse ) ;
			product = quaternion.Multiply( product ) ;
			Assert.assertTrue( Utils.IsZero( product.w )) ;
			Assert.assertTrue( Utils.IsZero( product.x )) ;
			Assert.assertTrue( Utils.IsZero( 1 - product.y )) ;
			Assert.assertTrue( Utils.IsZero( product.z )) ;
		}

	
		[Test]
		public function slerp():void
		{
			var from:Quaternion = new Quaternion();
			from.SetAxisAngle( new Vector3D( 0, 0, 1, 0 ), 0 );
			Assert.assertTrue( Utils.IsZero( 1 - from.length() )) ;
			var to:Quaternion = new Quaternion();
			to.SetAxisAngle( new Vector3D( 0, 0, 1, 0 ), Math.PI / 2 );
			Assert.assertTrue( Utils.IsZero( 1 - to.length() )) ;
			var quaternion:Quaternion = Quaternion.Slerp( from, to, .5 );
			var vector:Quaternion = new Quaternion( 0, 1, 0, 0 );
			var inverse:Quaternion = quaternion.Inverse();
			Assert.assertTrue( inverse != null ) ;
			Assert.assertTrue( inverse != quaternion ) ;
			var product:Quaternion = vector.Multiply( inverse ) ;
			product = quaternion.Multiply( product ) ;
			var n:Number = Math.SQRT2/2 ;
			Assert.assertTrue( Utils.IsZero( product.w )) ;
			Assert.assertTrue( Utils.IsZero( n - product.x )) ;
			Assert.assertTrue( Utils.IsZero( n - product.y )) ;
			Assert.assertTrue( Utils.IsZero( product.z )) ;
		}
	}
}