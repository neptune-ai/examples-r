library(neptune)
neptune_install()

run_table_df <- neptune_fetch_runs_table(project="<YOUR_WORKSPACE/YOUR_PROJECT>")

head(run_table_df)
