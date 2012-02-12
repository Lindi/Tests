package
{
	import flash.display.Sprite;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	import tests._3d.CameraTest ;
	import tests.physics.PolygonDistanceTest;
	import tests.physics.PolygonIntersectionTest;
	import tests.physics.lcp.LcpSolverTest;
	import tests.geometry.QuaternionTest ;
	
	
	public class Main extends Sprite
	{
		private var core:FlexUnitCore;
		private var listener:TraceListener ;
		
		public function Main()
		{
			core = new FlexUnitCore();
			listener = new TraceListener();
			core.addListener( listener );
			//core.run( tests.geometry.BspTreeTest );
			//core.run( tests.physics.PolygonIntersectionTest );
			//core.run( tests.physics.lcp.LcpSolverTest );
			//core.run( tests.geometry.QuaternionTest );
			core.run( tests._3d.CameraTest );
		}
	}
}