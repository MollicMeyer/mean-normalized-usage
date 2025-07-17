# README

## GENERAL INFORMATION

**DATA TITLE:**  
Mean Normalized Usage (MNU) of Environmental Covariates for Cubist Soil Property Prediction Models  

**PROJECT TITLE:**  
Digital soil mapping via machine learning of agronomic properties for the full soil profile at within-field resolution  

**DATA ABSTRACT:**  
This dataset and code repository contain the results and scripts used to evaluate the relative importance of environmental covariates across 126 machine learning models predicting a suite of soil agronomic properties for the full soil profile (18 soil properties × 7 depth intervals). Covariate importance is normalized to account for usage frequency of covariate predictors as model rules and linear model coefficients across depth class, covariate type, and analysis scale.

**AUTHORS:**  

Author: Meyer P. Bohn  
Institution: Iowa State University Department of Agronomy  
Email: mpbohn@iastate.edu  

Corresponding author: Bradley A. Miller  
Institution: Iowa State University Department of Agronomy  
Email: millerba@iastate.edu  

**ASSOCIATED PUBLICATIONS:**  
Bohn, M.P., B.A. Miller. 2025. Digital soil mapping via machine learning of agronomic properties for the full soil profile at within-field resolution. Agronomy Journal. (In Press).


**COLLECTION INFORMATION:**  
Time period(s): 2019  
Location(s): Sustainable Advanced Bioeconomy Research Farm, Ames, IA, USA  

---

## CODEBOOK  

**Number Of Variables/Columns:** 14 baseline + 6 generated = 20 total  
**Number Of Cases/Rows:** 10,108  
**Missing Data Codes:** NA  

---

### Columns in the Base Data  

| Column           | Description                                    |
|------------------|------------------------------------------------|
| model_conditions | Percent usage as model rule in decision tree   |
| model_usage      | Percent usage in the multiple linear regression as a coefficient |
| covariate        | Covariate name, analysis scale or year         |
| Deriv            | Remote-sensed derivative type (Terrain or Imagery) |
| type1            | Specific derivative classification             |
| type2            | Generalized derivative classification          |
| stat             | Statistical aggregation method                 |
| year             | Year of remote-sensed data source               |
| prop             | Soil property model and depth                   |
| soil             | Soil property                                   |
| depth_int        | Depth interval (cm)                             |
| depth            | Cleaned depth interval name (cm)                |
| top_depth        | Top depth of depth interval (cm)                |
| bot_depth        | Bottom depth of depth interval (cm)             |

---

### Columns Produced by `mean_normalized_usage()`

| Column               | Description                                               |
|-----------------------|-----------------------------------------------------------|
| analysis.scale        | Analysis scale of covariate (m)                             |
| rel_scale             | Relative verbal scale classification of analysis scale     |
| depth_class           | Verbal scale classification of depth interval              |
| total_usage           | Sum of model_conditions and model_usage                    |
| total_covs            | Total number of covariates in the specific soil x depth model |
| total_usage_scaled    | Min-max normalized value of total_usage                    |
| total_covs_scaled     | Min-max normalized value of total_covs                     |
| normalized_usage      | Product of total_usage_scaled and total_covs_scaled        |
| mean_normalized_usage | Group mean of normalized_usage                             |

---

### Soil Properties Modeled  

| Property   | Description                      | Units   |
|------------|----------------------------------|---------|
| Ca         | Calcium cation                   | mg kg⁻¹ |
| CCE        | Calcium Carbonate Equivalent     | %       |
| CEC        | Cation Exchange Capacity         | cmolc kg⁻¹ |
| cf         | Coarse Fragments                 | %       |
| clay       | Clay Fraction                    | %       |
| EC         | Electrical Conductivity          | dS m⁻¹  |
| K          | Potassium cation                 | mg kg⁻¹ |
| Mg         | Magnesium cation                 | mg kg⁻¹ |
| Na         | Sodium cation                    | mg kg⁻¹ |
| Olsen P    | Olsen Test Phosphorus            | mg kg⁻¹ |
| pH         | pH (1:1 soil water suspension)   | —       |
| sand       | Sand Fraction                    | %       |
| silt       | Silt Fraction                    | %       |
| Cstock     | Soil Organic Carbon Stock        | g cm⁻²  |
| TOC        | Total Organic Carbon             | %       |
| Total N    | Total Nitrogen                   | %       |
| Bray P     | Bray Test Phosphorus             | mg kg⁻¹ |
| buf_pH     | Buffered pH                      | —       |

---

### Covariate Metadata  

| Covariate     | Description                        |
|---------------|------------------------------------|
| CA            | Catchment area                     |
| crosc         | Cross-sectional curvature           |
| CS            | Catchment slope                     |
| HDCN_strahl3_d| Horizontal distance to channel network above Strahler order 3 |
| IR            | Infrared band                       |
| MCA           | Modified catchment area             |
| NAIP          | National Agriculture Imagery Program|
| nnes          | Northness                           |
| plc           | Plan curvature                      |
| prc           | Profile curvature                   |
| rel           | Relative elevation                  |
| slp           | Slope gradient                      |
| SWI           | SAGA wetness index                  |
| tpi           | Topographic position index           |
| wnes          | Westness                             |

