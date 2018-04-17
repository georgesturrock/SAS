%web_drop_table(WORK.plastic);

FILENAME REFFILE '/home/gsturrock0/STAT1/plasticEastWest.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.plastic;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.plastic; RUN;

%web_open_table(WORK.plastic);

data critval;
p = quantile("T", .975, 105);

proc print data=critval;
title "Critical Value";
run;
title;

proc ttest data=plastic sides=u alpha=.05;
class region;
var plastic;
run;