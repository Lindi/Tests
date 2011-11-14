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
			
			Q = new Vector.<Number>( 5, true ) ;
			Q[0] = -1 ;
			Q[1] = -1 ;
			Q[2] = 2 ;
			Q[3] = -1 ;
			Q[4] = 3 ;
			
			M = new Vector.<Vector.<Number>>( 5, true );
			M[0] = new Vector.<Number>( 5, true ) ;
			M[0][0] = 0 ;
			M[0][1] = 0 ;
			M[0][2] = -1 ;
			M[0][3] = 2 ;
			M[0][4] = 3 ;
			M[1] = new Vector.<Number>( 5, true ) ;
			M[1][0] = 0 ;
			M[1][1] = 0 ;
			M[1][2] = 1 ;
			M[1][3] = -1 ;
			M[1][4] = 1 ;
			M[2] = new Vector.<Number>( 5, true ) ;
			M[2][0] = 1 ;
			M[2][1] = -1 ;
			M[2][2] = 0 ;
			M[2][3] = 0 ;
			M[2][4] = 0 ;
			M[3] = new Vector.<Number>( 5, true ) ;
			M[3][0] = -2 ;
			M[3][1] = 1 ;
			M[3][2] = 0 ;
			M[3][3] = 0 ;
			M[3][4] = 0 ;
			M[4] = new Vector.<Number>( 5, true ) ;
			M[4][0] = -3 ;
			M[4][1] = -1 ;
			M[4][2] = 0 ;
			M[4][3] = 0 ;
			M[4][4] = 0 ;
			
			result = new Object();
			lcp = new LcpSolver( 5, M, Q, result ) ;
			Assert.assertEquals( result.status, LcpSolver.FOUND_SOLUTION );

			
		}		
	}
}