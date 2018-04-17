%web_drop_table(WORK.BASEBALL2010);

FILENAME REFFILE '/home/gsturrock0/my_courses/bsadler0/MSDS 6371/UNIT 8/Baseball_Data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.BASEBALL2010;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.BASEBALL2010; RUN;

%web_open_table(WORK.BASEBALL2010);

*Scatter Plot for Wins vs Payroll;
proc sgplot data=WORK.BASEBALL2010;
scatter x=Wins y=Payroll;
title 'Scatter Plot';
run;
title;

* Caluculate correlation coefficient;
proc corr data=work.baseball2010 pearson cov plots=scatter;
var Wins Payroll;
run;

