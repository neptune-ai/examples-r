library(neptune)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

# log score
run["single_metric"] <- 0.62

for(i in 1:100){
  Sys.sleep(0.2)  # to see logging live
  neptune_log(run["random_training_metric"], i * runif(1))
  # other possible syntax
  # run["random_training_metric"]$log(i * runif(1))
}
  
neptune_log(run["other_random_training_metric"], 0.5 * i * runif(1))
# other possible syntax
# run["random_training_metric"]$log(0.5 * i * runif(1))