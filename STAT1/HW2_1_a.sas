data bats;
input weight @@;
datalines;
1.7
1.6
1.5
2.0
2.3
1.6
1.6
1.8
1.5
1.7
1.2
1.4
1.6
1.6
1.6
;

/*proc print data=bats;
run;*/

data critval;
p = quantile("T", .975, 14)
;

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=bats h0=1.8 sides=2 alpha=.05;
var weight;
run;

