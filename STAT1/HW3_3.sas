%web_drop_table(WORK.EDUCATION);

FILENAME REFFILE '/home/gsturrock0/my_courses/bsadler0/MSDS 6371/UNIT 3/EducationData.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.EDUCATION;
	GETNAMES=YES;
RUN;

/*PROC CONTENTS DATA=WORK.EDUCATION; RUN;*/

%web_open_table(WORK.EDUCATION);

data EDUCATION;
SET education;
log10income = log10(Income2005);
logincome = log(Income2005);
run;

data critval;
p = quantile("T", .975, 1424)
;

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=EDUCATION sides=2 alpha=.05;
class Educ;
var Income2005;
title "Non-Logarithmic TTEST";
run;

proc ttest data=EDUCATION sides=2 alpha=.05;
class Educ;
var logincome;
title "Natural Log TTEST";
run;

title;
proc means data=education mean median skewness stddev;
run;