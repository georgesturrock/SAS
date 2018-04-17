data sleep;
do hours = 1 to 2;
input recall @@;
output;
end;
datalines;
30
33
;
run;

proc glmpower data=sleep;
class hours;
model recall = hours;
power
stddev = 30
ntotal = .
power = 0.7 0.8 0.9;
plot x=power min=0.7 max=0.95;
run;

proc power;
twosamplemeans
meandiff=3
alpha=0.05
ntotal = .
power = 0.7 0.8 0.9
stddev = 30
;
run;
