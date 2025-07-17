#' Mean Normalized Usage (MNU) Analysis for Cubist Model Covariates
#'
#' @author Meyer P. Bohn, PhD
#' Geospatial Laboratory for Soil Informatics
#' Iowa State University, Department of Agronomy
#' Date: July 9, 2025
#'
#' @description
#' Computes Mean Normalized Usage (MNU) for covariates used in Cubist-based soil property models.
#' It accounts for both covariate frequency and model diversity, summarized by analysis scale,
#' depth class, and statistical aggregation of terrain and imagery covariates.
#'
#' @details
#' This function reads a Cubist covariate importance table and calculates
#' normalized usage values by covariate group, analysis scale, depth class,
#' and statistical aggregation of terrain and imagery covariates.
#'
#' @param df A data frame like `cubistusage.csv` with columns such as `model_conditions`,
#' `model_usage`, `covariates`, `model property`, `model depth`, etc.
#' @return A processed data frame with `normalized_usage` and `mean_normalized_usage` columns.
#' @export
mean_normalized_usage <- function(df) {
  library(dplyr)
  library(stringr)

  extract_analysis_scale <- function(covariate) {
    str_extract(covariate, "(?<=_)[0-9]+(?=m)")
  }

  df <- df %>%
    mutate(
      analysis.scale = as.numeric(extract_analysis_scale(covariate)),
      analysis.scale = ifelse(
        is.na(analysis.scale) & Deriv == "Imagery",
        3,
        analysis.scale
      ),
      analysis.scale = ifelse(covariate == "TWI30m", 30, analysis.scale),
      analysis.scale = ifelse(
        covariate == "HDCN_strahl3_d",
        10,
        analysis.scale
      ),
      rel_scale = case_when(
        analysis.scale < 15 ~ "sub-plot",
        analysis.scale < 57 ~ "plot",
        analysis.scale < 270 ~ "subcatchment",
        analysis.scale < 670 ~ "catchment",
        analysis.scale < 1110 ~ "subwatershed",
        analysis.scale <= 3000 ~ "watershed",
        analysis.scale <= 5070 ~ "landscape",
        TRUE ~ NA_character_
      ),
      depth_class = case_when(
        bot_depth <= 30 ~ "Surface",
        bot_depth <= 100 ~ "Mid",
        bot_depth <= 200 ~ "Deep",
        TRUE ~ NA_character_
      )
    ) %>%
    filter((model_usage + model_conditions) > 0) %>%
    mutate(
      total_usage = model_usage + model_conditions
    ) %>%
    group_by(prop) %>%
    mutate(total_covs = n_distinct(covariate)) %>%
    ungroup() %>%
    mutate(
      total_usage_scaled = (total_usage - min(total_usage, na.rm = TRUE)) /
        (max(total_usage, na.rm = TRUE) - min(total_usage, na.rm = TRUE)),
      total_covs_scaled = (total_covs - min(total_covs, na.rm = TRUE)) /
        (max(total_covs, na.rm = TRUE) - min(total_covs, na.rm = TRUE)),
      normalized_usage = total_usage_scaled * total_covs_scaled
    ) %>%
    mutate(
      group_key = case_when(
        Deriv == "Terrain" ~ as.character(rel_scale),
        Deriv == "Imagery" ~ as.character(stat),
        TRUE ~ NA_character_
      )
    ) %>%
    group_by(Deriv, depth_class, group_key) %>%
    mutate(mean_normalized_usage = mean(normalized_usage, na.rm = TRUE)) %>%
    ungroup() %>%
    select(-group_key)

  # Order factor levels
  df$rel_scale <- factor(
    df$rel_scale,
    levels = c(
      "sub-plot",
      "plot",
      "subcatchment",
      "catchment",
      "subwatershed",
      "watershed",
      "landscape"
    ),
    ordered = TRUE
  )

  df$depth_class <- factor(df$depth_class, levels = c("Surface", "Mid", "Deep"))

  df <- df %>%
    mutate(
      year_numeric = suppressWarnings(as.numeric(year)),
      stat = case_when(
        stat == "none" & year_numeric < 2010 ~ "pre-2010",
        stat == "none" & year_numeric >= 2010 ~ "post-2010",
        TRUE ~ stat
      )
    ) %>%
    select(-year_numeric)

  df$stat <- factor(
    df$stat,
    levels = c(
      "pre-2010",
      "post-2010",
      "none",
      "std",
      "min",
      "max",
      "mean",
      "median"
    )
  )

  df$type2 <- factor(
    df$type2,
    levels = c(
      "red",
      "green",
      "blue",
      "infrared",
      "ndvi",
      "slope gradient",
      "curvature",
      "local relief",
      "wetness indices",
      "channel proximity",
      "aspect"
    )
  )

  return(df)
}
