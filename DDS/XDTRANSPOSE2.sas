*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates PROC TRANSPOSE;
* You could use MYSASLIB.COMPLICATIONS in the DATA= Statement;
* Note: If you don't already have the MYSASLIB defined, 
        see Chapter 3 Working with SAS Libraries;

TITLE "Illustrates PROC TRANSPOSE, compressing";
TITLE2 "multiple subject records to a single record.";
TITLE3 "Reports subjects having 3 or more complications.";
PROC TRANSPOSE DATA=MYSASLIB.COMPLICATIONS
	OUT=COMP_OUT PREFIX=COMP;
	BY SUBJECT;
	VAR COMPLICATION;
RUN;
DATA MULTIPLE;SET COMP_OUT;
DROP _NAME_ ;
IF COMP3 NE '';
PROC PRINT DATA=MULTIPLE; VAR SUBJECT COMP1-COMP4;
FORMAT SUBJECT 10. COMP1-COMP4 $10.;
RUN;

DATA RENAL;SET COMP_OUT;
CCAT=CATT(OF COMP1-COMP7);
IF FIND(UPCASE(CCAT),"RENAL") NE 0 THEN RENALFAILURE="Yes";
   ELSE RENALFAILURE="No";
RUN;

TITLE;FOOTNOTE;

PROC FREQ DATA=RENAL;
TABLES RENALFAILURE; 
RUN;

TITLE;FOOTNOTE;


