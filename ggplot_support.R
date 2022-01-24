library(neptune)
library(ggplot2)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

data <- data.frame(x = 1:25,
                   y = rnorm(25))

p <- ggplot(data) + geom_point(aes(x = x,
                                   y = y))

neptune_upload(run["static-img"], p)
neptune_upload(run["static-img-2"], neptune_file_as_image(p))
# additional arguments passed to ggsave via ...
neptune_upload(run["static-img-resized"], neptune_file_as_image(p, units='px', width=900, height=300))
# automatic conversion to plotly via plotly::ggplotly(p)
neptune_upload(run["interactive-img"], neptune_file_as_html(p))

for(i in 1:10) {
  data$prediction <- rnorm(nrow(data))
  p <- ggplot(data) + geom_point(aes(x = prediction,
                                     y = y)) + 
    xlab('prediction') + 
    ylab('actual value')
  neptune_log(run["prediction-img"], p)
}

neptune_stop()
