* Import Ames data;
%web_drop_table(WORK.ames);

FILENAME REFFILE '/home/gsturrock0/STAT2/HW8AmesData.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ames;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.ames; RUN;

%web_open_table(WORK.ames);

*1.b - Matrix of Scatter Plots by Neighborhood;
title "Scatter Plots by Neighborhood";
proc sgscatter data = ames;
by neighborhood;
matrix lotfrontage lotarea /*masvnrarea*/ bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf /*secondflrsf*/ grlivarea garagearea saleprice /*rand*/ / ellipse=(type = mean alpha = .05);
run;
title;

*1.c Bartlett's Test;
proc discrim data=ames pool=test;                                                                                                                                                                               
class neighborhood;                                                                                                                                                                                                        
var lotfrontage lotarea /*masvnrarea*/ bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf /*secondflrsf*/ grlivarea garagearea saleprice;                                                                                                                                                                                                
run;      

*1.d and 2 MANOVA;
proc glm data = ames;                                                                                                                                                                                                                                                                                                                                                                                        
class neighborhood;                                                                                                                                                                                                      
model lotfrontage lotarea bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf grlivarea garagearea saleprice = neighborhood;                                                                                                                                                                                                                                                                                                                                                                
manova h=neighborhood / printe printh;   
run;   

*3;
proc glm data=ames;
class neighborhood;
model lotfrontage lotarea bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf grlivarea garagearea saleprice = neighborhood;              
contrast 'Brook Side vs North Ames' neighborhood -1 0 1 0 0 0 0;
estimate 'Brook Side vs North Ames' neighborhood -1 0 1 0 0 0 0;
manova h=neighborhood / printe printh;
lsmeans neighborhood / pdiff tdiff adjust=bon;
run;

*4;
proc discrim data=ames pool=test crossvalidate;
class neighborhood;
var lotfrontage lotarea bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf grlivarea garagearea saleprice;
run;

*5;
data newhouse;
input lotfrontage  lotarea  grlivarea  saleprice;
datalines;
52  6000  1400  110000
;

proc discrim data=ames pool=test testdata=newhouse testout=newhouseclassify;                                                                                                                                                                               
class neighborhood;                                                                                                                                                                                                        
var lotfrontage  lotarea  grlivarea  saleprice;     
priors "BrkSide"=.09 "CollgCr"=.22 "NAmes"=.31 "NoRidge"=.06 "OldTown"=.15 "Somerst"=.14 "StoneBr"=.03; 
run;

proc print data = newhouseclassify;
run;

*Bonus;
proc discrim data=ames pool=test crossvalidate;
class neighborhood;
var lotfrontage lotarea bsmtfinsf1 bsmtunfsf totalbsmtsf firstflrsf grlivarea garagearea saleprice;
priors "BrkSide"=.09 "CollgCr"=.22 "NAmes"=.31 "NoRidge"=.06 "OldTown"=.15 "Somerst"=.14 "StoneBr"=.03; 
run;