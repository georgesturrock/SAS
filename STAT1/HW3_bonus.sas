data tuition;
	input InOut $ Tuition;
	
datalines;
In 1000
In 4000
In 5000
In 8000
In 40000
Out 3000
Out 8000
Out 30000
Out 32000
Out 40000
;

data critval;
p = quantile("T", .975, 27)
;

proc ttest data=tuition sides=2 alpha=.05;
	class InOut;
	var Tuition;
run;