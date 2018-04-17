%web_drop_table(WORK.ex0525);

FILENAME REFFILE '/home/gsturrock0/STAT1/ex0525.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ex0525;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.ex0525; RUN;

%web_open_table(WORK.ex0525);

/* Analysis prior to log transformation */
proc means data=ex0525;
class Educ;
var Income2005;
run;

proc univariate;
class Educ;
var Income2005;
hist Income2005;
qqplot Income2005 / square;
run;

proc sgplot data=ex0525;
vbox Income2005 / category=Educ;
title 'Boxplot for Income2005';
run;
title;

proc sgplot data=ex0525;
scatter x=Income2005 y=Educ;
title 'Scatter Plot for Income2005';
run;
title;

/* Natural Log Transformation */
data ex0525;
SET ex0525;
logincome = log(Income2005);
run;

proc means data=ex0525;
title 'Log Transformed Data';
class Educ;
var logincome;
run;

proc univariate;
class Educ;
var logincome;
hist logincome;
qqplot logincome / square;
run;

proc sgplot data=ex0525;
scatter x=logincome y=Educ;
run;
title;

proc glm data=ex0525;
class Educ;
*model Income2005 = Educ;
model logincome = Educ;
means Educ / hovtest=bf;
run;