---

## METHODS AND MATERIALS  

### DATA COLLECTION METHODS  
Covariate usage data were extracted from Cubist machine learning models via `Cubist::varImp()` predicting soil texture, agronomic soil properties, and organic carbon across standard depth intervals using multi-temporal remote sensing and terrain data at multiple spatial scales. Model outputs were summarized per soil property, depth interval, and covariate.

---

### DATA PROCESSING METHODS  
Cubist’s covariate usage and model conditions served as the proxy for covariate importance in this study. We developed the Mean Normalized Usage (MNU) metric to evaluate covariate importance, which aggregates the contributions of covariates across 126 models (18 soil properties × 7 depth intervals) while accounting for the number of unique predictors used.

We define the total usage (U) for the i-th soil property model as:  
**Uᵢ = Uᵢ(model) + Uᵢ(conditions)** (Equation 2)  
Where Uᵢ(model) is the percentage usage of each covariate in the multiple linear regression model, and Uᵢ(conditions) is the percentage of times the covariate was used as a split in the rule-based decision tree.

The total number of unique covariates (C) used in the i-th model is given by:  
**Cᵢ = n_distinct(Vᵢ)** (Equation 3)  
Where Vᵢ represents the set of covariates used in model i.

To enable comparisons across models on a common scale, we apply min–max normalization for all soil property models (indexed by i):  
**U(scaled, i) = (Uᵢ - min{Uᵢ}) / (max{Uᵢ} - min{Uᵢ})** (Equation 4)  
**C(scaled, i) = (Cᵢ - min{Cᵢ}) / (max{Cᵢ} - min{Cᵢ})** (Equation 5)

The normalized usage (N) for the i-th model is then defined as:  
**Nᵢ = U(scaled, i) × C(scaled, i)** (Equation 6)

This formulation ensures that a higher number of unique covariates coupled with higher usage in the model leads to a higher normalized usage value, enabling a fair comparison across different models.

Because of the hyperdimensionality of the covariate stack (p = 702), the covariates were aggregated into simpler classes (j).  
Terrain attributes were aggregated into five classes of:
- Slope gradient  
- Curvature (plan, profile, cross-sectional)  
- Local relief (topographic position index, relative elevation)  
- Wetness indices (catchment area, modified catchment area, catchment slope, topographic wetness index, SAGA wetness index)  
- Aspect (westness, northness)

Terrain attribute classes were grouped into seven verbal classes approximating analysis scale windows:
- sub-plot (< 15 m)
- plot (15–57 m)
- sub-catchment (57–270 m)
- catchment (270–670 m)
- sub-watershed (670–1,110 m)
- watershed (1,110–3,000 m)
- landscape (3,000–5,070 m)

All 3-m NAIP imagery was statistically aggregated across available years using median, mean, min, max, and std. Additionally, individual single-date images contributing to these statistical aggregations were also used as predictors. These single-date images were grouped into two temporal classes based on infrared band availability: pre-2010 (2004–2009) and post-2010 (2010–2019).

Modeled depth intervals were aggregated into three classes approximating A, B, and C genetic horizons:
- Surface (0–30 cm)
- Mid (30–100 cm)
- Deep (100–200 cm)

To summarize importance for covariates x depth classes (j), we calculate the MNU:  
**Mⱼ = μ({Nᵢ | i ∈ j})** (Equation 7)  
Where:  
- Mⱼ represents the MNU for class j  
- μ denotes the arithmetic mean  
- {Nᵢ | i ∈ j} is the set of normalized usage values for all models and covariates in class j.

---

## INSTALLATION AND EXAMPLE USAGE

This package is not yet available on CRAN. To install it manually from a local directory or GitHub:

```r
# install the package
remotes::install_github("MollicMeyer/meanNormalizedUsage")

# Load the package
library(meanNormalizedUsage)

# Load example data (you must have this file downloaded or included in your repo)
df <- read.csv(system.file("extdata", "cubistusage.csv", package = "meanNormalizedUsage"))

# Clean and normalize
df_mnu <- mean_normalized_usage(df)

# Plot results
plot_mnu(df_mnu)

```
## SOFTWARE  

| Name | Version | URL                           | Developer  |
|------|---------|-------------------------------|------------|
| R    | 4.3+    | https://www.r-project.org/     | R Core Team |

**Required R Packages:**  
`dplyr`, `ggplot2`, `stringr`, `gridExtra`

---

## LICENSING  

This work is licensed under the Creative Commons Attribution (CC-BY) 4.0 International License.  
For more information visit: [https://creativecommons.org/licenses/by/4.0](https://creativecommons.org/licenses/by/4.0)
