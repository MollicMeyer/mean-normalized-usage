Functions
=========

mean_normalized_usage(df)
--------------------------

Compute Mean Normalized Usage (MNU) from Cubist covariate importance.

Parameters:
    df: A data frame like cubistusage.csv with model_conditions, model_usage, covariates, model property, model depth etc.

Returns:
    A processed data frame with normalized_usage and mean_normalized_usage columns.

plot_mnu(df)
------------

Plot Mean Normalized Usage results for terrain and imagery covariates.

Parameters:
    df: Output from mean_normalized_usage() function.

Returns:
    A combined grid plot object.