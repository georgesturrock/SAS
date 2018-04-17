%web_drop_table(WORK.stemp);

FILENAME REFFILE '/home/gsturrock0/STAT2/SouthernTemp.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.stemp;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.stemp; RUN;

%web_open_table(WORK.stemp);

%web_drop_table(WORK.pstemp);

FILENAME REFFILE '/home/gsturrock0/STAT2/SouthernTemp1e.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.pstemp;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.pstemp; RUN;

%web_open_table(WORK.pstemp);


*AQ1.a
proc sgplot data=stemp;
series x=year y=temperature;
scatter x=year y=temperature;
run;

*AQ1.b and .c;

proc glm data=stemp plots=all;
model temperature = year;
run;

*AQ1.d;
proc autoreg data=stemp plots=all;
model temperature = year / dwprob;
run;

*AQ1.e and .f;
proc autoreg data=pstemp plots=all;
model temperature = year / nlag=1 dwprob;
output out=fcast p=yhat pm=ytrend lcl=lower ucl=upper;
run;

proc sgplot data=fcast;
title 'Southern Hemisphere Temperature Comparison to 161 Year Mean';
title2 'with 2011 Forecast';
band x=year upper=upper lower=lower;
scatter x=Year y=temperature;
series x=year y=temperature;
series x=year y=ytrend / lineattrs=(color=black);
run;
title;
title2;

*bonus;
%web_drop_table(WORK.sbonus);


FILENAME REFFILE '/home/gsturrock0/STAT2/SouthernTempBON.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.sbonus;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.sbonus; RUN;


%web_open_table(WORK.sbonus);

proc autoreg data=sbonus plots=all;
class recent;
model temperature = year recent / nlag=1 dwprob;
*output out=fcast p=yhat pm=ytrend lcl=lower ucl=upper;
run;