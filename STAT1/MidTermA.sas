%web_drop_table(WORK.myeloma);

FILENAME REFFILE '/home/gsturrock0/STAT1/myeloma.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.myeloma;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.myeloma);

proc univariate data=work.myeloma;
class Drug;
var LambdaDrop;
histogram LambdaDrop;
qqplot LambdaDrop / square;
Run;

*part a;
proc glm data=work.myeloma;
class Drug;
model LambdaDrop = Drug;
means Drug / hovtest= bf tukey cldiff;
lsmeans Drug / pdiff adjust= tukey cl;
run;

* part b;
proc glm data=work.myeloma alpha=.01;
class Drug;
model LambdaDrop = Drug;
means Drug / hovtest= bf tukey cldiff;
lsmeans Drug / pdiff adjust= tukey cl;
contrast "Compare Type A and B Drugs" Drug 1 1 -1 -1;
estimate "Estimate Type A to B Drugs" Drug 1 1 -1 -1;
run;

data quantile;
title 'Critical Value for T Distribution - part a';
quant = quantile('t',0.975,140-4);
run;
proc print data=quantile;
run;
title;

data quantile;
title 'Critical Value for T Distribution - part b';
quant = quantile('t',0.995,140-4);
run;
proc print data=quantile;
run;
title;