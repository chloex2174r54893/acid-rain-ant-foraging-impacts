library(ggplot2)
library(tidyr)
library(dplyr)

ant_data_clean$pH <- as.character(ant_data_clean$pH)
ant_data_clean$pH[is.na(ant_data_clean$pH)] <- "controlled"
ant_data_clean$pH <- factor(ant_data_clean$pH, levels = c("3", "3.3", "3.6", "3.9", "4.2", "4.5", "7", "controlled"))

ant_data_long <- gather(ant_data_clean, key = "Quadrant", value = "Ant_Count", 
                        `Quadrant 1 (avg)`, `Quadrant 2 (avg)`, `Quadrant 3 (avg)`, `Quadrant 4 (avg)`)

ant_data_long$Quadrant <- gsub(" \\(avg\\)", "", ant_data_long$Quadrant)

ggplot(ant_data_long, aes(x = time_min, y = Ant_Count, color = pH, shape = pH, group = pH)) +
  geom_line(size = 1) + 
  geom_point(size = 3, fill = "white") + 
  facet_wrap(~ Quadrant, ncol = 2) +
  scale_color_manual(values = c("3" = "#E69F00",      
                                "3.3" = "#56B4E9",   
                                "3.6" = "#009E73",   
                                "3.9" = "#F0E442",  
                                "4.2" = "#0072B2",   
                                "4.5" = "#D55E00",    
                                "7" = "#CC79A7",    
                                "controlled" = "#000000")) +  
  scale_shape_manual(values = c(16, 17, 18, 15, 8, 3, 4, 7)) + 
  labs(x = expression(bold("Time (minutes)")),
       y = expression(bold("Average Number of Ants"))) +
  theme_minimal(base_size = 16) +
  theme(strip.text = element_text(face = "bold", size = 16),
        axis.text = element_text(face = "bold", size = 14),
        axis.title = element_text(face = "bold", size = 16),
        legend.text = element_text(face = "bold", size = 14),
        legend.title = element_text(face = "bold", size = 16),
        plot.title = element_blank())