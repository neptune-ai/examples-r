# Install Python environment and Neptune package
install.packages("reticulate")
library(reticulate)
install_miniconda()
install.packages("neptune")

# Import Neptune package and set it up
library("neptune")
neptune_install()

# Create a tracked Run
run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

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

# Add additional parameters
run["model/parameters/seed"] <- round(runif(1) * 100)

# Update parameters e.g. after triggering an early stopping
run["model/parameters/n_epochs"] <- parameters[["n_epochs"]]


# Log training metrics
for(epoch in 1:parameters[["n_epochs"]]){
  # ...
  # My training loop
  neptune_log(run["train/accuracy"], acc)
  neptune_log(run["train/loss"], loss)
}

# Log evaluation results
run["evaluation/accuracy"] <- eval_acc
run["evaluation/loss"] <- eval_loss

# Load necessary packages for visualization
library(ggplot2)
library(pROC)

# Define objects to plot and calculate AUC
rocobj <- roc(test$default, predicted)
auc <- round(auc(test$default, predicted),4)

# Create ROC plot
p <- ggroc(rocobj, colour = "steelblue", size = 2) +
  ggtitle(paste0("ROC Curve ", "(AUC = ", auc, ")"))

# You can upload plot directly, it gets converted to an image and uploaded
neptune_upload(run["evaluation/ROC"], p)

# You can log sample predictions as a series of labeled images
for(row in sample_predictions){
  image = row[["image"]]
  predicted_label = row[["predicted_label"]]
  probabilites = row[["probabilites"]]
  description = paste(paste0("class ", probabilites[1], ": ", probabilites[2]), collapse = "\n")
  neptune_log(run["evaluation/predictions"],
              image,
              name=predicted_label,
              description=description
  )
}

# If you are working with tabular data you can upload data frame
# and inspect it as a neat table in the Neptune UI
df = data.frame(
  "y_test" = y_test,
  "y_pred" = y_pred,
  "y_pred_probability" = apply(y_pred_proba, 1, max)
)
neptune_upload(run["evaluation/predictions"], neptune_file_as_html(df))

# Upload model file
save(model, file="model.Rdata")
neptune_upload(run["model/saved_model"], "model.Rdata")
