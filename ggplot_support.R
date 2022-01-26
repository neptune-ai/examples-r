library(ggplot2)

# Import Neptune and create a Run
library(neptune)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")


# Generate dummy data and create a ggplot plot
data <- data.frame(x = 1:25,
                   y = rnorm(25))

p <- ggplot(data) + geom_point(aes(x = x,
                                   y = y))

# You can pass ggplot plot directly.
# It will be converted to image and uploaded to Neptune
neptune_upload(run["static-img"], p)

# You can also explicitely convert ggplot plot to an image
neptune_upload(run["static-img-2"], neptune_file_as_image(p))

# If you want to control additional parameters like size of the plot
# you can pass the same arguments as to ggsave
neptune_upload(run["static-img-resized"], p, units='px', width=900, height=300)

# Automatic conversion to interactive plotly chart via plotly::ggplotly(p)
neptune_upload(run["interactive-img"], neptune_file_as_html(p))

# You can also pass ggplot plots when uploading series of images
for(i in 1:10) {
  data$prediction <- rnorm(nrow(data))
  p <- ggplot(data) + geom_point(aes(x = prediction,
                                     y = y)) +
    xlab('prediction') +
    ylab('actual value')
  neptune_log(run["prediction-img"], p)
}

neptune_stop()
