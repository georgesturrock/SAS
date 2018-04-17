data discriminate;
	input Status Age;

/* Status = 0 = Fired
 Status = 1 = Not Fired */

datalines;
0 34
0 37
0 37
0 38
0 41
0 42
0 43
0 44
0 44
0 45
0 45
0 45
0 46
0 48
0 49
0 53
0 53
0 54
0 54
0 55
0 56
1 27
1 33
1 36
1 37
1 38
1 38
1 39
1 42
1 42
1 43
1 43
1 44
1 44
1 44
1 45
1 45
1 45
1 45
1 46
1 46
1 47
1 47
1 48
1 48
1 49
1 49
1 51
1 51
1 52
1 54
;

data critval;
p = quantile("T", .975, 49)
;

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=discriminate sides=2 alpha=.05;
class status;
var age;
run;
