%web_drop_table(WORK.handicap);

FILENAME REFFILE '/home/gsturrock0/STAT1/handicap.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.handicap;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.handicap; RUN;

%web_open_table(WORK.handicap);

*remove observation number column;
data handicap;
set handicap;
drop var1;
run;

proc glm data=handicap;
class Handicap;
model Score = Handicap;
means Handicap / hovtest= bf bon cldiff;
lsmeans Handicap / pdiff adjust=bon cl;
run;

data quantile;
title 'Critical Value for T Distribution';
quant = quantile('t',0.9917,70-5);
run;
proc print data=quantile;
run;
title;