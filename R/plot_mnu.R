#' Plot Mean Normalized Usage (MNU) results for terrain and imagery covariates
#'
#' Creates side-by-side ggplot2 bar charts showing MNU grouped by analysis scale
#' or temporal/statistical aggregation, faceted by depth class.
#'
#' @param df Output from `mean_normalized_usage()` function.
#' @return A combined grid plot object.
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
      plot_imagery <- ggplot(dat_img,
                             aes(x = stat, y = mean_normalized_usage, fill = type2)) +
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
      plot_terrain <- ggplot(dat_ter,
                             aes(x = rel_scale, y = mean_normalized_usage, fill = type2)) +
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
