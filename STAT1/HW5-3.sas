%web_drop_table(WORK.ex0525q2);

FILENAME REFFILE '/home/gsturrock0/STAT1/ex0525q2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ex0525q2;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.ex0525q2; RUN;

%web_open_table(WORK.ex0525q2);

data ex0525q2;
SET ex0525q2;
logincome = log(Income2005);
run;

proc glm data=ex0525q2;
class Educ;
model logincome = Educ;
means Educ / hovtest=bf;
run;

proc npar1way data=ex0525q2 wilcoxon;
class Educ;
var logincome;
run;