# Download Weather data from ASOS

library(lubridate, verbose = F)
library(jsonlite, verbose = F)

GetWeather <- function(time_period = NA, network = "IA_ASOS", sid = NA) {
  
  time_period <- as.Date(time_period)
  if (is.na(sid) | is.na(time_period)[1]) {
    uri <- paste("https://mesonet.agron.iastate.edu/geojson/network/", network, ".geojson", sep = "")
    data <- url(uri)
    jdict <- fromJSON(data)
    return(jdict$features$properties)
  } else {
    
    service <- "https://mesonet.agron.iastate.edu/cgi-bin/request/asos.py?"
    service <- paste(service, "data=all&tz=Etc/UTC&format=comma&latlon=yes&", sep = "")
    service <- paste(service, "year1=", year(time_period)[1], "&month1=", month(time_period)[1], "&day1=", mday(time_period)[1], "&", sep = "")
    service <- paste(service, "year2=", year(time_period)[2], "&month2=", month(time_period)[2], "&day2=", mday(time_period)[2], "&", sep = "")
    
    uri2 <- paste(service, "station=", sid, sep = '')
    data_table <- read.table(uri2, header = T, sep = ',')
    
    return(data_table)
  }
}
