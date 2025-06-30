library(dplyr)
library(mgcv)
library(ggplot2)
library(tidyr)

new_time_points_finer <- seq(min(ant_data_clean$time_min), max(ant_data_clean$time_min), by = 0.25) 
quadrant_columns <- c("Quadrant 1 (avg)", "Quadrant 2 (avg)",  
                      "Quadrant 3 (avg)", "Quadrant 4 (avg)") 
ant_data_interp_finer <- data.frame() 

for (quadrant in quadrant_columns) { 
  for (ph in unique(ant_data_clean$pH)) { 
    subset_data <- ant_data_clean %>% filter(pH == ph) 
    temp_data_interp <- data.frame(time_min = new_time_points_finer) 
    temp_data_interp$Ant_Count_interp <- approx( 
      subset_data$time_min, subset_data[[quadrant]],  
      xout = temp_data_interp$time_min 
    )$y 
    temp_data_interp$pH <- ph 
    temp_data_interp$Quadrant <- quadrant 
    ant_data_interp_finer <- rbind(ant_data_interp_finer, temp_data_interp) 
  } 
} 

plot_data <- data.frame() 
for (ph in unique(ant_data_interp_finer$pH)) { 
  for (quadrant in unique(ant_data_interp_finer$Quadrant)) { 
    df <- ant_data_interp_finer %>% filter(pH == ph, Quadrant == quadrant) 
    gam_model <- gam(Ant_Count_interp ~ s(time_min, k = 10), data = df) 
    df_fitted <- data.frame( 
      time_min = df$time_min, 
      Ant_Count_fitted = predict(gam_model, newdata = df), 
      pH = ph, 
      Quadrant = quadrant 
    ) 
    plot_data <- rbind(plot_data, df_fitted) 
  } 
} 