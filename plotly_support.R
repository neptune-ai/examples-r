library(neptune)
library(ggplot2)
library(plotly)
neptune_install()

run <- neptune_init(project="common-r/quickstarts", api_token="ANONYMOUS")

data <- data.frame(x = 1:25,
                   y = rnorm(25))

p <- ggplotly(ggplot(data) + geom_point(aes(x = x,
                                   y = y)))

neptune_upload(run["interactive-img"], p)
neptune_upload(run["interactive-img2"], neptune_file_as_html(p))

neptune_stop()
