library(neptune)
neptune_install()

# Initialize a new Run
run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

# Track metadata and hyperparameters of your Run
run["JIRA"] <- "NPT-952"
run["algorithm"] <- "ConvNet"

parameters <- list(
  "batch_size"= 64,
  "dropout"= 0.2,
  "learning_rate"= 0.001,
  "optimizer"= "Adam"
)
run["parameters"] <- parameters

# log score
run["single_metric"] <- 0.62

# Track the training process by logging your training metrics
for(i in 1:100){
  neptune_log(run["train/accuracy"], i * runif(1))
  neptune_log(run["train/loss"], i * runif(1))

  # You can also use reticulate based syntax
  # run["train/accuracy"]$log(i * runif(1))
}

# Log the final results
run["f1_score"] <- 0.66

# Stop logging to you Run
neptune_stop(run)

# You can also use reticulate based syntax
# run$stop()
