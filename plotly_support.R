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

# Generate dummy data and create a ggplotly plot
library(ggplot2)
library(plotly)

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
