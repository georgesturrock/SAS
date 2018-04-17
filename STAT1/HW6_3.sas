%web_drop_table(WORK.ex0525);

FILENAME REFFILE '/home/gsturrock0/STAT1/ex0525.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ex0525;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.ex0525; RUN;

%web_open_table(WORK.ex0525);

proc sort data=ex0525;
by Educ;
run;

data ex0525;
SET ex0525;
logincome = log(Income2005);
run;

proc univariate data=ex0525;
class Educ;
var Income2005;
hist Income2005;
qqplot Income2005 / square;
run;

proc sgplot data=ex0525;
scatter x=Income2005 y=Educ;
title 'Scatter Plot for Income2005';
run;
title;

proc means data=ex0525;
class Educ;
var Income2005 logincome;
run;

*Tukey-Kramer Test;
proc glm data=ex0525;
class Educ;
*model Income2005 = Educ;
model logincome = Educ;
means Educ / hovtest= bf tukey;
lsmeans Educ / pdiff adjust=tukey;
run;

*Dunnett Test;
proc glm data=ex0525;
class Educ;
*model Income2005 = Educ;
model logincome = Educ;
means Educ / hovtest= bf dunnett('12');
lsmeans Educ / pdiff=control('12') adjust=dunnett ;
run;
