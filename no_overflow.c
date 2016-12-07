/*
 * i32 %x cannot overflow
 * If the loop bounds and initial x values are known, we can deduce if the result is actually going to overflow, or not.
 */
int mul() {
	  int x = 1;
	    for(int j=1;j<=30;j++){
				x*=2;
				  }
		  return x;
}
