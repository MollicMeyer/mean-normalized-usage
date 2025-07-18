Mean Normalized Usage (MNU)
============================

GENERAL INFORMATION
--------------------

**DATA TITLE:**  
Mean Normalized Usage (MNU) of Environmental Covariates for Cubist Soil Property Prediction Models  

**PROJECT TITLE:**  
Digital soil mapping via machine learning of agronomic properties for the full soil profile at within-field resolution  

**DATA ABSTRACT:**  
This dataset and code repository contain the results and scripts used to evaluate the relative importance of environmental covariates across 126 machine learning models predicting a suite of soil agronomic properties for the full soil profile (18 soil properties × 7 depth intervals). Covariate importance is normalized to account for usage frequency of covariate predictors as model rules and linear model coefficients across depth class, covariate type, and analysis scale.


AUTHORS
-------

Meyer P. Bohn  
Iowa State University Department of Agronomy  
mpbohn@iastate.edu  

Bradley A. Miller  
Iowa State University Department of Agronomy  
millerba@iastate.edu  


ASSOCIATED PUBLICATIONS
------------------------

Bohn, M.P., B.A. Miller. 2025. Digital soil mapping via machine learning of agronomic properties for the full soil profile at within-field resolution. *Agronomy Journal.* (In Press)


COLLECTION INFORMATION
-----------------------

Time period(s): 2019  
Location(s): Sustainable Advanced Bioeconomy Research Farm, Ames, IA, USA  


CODEBOOK
--------

**Number Of Variables/Columns:** 14 baseline + 6 generated = 20 total  
**Number Of Cases/Rows:** 10,108  
**Missing Data Codes:** NA  



Columns in the Base Data
^^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table:: Columns in the Base Data
   :header: "Column", "Description"
   :widths: 20, 80

   model_conditions, Percent usage as model rule in decision tree
   model_usage, Percent usage in the multiple linear regression as a coefficient
   covariate, Covariate name, analysis scale or year
   Deriv, Remote-sensed derivative type (Terrain/Imagery)
   type1, Specific derivative classification
   type2, Generalized derivative classification
   stat, Statistical aggregation method
   year, Year of remote-sensed data source
   prop, Soil property model and depth
   soil, Soil property
   depth_int, Depth interval (cm)
   depth, Cleaned depth interval name (cm)
   top_depth, Top depth of depth interval (cm)
   bot_depth, Bottom depth of depth interval (cm)


Columns Produced by ``mean_normalized_usage()``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table:: Columns Produced by ``mean_normalized_usage()``
   :header: "Column", "Description"
   :widths: 25, 75

   analysis.scale, Analysis scale of covariate (m)
   rel_scale, Relative verbal scale classification of analysis scale
   depth_class, Verbal scale classification of depth interval
   total_usage, Sum of model_conditions and model_usage
   total_covs, Total number of covariates in the soil x depth model
   total_usage_scaled, Min-max normalized value of total_usage
   total_covs_scaled, Min-max normalized value of total_covs
   normalized_usage, Product of total_usage_scaled and total_covs_scaled
   mean_normalized_usage, Group mean of normalized_usage


Soil Properties Modeled
^^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table:: Soil Properties Modeled
   :header: "Property", "Description", "Units"
   :widths: 15, 60, 15

   Ca, Calcium cation, mg kg⁻¹
   CCE, Calcium Carbonate Equivalent, %
   CEC, Cation Exchange Capacity, cmolc kg⁻¹
   cf, Coarse Fragments, %
   clay, Clay Fraction, %
   EC, Electrical Conductivity, dS m⁻¹
   K, Potassium cation, mg kg⁻¹
   Mg, Magnesium cation, mg kg⁻¹
   Na, Sodium cation, mg kg⁻¹
   Olsen P, Olsen Test Phosphorus, mg kg⁻¹
   pH, pH (1:1 soil water suspension), —
   sand, Sand Fraction, %
   silt, Silt Fraction, %
   Cstock, Soil Organic Carbon Stock, g cm⁻²
   TOC, Total Organic Carbon, %
   Total N, Total Nitrogen, %
   Bray P, Bray Test Phosphorus, mg kg⁻¹
   buf_pH, Buffered pH, —


Covariate Metadata
^^^^^^^^^^^^^^^^^^^

.. csv-table:: Covariate Metadata
   :header: "Covariate", "Description"
   :widths: 25, 75

   CA, Catchment area
   crosc, Cross-sectional curvature
   CS, Catchment slope
   HDCN_strahl3_d, Horizontal distance to channel network (Strahler 3)
   IR, Infrared band
   MCA, Modified catchment area
   NAIP, National Agriculture Imagery Program
   nnes, Northness
   plc, Plan curvature
   prc, Profile curvature
   rel, Relative elevation
   slp, Slope gradient
   SWI, SAGA wetness index
   tpi, Topographic position index
   wnes, Westness


CONTENTS
--------

.. toctree::
   :maxdepth: 2
   :caption: Contents

   usage
   functions
