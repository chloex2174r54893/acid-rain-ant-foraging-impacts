new_time_points_finer <- seq(min(ant_data_clean$time_min), max(ant_data_clean$time_min), by = 0.25)
quadrant_columns <- c("Quadrant 1 (avg)", "Quadrant 2 (avg)", "Quadrant 3 (avg)", "Quadrant 4 (avg)")
ant_data_interp_finer <- data.frame()

for (quadrant in quadrant_columns) {
  for (ph in unique(ant_data_clean$pH)) {
    # Filter the data for the specific pH level and quadrant
    subset_data <- ant_data_clean %>% filter(pH == ph)

    temp_data_interp <- data.frame(time_min = new_time_points_finer)
    
    temp_data_interp$Ant_Count_interp <- approx(subset_data$time_min, subset_data[[quadrant]], 
                                                xout = temp_data_interp$time_min)$y
    
    temp_data_interp$pH <- ph
    temp_data_interp$Quadrant <- quadrant
    
    ant_data_interp_finer <- rbind(ant_data_interp_finer, temp_data_interp)
  }
}
head(ant_data_interp_finer)
nrow(ant_data_interp_finer)


library(mgcv)
library(dplyr)
library(ggplot2)
library(tidyr)
plot_data <- data.frame()

for (ph in unique(ant_data_interp_finer$pH)) {
  for (quadrant in unique(ant_data_interp_finer$Quadrant)) {
    df <- ant_data_interp_finer %>% 
      filter(pH == ph, Quadrant == quadrant)
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

ggplot(plot_data, aes(x = time_min, y = Ant_Count_fitted, color = pH)) +
  geom_line(size = 1) +
  facet_wrap(~ Quadrant, scales = "fixed", ncol = 2) +
  labs(x = "Time (min)", y = "Number of Ants") +
  scale_color_manual(values = c("3" = "#E69F00",      
                                "3.3" = "#56B4E9",   
                                "3.6" = "#009E73",   
                                "3.9" = "#F0E442",  
                                "4.2" = "#0072B2",   
                                "4.5" = "#D55E00",    
                                "7" = "#CC79A7",    
                                "controlled" = "#000000")) +
  theme_minimal(base_size = 16) +
  theme(strip.text = element_text(face = "bold", size = 16),
        axis.text = element_text(face = "bold", size = 14),
        axis.title = element_text(face = "bold", size = 16),
        legend.text = element_text(face = "bold", size = 14),
        legend.title = element_text(face = "bold", size = 16),
        plot.title = element_blank())
