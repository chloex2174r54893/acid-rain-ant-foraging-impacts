library(ggplot2)

ant_data_clean$pH <- as.character(ant_data_clean$pH)
ant_data_clean$pH[is.na(ant_data_clean$pH)] <- "controlled"
ant_data_clean$pH <- factor(ant_data_clean$pH, levels = c("3", "3.3", "3.6", "3.9", "4.2", "4.5", "7", "controlled"))

quad_colors <- c("Q1" = "#E69F00",  
                 "Q2" = "#56B4E9",
                 "Q3" = "#999999",
                 "Q4" = "#CC79A7")  

ggplot(ant_data_clean, aes(x = time_min)) +
  geom_area(aes(y = `OL (avg)`, fill = "Ant-Acid Overlap"), alpha = 0.3) +
  geom_line(aes(y = `OL (avg)`), color = "#009E73") +  
  
  geom_point(aes(y = `Quadrant 1 (avg)`, color = "Q1"), shape = 16, size = 2) +
  geom_line(aes(y = `Quadrant 1 (avg)`, color = "Q1"), size = 0.8) +
  
  geom_point(aes(y = `Quadrant 2 (avg)`, color = "Q2"), shape = 17, size = 2) +
  geom_line(aes(y = `Quadrant 2 (avg)`, color = "Q2"), size = 0.8) +
  
  geom_point(aes(y = `Quadrant 3 (avg)`, color = "Q3"), shape = 15, size = 2) +
  geom_line(aes(y = `Quadrant 3 (avg)`, color = "Q3"), size = 0.8) +
  
  geom_point(aes(y = `Quadrant 4 (avg)`, color = "Q4"), shape = 18, size = 2) +
  geom_line(aes(y = `Quadrant 4 (avg)`, color = "Q4"), size = 0.8) +
  
  scale_color_manual(values = quad_colors, name = "Quadrant (Q)") +
  scale_fill_manual(name = "", values = c("Ant-Acid Overlap" = "#009E73")) +
  facet_wrap(~pH) +
  labs(x = "Time (minutes)",
       y = "Average Number of Ants / Ant-Acid Overlaps") +
  theme_minimal(base_size = 16) +
  theme(strip.text = element_text(face = "bold", size = 16),
        axis.text = element_text(face = "bold", size = 14),
        axis.title = element_text(face = "bold", size = 16),
        legend.text = element_text(face = "bold", size = 14),
        legend.title = element_text(face = "bold", size = 16),
        plot.title = element_blank())