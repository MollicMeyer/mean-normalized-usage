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
# install from local directory
devtools::install("path/to/meanNormalizedUsage")

# or if published to GitHub in future:
devtools::install_github("your_username/meanNormalizedUsage")
