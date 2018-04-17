*Homework 11 - Question B - Poisson Sampling;
proc format;
   value ExpFmt 1='Exposure to Asbestos'
                0='No Exposure to Asbestos';
   value RspFmt 1='Deaths'
                0='Referents';
run;

data HW11B;                                                                                                                            
   input Exposure Response Count;                                                                                                       
   label Response='Asbestos Exposure';                                                                                                        
   datalines;                                                                                                                           
0 0  343                                                                                                                               
0 1  75                                                                                                                               
1 0  372                                                                                                                             
1 1  148                                                                                                                               
;

proc sort data=HW11B;                                                                                                                  
   by descending Exposure descending Response;                                                                                          
run;

proc freq data=HW11B order=data;
   format Exposure ExpFmt. Response RspFmt.;
   tables Exposure*Response / chisq  riskdiff(equal var=null) relrisk;
   exact pchi or fisher;
   weight Count;
   title 'Survival of Subjects Exposed to Asbestos';
   title2 'Poisson Sampling Scheme';
run; 
title;
title2;

*Homework 11 - Question C - Multinomial Sample;
data HW11C;                                                                                                                            
   input Exposure Response Count Smoker $;                                                                                                       
   label Response='Asbestos Exposure';                                                                                                        
   datalines;                                                                                                                           
0 0  103  Non-Smoker                                                                                                                               
0 1  6  Non-Smoker
1 0  98  Non-Smoker
1 1  17  Non-Smoker
0 0  240 Smoker
0 1  69  Smoker
1 0  274  Smoker
1 1  131  Smoker
;

proc sort data=HW11C;                                                                                                                 
   by descending Exposure descending Response;                                                                                          
run;                                                                                                                                    
                                                                                                                                   
proc freq data=HW11C order=data;                                                                                                      
   format Exposure ExpFmt. Response RspFmt.;                                                                                            
   tables Smoker*Exposure*Response / CMH chisq  riskdiff(equal var=null) relrisk;                                                      
   exact pchi or fisher;                                                                                                                
   weight Count;
   title 'Survival of Subjects Exposed to Asbestos';
   title2 'Accounting for Smoking Habits';
   title3 'Mutinomial Sampling';                                                                                               
run;
title;
title2;
title3;
