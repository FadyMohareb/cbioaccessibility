# Load required libraries
library(readr)
library(tidyr)
library(dplyr)
library(multcompView)
library(multcomp)
library(emmeans)

setwd("C:\\Users\\acast\\Desktop\\Kevin_PhD\\YearTwo\\Article writing combined")

# Replace 'your_file.csv' with the actual path to your CSV file
data <- read_csv("forAutoML_v12_noinulinbulk_grubbs.csv")

# Remove Grubbs outliers and change name of Supplement to include matrix type
data <- data[-97, ]
data <- data[-129, ]
data <- data[-139, ]
data$Supplement <- ifelse(data$`Water%` > 0.5, paste(data$Supplement, "_custard", sep = ""), paste(data$Supplement, "_biscuit", sep = ""))

# set up model
model <- lm(bioaccessibility ~ Supplement, data = data)

# get (adjusted) weight means per group
model_means <- emmeans(object = model,
                       specs = "Supplement")

# add letters to each mean
model_means_cld <- cld(object = model_means,
                       adjust = "Tukey",
                       Letters = letters,
                       alpha = 0.05)

data$Supplement

