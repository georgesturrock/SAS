data mel;
input Year Melanoma Sunspot;
datalines;
1936 1 40
1937 0.9 115
1938 0.8 100
1939 1.4 80
1940 1.2 60
1941 1 40
1942 1.5 23
1943 1.9 10
1944 1.5 10
1945 1.5 25
1946 1.5 75
1947 1.6 145
1948 1.8 130
1949 2.8 130
1950 2.5 80
1951 2.5 65
1952 2.4 20
1953 2.1 10
1954 1.9 5
1955 2.4 10
1956 2.4 60
1957 2.6 190
1958 2.6 180
1959 4.4 175
1960 4.2 120
1961 3.8 50
1962 3.4 35
1963 3.6 20
1964 4.1 10
1965 3.7 15
1966 4.2 30
1967 4.1 60
1968 4.1 105
1969 4 105
1970 5.2 105
1971 5.3 80
1972 5.3 65
;

data melp;
input Year Melanoma Sunspot;
datalines;
1936 1 40
1937 0.9 115
1938 0.8 100
1939 1.4 80
1940 1.2 60
1941 1 40
1942 1.5 23
1943 1.9 10
1944 1.5 10
1945 1.5 25
1946 1.5 75
1947 1.6 145
1948 1.8 130
1949 2.8 130
1950 2.5 80
1951 2.5 65
1952 2.4 20
1953 2.1 10
1954 1.9 5
1955 2.4 10
1956 2.4 60
1957 2.6 190
1958 2.6 180
1959 4.4 175
1960 4.2 120
1961 3.8 50
1962 3.4 35
1963 3.6 20
1964 4.1 10
1965 3.7 15
1966 4.2 30
1967 4.1 60
1968 4.1 105
1969 4 105
1970 5.2 105
1971 5.3 80
1972 5.3 65
1973 . .
1974 . .
1975 . .
;

data melbonus;
input Year Melanoma Sunspot;
lmel=lag1(Melanoma);
lsun=lag1(Sunspot);
lmel2=lag2(Melanoma);
lsun2=lag2(Melanoma);
datalines;
1936 1 40
1937 0.9 115
1938 0.8 100
1939 1.4 80
1940 1.2 60
1941 1 40
1942 1.5 23
1943 1.9 10
1944 1.5 10
1945 1.5 25
1946 1.5 75
1947 1.6 145
1948 1.8 130
1949 2.8 130
1950 2.5 80
1951 2.5 65
1952 2.4 20
1953 2.1 10
1954 1.9 5
1955 2.4 10
1956 2.4 60
1957 2.6 190
1958 2.6 180
1959 4.4 175
1960 4.2 120
1961 3.8 50
1962 3.4 35
1963 3.6 20
1964 4.1 10
1965 3.7 15
1966 4.2 30
1967 4.1 60
1968 4.1 105
1969 4 105
1970 5.2 105
1971 5.3 80
1972 5.3 65
;

*HW 4.1;
*Plot Melanoma over Time;
proc sgplot data = mel;
scatter x = Year y = Melanoma;
series x = Year y = Melanoma;
title 'Melanoma Occurences per 100,000 people 1936 - 1972';
run;

*Plot Sunspots over Time;
proc sgplot data = mel;
scatter x = Year y = Sunspot;
series x = Year y = Sunspot;
title 'Sunspots 1936 - 1972';
run;

title;

*HW 4.2;
proc glm data = mel plots = all;
model Melanoma = Year;
output out = resids r = residsOLS;
run;

*HW 4.3;
proc autoreg data = mel;
model Melanoma = Year / dwprob;
run;

*HW 4.4;
proc autoreg data = mel;
model Melanoma = Year / nlag = 1 dwprob;
output out = Forecast p = yhat pm = ytrend lcl = lower ucl = upper;
run;

*HW 4.5;
proc autoreg data = melp;
model Melanoma = Year / nlag = 1 dwprob;
output out = Forecast p = yhat pm = ytrend lcl = lower ucl = upper;
run;

proc sgplot data = Forecast;
band x = Year upper = upper lower = lower;
scatter x = Year y = Melanoma;
series x = Year y = yhat;
series x = Year y = ytrend / lineattrs = (color = black);
run;

*Bonus;
proc autoreg data=melbonus;
model Melanoma = Year Sunspot lsun lsun2 / dwprob;
run;
