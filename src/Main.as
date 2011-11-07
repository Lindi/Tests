package
{
	import flash.display.Sprite;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	import tests.geometry.BspTreeTest;
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
			core.run( tests.physics.lcp.LcpSolverTest );
			//equationAlgorithm();
		}
		private function equationAlgorithm( ):Boolean
		{
			//	Create an array of shit
			var array:Array = new Array();
			var m:int = 4;//int( Math.random() * 10 ) + 10 ;
			
			//	Initialize the loop counters
			var i:int, j:int ;
			
			//	Stick some numbers in the array
			for ( i = 0; i < m; i++)
			{
				var n:int = int( Math.random() * 10 + 10 ) * -1;//( 1 - ( 2 * int( Math.random() * 2  % 2 )));
				array.push( n ) ;
			}
			array[ array.length - 1] = -1 ;
			
			//	Initialize the found array
			//	This array will hold the indices of the equations w/negative
			//	coefficients for the (nonBasicVariable, departingVariableIndex)
			var found:Array= new Array( array.length + 1 );
			for ( i=0; i < array.length + 1; i++ )
			{
				found[i] = new Array(2);
			}
			
			// 	Find equations with negative coefficients for selected index.
			//	Okay, so basically what's happening here is that we're finding
			//	all the equations with coefficients for the non-basic variable we
			//	wish to enter the dictionary.
			
			//	So, for example, if w1 has just left the dictionary
			//	then z1 must enter.  In that case, the nonBasicVariable will be z
			//	and the variable index we're interested in will be that of the
			//	variable that just left the dictionary (in this case 1).
			var temp:Number ;
			for (i = 0, j = 0; i < array.length; ++i)
			{                                    
				temp = array[i] ;
				
				if (temp < 0)
				{
					//	We need to find the non-basic variable with a negative coefficient such
					//	that it becomes positive when it enters the dictionary.  This way, division
					//	of the equation it belongs to by its coefficient won't make the equation's
					//	constant coefficient negative
					found[j++][0] = i;
				}
			}
			
			if ( j != 0 )
			{
				//	If we have found terms with negative coefficients ...
				//	Okay, now this part's tricky.
				//	First, we set the 1st element of the array *after* the last found array with
				//	a negative coefficient to -1.  This serves as a sentinel, to tell us
				//	when we've reached the end of the list
				found[j][0] = -1 ;
				
				//	Find the equation with the smallest ratio of constant term
				//	with selected (nonbasicvariable, departingVariableIndex) coefficient
				//	First, initialize two found array cursors
				var row1:int, row2:int ;
				
				//	These are column index variables.  
				//	If column1 is 0, then column2 must be 1 and vice versa
				var column1:int, column2:int ;
				column1 = 0; column2 = 1 ;
				
				
				//	Iterate over the equations
				for ( i = 0; i <= array.length; i++)
				{
					//	Initialize the column counters
					column2 = ( column1 == 0 ? 1 : 0 );
					
					//	Initialize the row counters
					row1 = row2 = 0 ;
					
					//	Grab the equation index of the row
					//	we're holding 'fixed' (row1) and store it
					//	in the spare column of row2
					var index1:int = found[row1++][column1] ;
					found[row2++][column2] = index1 ; 
					
					//	Store row1 in a variable k
					var k:int = row1 ;
					while ( found[k][column1] > -1 )
					{
						//	Get the index in column1 of row k
						//	Row k changes while (k is incremented after
						//	the equation comparison) row2 doesn't
						var index2:int = found[k][column1] ;
						
						//	If it's negative, break out of the loop
						if ( index2 < 0 )
						{
							break ;
						}
						

						
						//	Make sure that the ratio of the equation at the kth found index
						//	(the kth found index is what's changing) is less than the ratio
						//	for the row we're holding fixed
						temp = array[index2] - array[index1] ;
						
						
						if (temp < 0.0)       
						{
							// The first equation has the smallest ratio.  Do nothing;
							// the first equation is the choice.
						}
						else if (temp > 0.0) 
						{
							
							//	This means we've found an equation that's less
							//	than the "kth" one, so we stick k in row one, 
							//	such that it becomes the pointer to the index of
							//	the minimum equation
							
							// The second equation has the smallest ratio.
							row1 = k;  // Make second equation comparison standard.
							row2 = 0;  // Restart the found array index.
							
							//	Grab the index of the new minimum equation
							//	and stick it in the 'spare' column of row2
							index1 = found[row1++][column1];
							found[row2++][column2] = index1;
						}
						else  // The ratios are the same.
						{
							//	Set the 'spare column' of the spare row
							//	to the index of the equation that is also
							//	as small as our minimum equation
							found[row2++][column2] = index2 ;
						}
						
						//	Increment k
						k++;
						
						//	Eliminate the 'row2th' equation
						found[row2][column2] = -1;
						
					}
					
					if ( row2 == 1 )
					{
						//	If we've gone all the way through the list
						//	without incrementing row2 (it's still 1, which was its
						//	value before the start of the while loop), that means our minimum
						//	equation index is in the spare column of row 0
						trace(found[0][column2]+1);
						return true ;
					}
					
					for ( j = 0; j < found.length; j++ )
					{
						trace( "found["+j+"]: " + found[j][0], found[j][1] );
					}
					
					trace( "\n\n");
					//	If column1 was 0, it should now be 1 and vice-versa
					column1 = ( column1 == 0 ? 1 : 0 );
				}
			}
			
			//	Oops.  Couldn't find anything.
			return false ;	
		}
	}
}