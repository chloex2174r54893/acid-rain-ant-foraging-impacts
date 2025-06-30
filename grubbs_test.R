install.packages("outliers")
library(outliers)

numeric_vars <- sapply(ant_data, is.numeric)
outliers_results <- lapply(ant_data[, numeric_vars], function(x) grubbs.test(x))

outliers_results