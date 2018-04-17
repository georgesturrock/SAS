%web_drop_table(WORK.EURODEATHAGE2);

FILENAME REFFILE '/home/gsturrock0/STAT1/EuroDeathAge2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.EURODEATHAGE2;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.EURODEATHAGE2; RUN;

%web_open_table(WORK.EURODEATHAGE2);

PROC UNIVARIATE DATA=WORK.EURODEATHAGE2;
class Class;
var Age;
qqplot;
histogram;
run;

proc glm data=WORK.EURODEATHAGE2;
class Class;
model Age = Class;
means Class / hovtest=bf;
contrast "Compare Gent to Sov" Class 0 1 -1;
estimate "Sum Gent to Sov" Class 0 1 -1;
run;

data quantile;
quant = quantile('t', 0.975, 169-3);
run;

proc print data=quantile;
run;