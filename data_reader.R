data_reader <- function(start_date, end_date){
  
  #Grab the data from our MySQL db
  data <- mysql_query(query = paste("SELECT event_connectStart AS start_ts,
                                                 event_connectEnd as end_ts,
                                                 timestamp,
                                                 event_mobileMode AS site,
                                                 event_isHttps AS https,
                                                 event_isAnon AS anon,
                                                 event_originCountry AS country
                                                 FROM NavigationTiming_8365252
                                                 WHERE event_action = 'view' AND LEFT(timestamp,8) BETWEEN",start_date, "AND",
                                                 end_date),
                               db = "log")
  
  
  #Handle site NULLs
  data$site[!is.na(data$site)] <- "mobile"
  data$site[is.na(data$site)] <- "desktop"
  
  #Mark rows with invalid country codes
  data$country[!nchar(data$country) == 2] <- NA
  
  #Clean
  data <- data[complete.cases(data),]
  
  #Work out timestamps
  data$intertime <- data$end_ts - data$start_ts
  
  #Filter
  data <- data[,c("intertime","site","https","anon","country")]
  
  #Sample
  data <- data[sample(1:nrow(data),100000),]

  #Return
  return(data)
}