library(neptune)
neptune_install()

# SUN-123 is the run you want to resume
run <- neptune_init(project="common-r/quickstarts", run="SUN-123")

# download snapshot of model weights
model <- neptune_download(run["train/model_weights"])
# or model <- run["train/model_weights"]$download()

# 450 is the epoch from where you want to resume training process
checkpoint  <- 450
# continue training as usual
for(epoch in seq(checkpoint, 1000)){
  neptune_log(run["train/accuracy"], 0.75)
  # run["train/accuracy"]$log(0.75)
}
  