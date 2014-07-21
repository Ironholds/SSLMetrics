#Source config and data reader
source("config.R")
source("data_reader.R")

SSLMetrics <- function(){
  
  #Retrieve each dataset and tag
  pre_change <- data_reader(start_date = 20140602, end_date = 20140608)
  post_change <- data_reader(start_date = 20140707, end_date = 20140713)
  
  #Save data just in case we need it
  save(pre_change,post_change, file = "ssl_data.RData")
  
  #Generate and print t-test
  print(t.test(x = log(pre_change$intertime), y = log(post_change$intertime)))
  
}

SSLMetrics()
