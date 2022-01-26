# Import Neptune and create a Run in offline mode
library(neptune)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS", mode = "offline")

# Log hyperparameters
parameters <- list(
  "dense_units"= 128,
  "activation"= "relu",
  "dropout"= 0.23,
  "learning_rate"= 0.15,
  "batch_size"= 64,
  "n_epochs"= 30
)
run["model/parameters"] <- parameters

# Log evaluation results
run["evaluation/accuracy"] <- eval_acc
run["evaluation/loss"] <- eval_loss

# Manually upload Run from command line interface:
# neptune sync
