#' Plot Mean Normalized Usage (MNU) Results
#'
#' @author Meyer P. Bohn, PhD
#' Geospatial Laboratory for Soil Informatics
#' Iowa State University, Department of Agronomy
#' Date: July 9, 2025
#'
#' @description
#' Creates side-by-sideggplot2 bar charts showing Mean Normalized Usage (MNU)
#' grouped by either analysis scale (terrain-derived covariates) or temporal/statistical
#' aggregation (imagery-derived covariates), faceted by depth class.
#'
#' @details
#' This function visualizes normalized covariate usage across soil depths and covariate groups.
#' Plots are returned as a combinedpatchwork object for easy customization or export.
#'
#' @param df A data frame output frommean_normalized_usage() with fields
#' including Deriv, depth_class, rel_scale, stat, and mean_normalized_usage.
#'
#' @return Aggplot2 object (patchwork grid of plots) showing MNU patterns across depth classes.
#'
#' @examples
#' # Example usage:
#' df_mnu <- mean_normalized_usage(your_data)
#' plot_MNU(df_mnu)
#'
#' @export

plot_mnu <- function(df) {
  library(ggplot2)
  library(gridExtra)
  library(dplyr)

  # Colorblind-safe palettes
  imagery_colors <- c(
    "red" = "#D55E00",
    "green" = "#009E73",
    "blue" = "#56B4E9",
    "infrared" = "#999999",
    "ndvi" = "#E69F00"
  )

  terrain_colors <- c(
    "slope gradient" = "#56B4E9",
    "curvature" = "#D55E00",
    "local relief" = "#F0E442",
    "wetness indices" = "#009E73",
    "aspect" = "#CC79A7",
    "channel proximity" = "#999999"
  )

  for (soil_var in unique(df$soil)) {
    dat <- df %>% filter(soil == soil_var)

    has_imagery <- any(dat$Deriv == "Imagery")
    has_terrain <- any(dat$Deriv == "Terrain")

    # Create plots conditionally
    plot_imagery <- NULL
    plot_terrain <- NULL

    if (has_imagery) {
      dat_img <- dat[dat$Deriv == "Imagery", ]
      plot_imagery <- ggplot(
        dat_img,
        aes(x = stat, y = mean_normalized_usage, fill = type2)
      ) +
        geom_col(position = "stack") +
        facet_grid(depth_class ~ ., space = "free", scales = "free_y") +
        coord_flip() +
        scale_fill_manual(values = imagery_colors) +
        labs(
          y = "Mean Normalized Usage",
          x = "Statistic/Year",
          title = paste("3-m NAIP Imagery:", soil_var)
        ) +
        theme_minimal() +
        theme(
          legend.position = "right",
          legend.title = element_blank(),
          legend.text = element_text(size = 12),
          axis.text = element_text(size = 11),
          axis.title = element_text(size = 13),
          strip.text = element_text(size = 13)
        )
    }

    if (has_terrain) {
      dat_ter <- dat[dat$Deriv == "Terrain", ]
      plot_terrain <- ggplot(
        dat_ter,
        aes(x = rel_scale, y = mean_normalized_usage, fill = type2)
      ) +
        geom_col(position = "stack") +
        facet_grid(depth_class ~ ., space = "free", scales = "free_y") +
        coord_flip() +
        scale_x_discrete(name = "Analysis Scale", drop = FALSE) +
        scale_fill_manual(values = terrain_colors) +
        labs(
          y = "Mean Normalized Usage",
          x = "Analysis Scale",
          title = paste("Terrain:", soil_var)
        ) +
        theme_minimal() +
        theme(
          legend.position = "right",
          legend.title = element_blank(),
          legend.text = element_text(size = 12),
          axis.text = element_text(size = 11),
          axis.title = element_text(size = 13),
          strip.text = element_text(size = 13)
        )
    }

    # Display what exists
    if (!is.null(plot_imagery) && !is.null(plot_terrain)) {
      grid.arrange(plot_imagery, plot_terrain, ncol = 2)
    } else if (!is.null(plot_imagery)) {
      grid.arrange(plot_imagery)
    } else if (!is.null(plot_terrain)) {
      grid.arrange(plot_terrain)
    } else {
      message(paste("No data for:", soil_var))
    }
  }
}
