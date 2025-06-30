# Potential ethological impacts of acid rain on ant foraging behavior and movement patterns in polluted regions

This repository contains the code and data analysis for a student-led research project investigating the effect of acid rain (simulated using sulfuric acid) on ant foraging behavior and movement patterns. The study focused on how varying pH levels influence ant distribution, acid contact, and activity over time.

## Overview
Acid rain is a major ecological stressor in polluted regions. This project aimed to examine how increasing environmental acidity affects the risk-taking and movement behavior of ants, using Rhytidoponera metallica as a model species.

## Methods
- **pH treatments**: 3, 3.3, 3.6, 3.9, 4.2, 4.5, 7 (distilled water), and a controlled group (no liquid)
- **Data collection**: Ant counts per quadrant per minute and ant-acid overlaps
- **Tools used**:  
  - R for data analysis and visualization  
  - PASCO Wireless pH Sensor (Model PS-3204)

## Analysis
- Outlier removal using Grubbs' Test  
- ANOVA for group comparisons  
- Time-based interpolation and smoothing using Generalized Additive Models (GAMs)  
- First derivative analysis to study changes in movement over time
