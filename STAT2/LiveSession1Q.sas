data exemplary;
do diet = 1 to 2;
input ldl @@;
output;
end;
datalines;
94
100
;
run;

proc glmpower data=exemplary;
class diet;
model ldl = diet;
power
stddev = 10
ntotal = .
power = 0.7 0.8 0.9;
plot x=power min=0.7 max=0.95;
run;

proc power;
twosamplemeans
meandiff=6
alpha=0.05
ntotal = .
power = 0.7 0.8 0.9
stddev = 10
;
run;

/*
data exemplary;
do diet = 1 to 2;
do exercise = 1 to 3;
input ldl @@;
output;
end;
end;
datalines;
70 80 90
90 100 110
;
run;

proc glmpower data=exemplary;
class diet exercise;
model ldl = diet exercise;
power
stddev = 10
ntotal = .
power = 0.8;
plot x=power min=0.7 max=1;
run;
*/
