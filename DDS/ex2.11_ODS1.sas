*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates ODS;
* Note: If you have data in a folder other than C:\SASDATA you need to modify
        the INFILE statement;


*DATA TEST; 
*SET "C:\SASDATA\SOMEDATA";

/* TODO: your computer has SOMEDATA data and you can locate it 
    in Windows with the following path.
PROC TRANSPOSE DATA="C:\SASDATA\SOMEDATA"

In SAS OnDemand studio, the path of the data file should be found if you right-click 
on the folder, for example, my_content that has the data file

(1) Change the following DATA path to read SOMEDATA data from your SAS onDemand Studio
(2) Change the output libraray from EX_MOD2.TEST to your_lib.TEST
*/
DATA MYSASLIB.TEST; SET MYSASLIB.SOMEDATA;
* DEFINE WHERE HTML LISTING WILL GO;
TITLE 'ODS HTML Example';

/* TODO: 
(1) compare the style of HTML when  STYLE=STATISTICAL exist and not
hint: You can see the difference of HTML  documents at a browser not in this SAS env. 
You have to look up your folder, my_content, to find out ODS.HTML and open it in a web browser.
*/
ODS HTML BODY='/home/gsturrock0/UNIT2/ODS.HTML' STYLE=STATISTICAL;
PROC MEANS MAXDEC=2; VAR AGE TIME1-TIME4;
RUN;
* CLOSE THE HTML OUTPUT;
ODS HTML CLOSE;
RUN;
ODS PREFERENCES; * NEEDED TO TURN BACK ON HTML DEFAULT;

TITLE;FOOTNOTE;
