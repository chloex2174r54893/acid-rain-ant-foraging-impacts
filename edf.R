library(mgcv)
library(gratia)
library(dplyr)

deriv_all <- list()

for (ph in unique(ant_data_interp_finer$pH)) {
  for (quad in unique(ant_data_interp_finer$Quadrant)) {
    df <- ant_data_interp_finer %>% filter(pH == ph, Quadrant == quad)
    model <- gam(Ant_Count_interp ~ s(time_min, k = 10), data = df)
    
    deriv <- derivatives(model, term = "s(time_min)", n = 100)
    deriv$pH <- ph
    deriv$Quadrant <- quad
    
    deriv_all[[length(deriv_all) + 1]] <- deriv
  }
}

deriv_all_df <- bind_rows(deriv_all)

summary_deriv <- deriv_all_df %>%
  group_by(pH, Quadrant) %>%
  summarise(
    mean_abs_deriv = mean(abs(.derivative), na.rm = TRUE),
    sd_deriv = sd(.derivative, na.rm = TRUE),
    range_deriv = max(.derivative, na.rm = TRUE) - min(.derivative, na.rm = TRUE),
    .groups = "drop"
  )

print(summary_deriv, n = Inf)