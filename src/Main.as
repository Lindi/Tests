package
{
	import flash.display.Sprite;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	import tests.geometry.BspTreeTest;
	import tests.physics.PolygonDistanceTest;
	import tests.physics.PolygonIntersectionTest;
	import tests.physics.lcp.LcpSolverTest;
	
	
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
			core.run( tests.physics.PolygonDistanceTest );
		}
	}
}