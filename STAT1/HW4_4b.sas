data trauma;
	input state $ kcal;
	
datalines;
NT 18.8
NT 20.0
NT 20.1
NT 20.9
NT 20.9
NT 21.4
T 22.0
NT 22.7
NT 22.9
T 23.0
T 24.5
T 25.8
T 30.0
T 37.6
T 38.5
;

proc univariate data=TRAUMA;
var kcal;
class state;
histogram kcal;
qqplot kcal / square;
run;

proc ttest data=TRAUMA;
var kcal;
class state;
run;

proc npar1way data=trauma wilcoxon alpha=.05;
var kcal;
class state;
exact wilcoxon HL;
run;