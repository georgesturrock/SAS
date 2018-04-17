*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates the use of  PROC PRINT;

* NOTE: You can also use DATA=MYSASLIB.SOMEDATA 
* if the MYSASLIB library has been previously defined;

PROC PRINT LABEL DATA=MYSASLIB.SOMEDATA
	SPLIT='*'
	N = 'Number of Subjects is: '
	Obs='Subjects';
	LABEL TIME1='Observation*at*60 Seconds*-----------' 
	      TIME2='Observation*at*120 Seconds*-----------' 
	      TIME3='Observation*at*5 Minutes*-----------';
SUM TIME1 TIME2 TIME3 TIME4;
TITLE 'PROC PRINT Example';
RUN;

TITLE;FOOTNOTE;
