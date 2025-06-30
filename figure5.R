library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpattern)

ant_data_clean$pH <- as.character(ant_data_clean$pH)
ant_data_clean$pH[is.na(ant_data_clean$pH)] <- "controlled"
ant_data_clean$pH[ant_data_clean$pH == "0M"] <- "controlled"
ant_data_clean$pH <- factor(ant_data_clean$pH, levels = c("3", "3.3", "3.6", "3.9", "4.2", "4.5", "7", "controlled"))

ant_percent <- ant_data_clean %>%
  mutate(Total = `Quadrant 1 (avg)` + `Quadrant 2 (avg)` + `Quadrant 3 (avg)` + `Quadrant 4 (avg)`) %>%
  mutate(
    Q1 = (`Quadrant 1 (avg)` / Total) * `OL (avg)`,
    Q2 = (`Quadrant 2 (avg)` / Total) * `OL (avg)`,
    Q3 = (`Quadrant 3 (avg)` / Total) * `OL (avg)`,
    Q4 = (`Quadrant 4 (avg)` / Total) * `OL (avg)`
  )

ant_long <- ant_percent %>%
  select(pH, Q1, Q2, Q3, Q4) %>%
  pivot_longer(
    cols = c(Q1, Q2, Q3, Q4),
    names_to = "Quadrant",
    values_to = "OL_Contribution"
  )
ggplot(ant_long, aes(x = pH, y = OL_Contribution, fill = Quadrant, pattern = Quadrant)) +
  geom_bar_pattern(stat = "identity",
                   pattern_fill = "black",
                   pattern_angle = 45,
                   pattern_density = 0.2,
                   pattern_spacing = 0.03,
                   pattern_key_scale_factor = 0.6,
                   position = "stack") +
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
  labs(
    x = "pH Level",
    y = "Average Number of Ant-Acid Overlaps",
    fill = "Quadrant (Q)",
    pattern = "Quadrant (Q)"
  ) +
  theme_minimal(base_size = 16) +
  theme(
    axis.text = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold", size = 16),
    legend.text = element_text(face = "bold", size = 14),
    legend.title = element_text(face = "bold", size = 16),
    plot.title = element_blank()
  )
