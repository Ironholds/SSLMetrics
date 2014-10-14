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
  
  #Run bootstrapping over the top 10 percent just to be sure.
  print(quantile(pre_change$intertime), props = .9)
  print(boot.ci(boot(sample(pre_change$intertime,10000), function(x, indices){quantile(x[indices], .9)}, 10000)))
  print(quantile(post_change$intertime), props = .9)
  print(boot.ci(boot(sample(pre_change$intertime,10000), function(x, indices){quantile(x[indices], .9)}, 10000)))

}

SSLMetrics()
