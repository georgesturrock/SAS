*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates the use of PROC TRANSPOSE;

DATA SUBJECTS;                                                         
INPUT SUB1 $ SUB2 $ SUB3 $ SUB4 $;                                     
DATALINES;                                                             
12 21 13 14
13 21 12 14
15 31 23 23
15 33 21 32
 M  F  F  M
;                                                                   
PROC TRANSPOSE DATA=SUBJECTS OUT=TRANSPOSED PREFIX=INFO;                       
  VAR SUB1 SUB2 SUB3 SUB4;           
RUN;                                                                   
PROC PRINT DATA=TRANSPOSED;
RUN;

DATA NEW; SET TRANSPOSED;
RENAME INFO1=T1 INFO2=T2 INFO3=T3 INFO4=T4 INFO5=GENDER;
RUN;
PROC PRINT DATA=NEW;
RUN;

TITLE;FOOTNOTE;
