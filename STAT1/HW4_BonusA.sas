data trauma;
	input state $ kcal;
	
datalines;
0 19
0 20
0 20
0 21
0 21
0 21
1 22
0 23
0 23
1 23
1 25
1 26
1 30
1 38
1 39
;

/* 0 = Non-Trauma, 1 = Trauma */

proc ttest data=trauma;
	class state;
	*may need to convert School to numeric;
	var kcal;
run;

ods output off;
ods exclude all;
*borrowed code from internet ... randomizes observations and creates a matrix ... one row per randomization ;

proc iml ;
	use trauma;
	read all var{state kcal} into x;
	*change varibale names here ... make sure it   is   class then var ... in that order.;
	p=t(ranperm(x[, 2], 5000));
	*Note that the "1000" here is the number of permutations. ;
	paf=x[, 1]||p;
	create newds from paf;
	append from paf;
	quit;
	*calculates differences and creates a  histogram;
	ods output conflimits=diff;

proc ttest data=newds plots=none;
	class col1;
	var col2 -  col1001;
run;

ods output on;
ods exclude none;

proc univariate data=diff;
	where method="Pooled";
	var mean;
	histogram mean;
run;

*The code below calculates the number of   randomly generated differences that are as   extreme or more extreme thant the one observed (divide this number by 1000 you have the pvalue);
*check the log to see how many observations are in the data set.... divide this by   1000 (or however many permutations you generated) and that is the (one sided)p-value;

data numdiffs;
	set diff;
	where method="Pooled";

	if abs(mean) >=7.8089;
	*you will need to put the observed difference you got from t test above here.  note if you have a one or two tailed test.;
run;

*  just a visual of the rows produced ... you can get the number of obersvations from the last data step and the Log window.;

proc print data=numdiffs;
	where method="Pooled";
run;