library(neptune)
neptune_install()

# Resume Run with identifier "SUN-123"
run <- neptune_init(project="common-r/quickstarts", run="SUN-123")

# Download snapshot of model weights to the working directory
neptune_download(run["train/model_weights"])
# You can also use reticulate based syntax
run["train/model_weights"]$download()

# 450 is the epoch from where you want to resume training process
checkpoint  <- 450

# Continue training as usual
for(epoch in seq(checkpoint, 1000)){
  neptune_log(run["train/accuracy"], 0.75)
  # You can also use reticulate based syntax
  # run["train/accuracy"]$log(0.75)
}
  
