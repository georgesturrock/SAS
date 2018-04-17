/* Homework 10 - Question 2.  18.5 from the text. */
proc format;                                                                                                                            
   value ExpFmt 1='Abuse Victim'                                                                                                             
                   0='Control';                                                                                                         
   value RspFmt 1='Yes'                                                                                                            
                0='No';                                                                                                       
run; 
                                                                                                                                   
data VCrime;                                                                                                                        
   input Victim Response Count;                                                                                                       
   label Response='Violent Crime';                                                                                                      
   datalines;                                                                                                                           
0 0  614                                                                                                                                
0 1  53                                                                                                                                 
1 0  806                                                                                                                                 
1 1  102                                                                                                                                 
;                                                                                                                                       
                                                                                                                                        
proc sort data=VCrime;                                                                                                              
by descending Victim descending Response;
*by Drinks Response;                                                                                        
run;                                                                                                                                    

proc freq data=VCrime order=data;                                                                                                   
   format Victim ExpFmt. Response RspFmt.;                                                                                            
   tables Victim*Response / chisq  riskdiff(equal var=null) relrisk;                                              
   exact pchi or fisher;                                                                                                                
   weight Count;                                                                                                                        
   title 'HW 10 - 18.5 - Question 2';                                                                                                         
run;                              