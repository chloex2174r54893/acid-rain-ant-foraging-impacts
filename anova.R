variables <- c("`OL (avg)`", "`Quadrant 1 (avg)`", "`Quadrant 2 (avg)`", "`Quadrant 3 (avg)`", "`Quadrant 4 (avg)`")

for (var in variables) {
  formula <- as.formula(paste(var, "~ pH"))
  anova_result <- aov(formula, data = ant_data)
  cat("\nANOVA for", var, ":\n")
  print(summary(anova_result))
}