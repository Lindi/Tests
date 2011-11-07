package tests.physics.lcp
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.NullBuilder;
	
	import physics.lcp.LcpSolver;
	
	public class LcpSolverTest
	{
		
		[Test]
		public function lcpSolver():void
		{
			var Q:Vector.<Number> = new Vector.<Number>(3,true);
			Q[0] = -2 ;
			Q[1] = -1 ;
			Q[2] = 3 ;
			
			var M:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>( 3, true );
			M[0] = new Vector.<Number>( 3, true ) ;
			M[0][0] = 0 ;
			M[0][1] = 0 ;
			M[0][2] = 1 ;
			M[1] = new Vector.<Number>( 3, true ) ;
			M[1][0] = 0 ;
			M[1][1] = 0 ;
			M[1][2] = 1 ;
			M[2] = new Vector.<Number>( 3, true ) ;
			M[2][0] = -1 ;
			M[2][1] = -1 ;
			M[2][2] = 0 ;
			
			var result:Object = new Object();
			var lcp:LcpSolver = new LcpSolver( 3, M, Q, result ) ;
			Assert.assertEquals( result.status, LcpSolver.FOUND_SOLUTION );
		}		
	}
}