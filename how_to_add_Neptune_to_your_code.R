library(neptune)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")
parameters <- list(
  'dense_units'= 128,
  'activation'= 'relu',
  'dropout'= 0.23,
  'learning_rate'= 0.15,
  'batch_size'= 64,
  'n_epochs'= 30
)
run['model/parameters'] <- parameters

# Add additional parameters 
run['model/parameters/seed'] <- round(runif(1) * 100)
# Update parameters e.g. after triggering an early stopping
run['model/parameters/n_epochs'] <- parameters[['n_epochs']]

for(epoch in 1:parameters[['n_epochs']]){
  # ...
  # My training loop
  neptune_log(run["train/accuracy"], acc)
  neptune_log(run["train/loss"], loss)
}

# example keras callback
model %>% fit(x_train, y_train, callbacks = list(neptune_callback("tensorflow/keras", run=run)))

#load necessary packages
library(ggplot2)
library(pROC)

#define object to plot and calculate AUC
rocobj <- roc(test$default, predicted)
auc <- round(auc(test$default, predicted),4)

#create ROC plot
p <- ggroc(rocobj, colour = 'steelblue', size = 2) +
  ggtitle(paste0('ROC Curve ', '(AUC = ', auc, ')'))
neptune_upload(run['evaluation/ROC'], p)

for(row in sample_predictions){
  image = row[['image']]
  predicted_label = row[['predicted_label']]
  probabilites = row[['probabilites']]
  description = paste(paste0("class ", probabilites[1], ': ', probabilites[2]), collapse = '\n')
  neptune_log(run['evaluation/predictions'],
              image, 
              name=predicted_label,
              description=description
  )
}

df = data.frame(
  'y_test' = y_test, 
  'y_pred' = y_pred, 
  'y_pred_probability' = apply(y_pred_proba, 1, max)
)
neptune_upload(run['evaluation/predictions'], neptune_file_as_html(df)) # #from neptune.new.types import File, File.as_html(df)

save(model, file='model.Rdata')
neptune_upload(run['model/saved_model'], 'model.Rdata')
