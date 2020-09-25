GetWeather: A tool to download weather data from the ASOS networks
======================================================================================

The GetWeather function allows you to download weather data from many stations around the world.
This data is made accesible by the Iowa Environmental Mesonet (IEM), which collects it from the Automated Surface Observing System (ASOS).
Each network is a cluster of stations. There is a long list of networks, contact me if you cannot find the one that interests you (fmaguate@gmail.com).
This is a sample of networks (I will be adding more):

AK_ASOS = Alaska, US
AQ__ASOS = Antarctica
AR__ASOS = Argentina
AU__ASOS = Australia
BR__ASOS = Brasil
CN__ASOS = China
DK__ASOS = Denmark
FL_ASOS = Florida, US
IA_ASOS = Iowa, US
IT__ASOS = Italy
MX__ASOS = Mexico
MI_ASOS = Michigan, US
KP__ASOS = North Korea
PL__ASOS = Poland
RU__ASOS = Russia
ES__ASOS = Spain
UY__ASOS = Uruguay
WI_ASOS = Wisconsin, US

How to use the function - Example
--------

## Set up:

To run the function you will need packages lubridate and jsonlite. Install those with install.packages() and then you will be ready to source the function with:
```R
source('https://raw.githubusercontent.com/FerAguate/GetWeather/master/GetWeather.R')
```

## To get a list of station IDs, select a network first:

We will select Italy as example, and print the last 6 stations
```R
tail(GetWeather(network = "IT__ASOS"))
    elevation          sname state country climate_site wfo      tzname ncdc81 ugc_county ugc_zone county  sid
101  287.0000          Turin  <NA>      IT           NA  NA Europe/Rome     NA         NA       NA     NA LIMA
102  251.0000  USTICA ISLAND  <NA>      IT           NA  NA Europe/Rome     NA         NA       NA     NA LICU
103    6.0000         Venice  <NA>      IT           NA  NA Europe/Rome     NA         NA       NA     NA LIPZ
104  258.0539 Vigna Di Valle            IT           NA  NA Europe/Rome     NA         NA       NA     NA LIRB
105   68.0000    Villafranca  <NA>      IT           NA  NA Europe/Rome     NA         NA       NA     NA LIPX
106  300.0000        Viterbo  <NA>      IT           NA  NA Europe/Rome     NA         NA       NA     NA LIRV
```

say we are interested in Turin (sid = LIMA) and we want to get data from 2018
```R
Turin_we <- GetWeather(time_period = c("2018-01-01", "2018-12-30"), network = "IT__ASOS", sid = "LIMA")
head(Turin_we) # print the first 6 rows of data
  station            valid    lon     lat  tmpf  dwpf   relh   drct sknt p01i  alti mslp vsby gust skyc1 skyc2 skyc3
1    LIMA 2018-01-01 08:00 7.6034 45.0864 33.80 33.80 100.00 190.00 3.00    0 29.91    M 0.56    M   SCT     M     M
2    LIMA 2018-01-01 08:50 7.6034 45.0864 35.60 35.60 100.00      M 2.00    0 29.91    M 0.56    M   SCT     M     M
3    LIMA 2018-01-01 09:50 7.6034 45.0864 37.40 35.60  93.14   0.00 0.00    0 29.91    M 0.87    M   SCT     M     M
4    LIMA 2018-01-01 10:50 7.6034 45.0864 39.20 37.40  93.19   0.00 0.00    0 29.88    M 1.86    M   SCT     M     M
5    LIMA 2018-01-01 12:05 7.6034 45.0864 37.40 37.40 100.00 190.00 7.00    0 29.88    M 0.81    M   FEW     M     M
6    LIMA 2018-01-01 12:50 7.6034 45.0864 37.40 37.40 100.00 170.00 3.00    0 29.88    M 0.81    M   FEW     M     M
  skyc4   skyl1 skyl2 skyl3 skyl4 wxcodes ice_accretion_1hr ice_accretion_3hr ice_accretion_6hr peak_wind_gust
1     M 1000.00     M     M     M      FG                 M                 M                 M              M
2     M 1000.00     M     M     M      FG                 M                 M                 M              M
3     M 1000.00     M     M     M      BR                 M                 M                 M              M
4     M 2000.00     M     M     M      BR                 M                 M                 M              M
5     M 2000.00     M     M     M      BR                 M                 M                 M              M
6     M 2000.00     M     M     M      BR                 M                 M                 M              M
  peak_wind_drct peak_wind_time  feel                                                   metar
1              M              M 30.75 LIMA 010800Z 19003KT 160V230 0900 FG SCT010 01/01 Q1013
2              M              M 35.60         LIMA 010850Z VRB02KT 0900 FG SCT010 02/02 Q1013
3              M              M 37.40         LIMA 010950Z 00000KT 1400 BR SCT010 03/02 Q1013
4              M              M 39.20         LIMA 011050Z 00000KT 3000 BR SCT020 04/03 Q1012
5              M              M 31.36         LIMA 011205Z 19007KT 1300 BR FEW020 03/03 Q1012
6              M              M 34.86 LIMA 011250Z 17003KT 140V230 1300 BR FEW020 03/03 Q1012
```

The column keys are:

tmpf = Temperature (F)
dwpf = Dew point (F)
relh = Relative humidity (%)
drct = Wind direction (degrees)
sknt = Wind speed (knots)
p01i = Hourly cumulative precipitation. See: https://github.com/rmcd1024/daily_precipitation_totals
alti = Pressure altimeter (inches)
mslp = Sea level pressure (millibar)
vsby = Visibility (miles)
gust = Wind gust (knots)
skyc1 = Sky level 1 coverage
skyl1 = Sky level 1 altitude (feet)
wxcodes = Present weather codes
feel = apparent temperature (F)

