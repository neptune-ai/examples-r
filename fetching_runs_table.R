library(neptune)
neptune_install()

# Fetch Runs table for "common-r/quickstarts" project
run_table_df <- neptune_fetch_runs_table(project="common-r/quickstarts", api_token="ANONYMOUS")

# The data is in form of data frame
head(run_table_df)
