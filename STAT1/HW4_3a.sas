%web_drop_table(WORK.EDUCATION);

FILENAME REFFILE '/home/gsturrock0/my_courses/bsadler0/MSDS 6371/UNIT 3/EducationData.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.EDUCATION;
	GETNAMES=YES;
RUN;

/*PROC CONTENTS DATA=WORK.EDUCATION; RUN;*/

%web_open_table(WORK.EDUCATION);

data critval;
p = quantile("T", .975, 473.85)
;

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=EDUCATION sides=2 alpha=.05 order=data;
class Educ;
var Income2005;
title "Welch's TTEST";
run;