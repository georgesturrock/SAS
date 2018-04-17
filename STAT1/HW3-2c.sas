data cash;
	input School $ Money;

/* School = 0 = SMU
 School = 1 = Seattle U */

datalines;
SMU 34
SMU 23
SMU 50
SMU 60
SMU 50
SMU 0
SMU 0
SMU 30
SMU 89
SMU 0
SMU 300
SMU 400
SMU 20
SMU 10
SMU 0
Seattle 20
Seattle 10
Seattle 5
Seattle 0
Seattle 30
Seattle 50
Seattle 0
Seattle 100
Seattle 110
Seattle 0
Seattle 40
Seattle 10
Seattle 3
Seattle 0
;

data critval;
p = quantile("T", .975, 27)
;

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=cash sides=2 alpha=.05;
class School;
var Money;
run;

proc univariate data=cash;
class School;
var Money;
histogram Money;
qqplot Money / normal(mu=est sigma=est) square;
run;
