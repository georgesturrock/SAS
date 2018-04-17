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
means Handicap / hovtest= bf lsd dunnett tukey bon scheffe cldiff;
run;
