library(ggplot2)
library(plotly)

# Import Neptune and create a Run
library(neptune)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

# Generate dummy data and create a ggplotly plot
data <- data.frame(x = 1:25,
                   y = rnorm(25))

p <- ggplotly(ggplot(data) + geom_point(aes(x = x,
                                   y = y)))

# You can pass ggplotly plot directly.
# It will be converted to an interactive chart and uploaded to Neptune
neptune_upload(run["interactive-img"], p)

# You can also explicitely convert ggplotly plot to an interactive chart
neptune_upload(run["interactive-img2"], neptune_file_as_html(p))

neptune_stop()
