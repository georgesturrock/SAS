*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates ODS;
* Note: If you have data in a folder other than C:\SASDATA you need to modify
        the INFILE statement;


DATA TEST; SET MYSASLIB.SOMEDATA;
* DEFINE WHERE HTML LISTING WILL GO;
TITLE 'ODS HTML Example';
ODS HTML BODY='/home/gsturrock0/UNIT2/XODS.HTML' STYLE=OCEAN;
PROC MEANS MAXDEC=2; VAR AGE TIME1-TIME4;
RUN;
* CLOSE THE HTML OUTPUT;
ODS HTML CLOSE;
RUN;
ODS PREFERENCES; * NEEDED TO TURN BACK ON HTML DEFAULT;

TITLE;FOOTNOTE;
