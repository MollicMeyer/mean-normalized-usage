Usage
=====

Installation and Example Usage
-------------------------------

This package is not yet available on CRAN. To install it manually from a local directory or GitHub, use the following workflow:

.. code-block:: r

    # Load the package
    library(meanNormalizedUsage)

    # Load example data (you must have this file downloaded or included in your repo)
    df <- read.csv(system.file("extdata", "cubistusage.csv", package = "meanNormalizedUsage"))

    # Clean and normalize
    df_mnu <- mean_normalized_usage(df)

    # Plot results
    plot_mnu(df_mnu)


Software
--------

+------+---------+----------------------------+-------------+
| Name | Version | URL                        | Developer   |
+======+=========+============================+=============+
| R    | 4.3+    | https://www.r-project.org/ | R Core Team |
+------+---------+----------------------------+-------------+

Required R Packages:
``dplyr``, ``ggplot2``, ``stringr``, ``gridExtra``


Licensing
---------

This work is licensed under the Creative Commons Attribution (CC-BY) 4.0 International License.  
For more information visit: https://creativecommons.org/licenses/by/4.0
