data yoga;
input child before after;
datalines;
1 85 75
2 70 50
3 40 50
4 65 40
5 80 20
6 75 65
7 55 40
8 20 25
9 70 30
;

data yogatt;
input test $ time;
datalines;
B 85
A 75
B 70
A 50
B 40
A 50
B 65
A 40
B 80
A 20
B 75
A 65
B 55
A 40
B 20
A 25
B 70
A 30
;

proc ttest data=yogatt alpha=.05 sides=2;
var time;
class test;
run;

data yoga2;
set yoga;
*diff = before - after;
diff = after - before;
run;

proc ttest data=yoga2 alpha=.05 sides=L;
 paired after*before;
run;

/*proc univariate data=yoga2;
var diff;
run;*/
