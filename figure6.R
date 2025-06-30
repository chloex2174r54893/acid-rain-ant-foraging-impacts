ant_data_clean %>%
  group_by(pH) %>%
  summarise(
    SD_Q1 = sd(diff(`Quadrant 1 (avg)`)),
    SD_Q2 = sd(diff(`Quadrant 2 (avg)`)),
    SD_Q3 = sd(diff(`Quadrant 3 (avg)`)),
    SD_Q4 = sd(diff(`Quadrant 4 (avg)`))
  )

library(tidyr)
library(ggplot2)

sd_data <- tibble::tibble(
  pH = factor(c("3", "3.3", "3.6", "3.9", "4.2", "4.5", "7", "controlled"), 
              levels = c("3", "3.3", "3.6", "3.9", "4.2", "4.5", "7", "controlled")),
  SD_Q1 = c(0.609, 0.471, 0.319, 0.793, 0.609, 0.694, 1.10, 1.04),
  SD_Q2 = c(0.569, 0.319, 0.272, 1.29, 0.882, 1.04, 2.03, 1.22),
  SD_Q3 = c(0, 0.577, 0, 0.687, 0.918, 0.544, 0.805, 1.64),
  SD_Q4 = c(0.167, 0.167, 0.167, 0.192, 0.544, 1.22, 0.667, 0.319)
)

sd_long <- pivot_longer(sd_data, cols = starts_with("SD_"), 
                        names_to = "Quadrant", values_to = "SD")
sd_long$Quadrant <- factor(sd_long$Quadrant,
                           levels = c("SD_Q1", "SD_Q2", "SD_Q3", "SD_Q4"),
                           labels = c("Q1", "Q2", "Q3", "Q4"))

#A
ggplot(sd_long, aes(x = pH, y = SD, fill = Quadrant, pattern = Quadrant)) +
  geom_bar_pattern(stat = "identity", position = "dodge",
                   pattern_fill = "black",
                   pattern_angle = 45,
                   pattern_density = 0.2,   
                   pattern_spacing = 0.03,    
                   pattern_key_scale_factor = 0.6) +
  scale_fill_manual(values = c(
    "Q1" = "#E69F00",
    "Q2" = "#56B4E9",
    "Q3" = "#999999",
    "Q4" = "#CC79A7"
  )) +
  scale_pattern_manual(values = c(
    "Q1" = "stripe",
    "Q2" = "circle",
    "Q3" = "crosshatch",
    "Q4" = "none"
  )) +
  labs(x = "pH Level",
       y = "Standard Deviation of the Number of Ants",
       fill = "Quadrant (Q)",
       pattern = "Quadrant (Q)") +
  theme_minimal(base_size = 16) +
  theme(
    strip.text = element_text(face = "bold", size = 16),
    axis.text = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold", size = 16),
    legend.text = element_text(face = "bold", size = 14),
    legend.title = element_text(face = "bold", size = 16),
    plot.title = element_blank()
  )

#B
ggplot(sd_long, aes(x = pH, y = SD, group = Quadrant, color = Quadrant, shape = Quadrant)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = c(
    "Q1" = "#E69F00",
    "Q2" = "#56B4E9",
    "Q3" = "#999999",
    "Q4" = "#CC79A7"
  )) +
  scale_shape_manual(values = c(
    "Q1" = 16,  # circle
    "Q2" = 17,  # triangle
    "Q3" = 15,  # square
    "Q4" = 18   # diamond
  )) +
  labs(x = "pH Level",
       y = "Standard Deviation of the Number of Ants",
       color = "Quadrant (Q)",
       shape = "Quadrant (Q)") +
  theme_minimal(base_size = 16) +
  theme(
    axis.text = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold", size = 16),
    legend.text = element_text(face = "bold", size = 14),
    legend.title = element_text(face = "bold", size = 16),
    plot.title = element_blank()
  )