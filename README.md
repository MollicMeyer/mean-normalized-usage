# meanNormalizedUsage

> Author: Meyer P. Bohn, PhD  
> Geospatial Laboratory for Soil Informatics  
> Iowa State University, Department of Agronomy  
> Date: July 9, 2025  

## Overview

Cubist’s covariate usage and model conditions served as the proxy for covariate importance in this study.
We developed the **Mean Normalized Usage (MNU)** metric to evaluate covariate importance, which aggregates the contributions of covariate usage across **126 Cubist models** (18 soil properties × 7 depth intervals) while accounting for the number of unique predictors used.

The MNU formulation ensures that a higher number of unique covariates, coupled with greater usage within each model, results in a higher normalized usage value. 
This allows for fair and interpretable comparisons of covariate influence across different soil properties, depths, and predictor types, even in the presence of high-dimensional and heterogeneously structured input data.

## Installation

This package is not yet available on CRAN. To install it manually from a local directory or GitHub:

```r
# Install from GitHub
# install.packages("remotes")
remotes::install_github("MollicMeyer/meanNormalizedUsage")

# Load the package
library(meanNormalizedUsage)

# Load example data (you must have this file downloaded or included in your repo)
df <- read.csv(system.file("extdata", "cubistusage.csv", package = "meanNormalizedUsage"))

# Clean and normalize
df_processed <- process_mnu(df)

# Plot results
plot_mnu(df_processed)
