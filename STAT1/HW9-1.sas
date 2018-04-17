%web_drop_table(WORK.BASEBALL2010);

FILENAME REFFILE '/home/gsturrock0/my_courses/bsadler0/MSDS 6371/UNIT 8/Baseball_Data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.BASEBALL2010;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.BASEBALL2010);

proc glm data=work.baseball2010;
model Wins = Payroll / solution clparm;
run;