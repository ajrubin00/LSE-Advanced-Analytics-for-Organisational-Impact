# ASSIGNMENT - ASAF RUBIN

################################################################################
###############################################################################

# ASSIGNMENT ACTIVITY 4: VISUALISE DATA TO GATHER INSIGHTS

# SCENARIO:
# The sales department of Turtle games prefers R to Python. As you can perform 
# data analysis in R, you will explore and prepare the data set for analysis by 
# utilising basic statistics and plots. 

# OBJECTIVE:

# Determine what insights can you gather from scatterplots, histograms, and 
# boxplots about the data set. Explore the data and comment on the insights 
# gained from your exploratory data analysis. For example, outliers, missing 
# values, distribution of data.

################################################################################

# Prepare workstation & explore the data

# Install and import Tidyverse.
install.packages('tidyverse')
library(tidyverse)

# Set the working directory
# Import the data set.
sales <- read.csv('turtle_sales.csv', header=TRUE)

# Explore the data
head(sales)
as_tibble(sales)
glimpse(sales)
summary(sales)
str(sales)

# Look for missing values
is.na(sales)
sum(is.na(sales))

# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns (Ranking, Year, Genre, Publisher)
sales2 <- select(sales, -Ranking, -Year, -Genre, -Publisher)

# View the data frame.
head(sales2)

# View the descriptive statistics.
summary(sales2)
dim(sales2)

# Explore the Platform column in a table
table(sales2$Platform)

################################################################################

# Review plots to determine insights into the data set.

## Scatterplots

# Install and load gridextra to plot two scatterplots on a grid
install.packages("gridExtra")
library(gridExtra)

# Create scatterplot of EU Sales vs. Global Sales
plot1 <- qplot(y = EU_Sales, data = sales2)

# Create scatterplot of NA Sales vs. Global Sales
plot2 <- qplot(y = NA_Sales, data = sales2)

# Combine the  plots side by side
grid.arrange(plot1, plot2, ncol = 2)

# The above charts show that sales in EU and NA are similarly distributed,
# and both positively skewed, but there are more outliers in the NA_Sales, 
# representing those games with exceptionally high sales. These are likley 
# the most popular games generating a large portion of overall sales, while
# the majority of games have more modest sales. 

# Create a scatterplot of global sales
plot3 <-  qplot(y=Global_Sales, data=sales2)

# Combine all scatterplots
grid.arrange(plot1, plot2, plot3, ncol = 3)

# This chart reflects the previous, showing one significant outlier from NA. 

# Create a scatterplot of platform vs. Global Sales
qplot(x=Global_Sales, y=Platform, data=sales2)

# The sales distribution across platforms shows the significant outlier for the
# Wii platform, and other strong performers for Wii, NES, GB and DS. The
# majority of other platforms are mostly clustered between 0 - 20 on the X-axis.
# XBox360, Wii and PS3 seem to have a lot more games than other platforms.

## Histograms

# Global Sales
hist1 <- qplot(Global_Sales, bins=20, data=sales2)

# EU Sales
hist2 <- qplot(EU_Sales, bins=20, data=sales2)

# NA Sales
hist3 <- qplot(NA_Sales, bins=20, data=sales2)

# Plot all histograms at once
grid.arrange(hist1, hist2, hist3, ncol=3)


# Platform
qplot(Platform, data=sales2)

# The histograms show that the sales data is concentrated in the lower range, 
# with some outliers in the higher range, confirming the results of the 
# scatterplots. The platform histogram shows that the X360 is the most common
# platform, follow by the PS2 and the PC. The 2600 and the GEN are the least
# common platforms. 

## Boxplots

# Global Sales vs. Platform
box1 <- qplot(Global_Sales, Platform, data=sales2, geom='boxplot')

# EU Sales vs. Platform
box2 <- qplot(NA_Sales, Platform, data=sales2, geom='boxplot')

# NA Sales vs. Platform
box3 <- qplot(EU_Sales, Platform, data=sales2, geom='boxplot')

# Combine boxplots
grid.arrange(box1, box2, box3, ncol=3)

# The boxplots show the distribution and central tendency for sales for each
# platform. Globally, the PS4 and Wii have the highest median but the Wii has
# the most outliers. The NES has the furthest upper quartile, which
# means the platform has a wider range of higher sales values. This is 
# especially pronounced in the EU.

# Additional analysis: what is the impact that each product has on sales?

# Calculate total sales for each product, across regions
product_sales <- sales2 %>%
  group_by(Product) %>%
  summarise(
    Total_NA_Sales = sum(NA_Sales),
    Total_EU_Sales = sum(EU_Sales),
    Total_Global_Sales = sum(Global_Sales)
  ) %>%
  arrange(desc(Total_Global_Sales))

# What are the top 10 selling products?

# Set the number of top products to display
top_n <- 10

# Filter the top products based on sales
top_products <- product_sales %>%
  arrange(desc(Total_Global_Sales)) %>%
  head(top_n)

# Visualise NA Sales
NAplot <- ggplot(top_products, aes(x = reorder(Product, Total_NA_Sales), 
                                   y = Total_NA_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top NA Sales by Product", x = "Product", y = "NA Sales") +
  theme_minimal()

# Visualise EU Sales
EUplot <- ggplot(top_products, aes(x = reorder(Product, Total_EU_Sales), 
                                   y = Total_EU_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top EU Sales by Product", x = "Product", y = "EU Sales") +
  theme_minimal()

# Visualise Global Sales
Globalplot <- ggplot(top_products, aes(x = reorder(Product, Total_Global_Sales),
                                       y = Total_Global_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top Global Sales by Product", x = "Product", 
       y = "Global Sales") +
  theme_minimal()

grid.arrange(NAplot, EUplot, Globalplot, ncol=3)

# The top 10 highest selling products were isolated and plotted for each 
# region. The product with ID 107 is the highest selling product across all
# regions. Product 515 is the second highest selling product in EU and globally,
# but only the fourth highest selling product in NA. Product 123 is the second
# highest selling product in NA and the third highest selling product globally.
# Product 254 is the fourth highest selling product globally and the third
# highest selling in NA, but only the 10th highest selling product in EU. 

# What are the lowest 10 selling products?

# Filter the lowest products based on sales
lowest_products <- product_sales %>%
  arrange(Total_Global_Sales) %>%
  head(top_n)

# Visualise NA Sales
NAplot_low <- ggplot(lowest_products, aes(x = reorder(Product, Total_NA_Sales),
                                          y = Total_NA_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Lowest NA Sales by Product", x = "Product", y = "NA Sales") +
  theme_minimal()

# Visualise EU Sales
EUplot_low <- ggplot(lowest_products, aes(x = reorder(Product, Total_EU_Sales),
                                          y = Total_EU_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Lowest EU Sales by Product", x = "Product", y = "EU Sales") +
  theme_minimal()

# Visualise Global Sales
Globalplot_low <- ggplot(lowest_products, aes(x = reorder(Product, 
                                                          Total_Global_Sales), 
                                              y = Total_Global_Sales)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Lowest Global Sales by Product", x = "Product", 
       y = "Global Sales") +
  theme_minimal()

grid.arrange(NAplot_low, EUplot_low, Globalplot_low, ncol=3)


################################################################################
###############################################################################

# ASSIGNMENT ACTIVITY 5: CLEAN, MANIPULATE AND VISUALISE THE DATA

## Load and explore the data

# View data frame created in Week 4.
view(sales2)
head(sales2)

# Check output: Determine the min, max, and mean values.
summary(sales2[c("NA_Sales", "EU_Sales", "Global_Sales")])

# View the descriptive statistics.
summary(sales2)

## Determine the impact on sales per product_id.

# Create a new dataframe sales_by_product which contains the sum of Global_Sales
# for each product

sales_by_product <- sales2 %>%
  group_by(Product) %>%
  summarize(Total_Sales = sum(Global_Sales, na.rm = TRUE))

# View summary of new dataframe
summary(sales_by_product)

# There is considerable variation in the sales performance of different
# products (4.2 to 67.85m units)
# The product with the lowest sales sold 4.2m units
# 25% of the products have total sales less than or equal to 5.515m units
# 50% of the products have total sales less than or equal to 8.09m units
# The mean (average) total sales value is 10.73 million units
# 75% of the products have total sales less than or equal to 12.785m units
# The product with the highest sales sold 67.85m units.

###############################################################################


## Create plots to review and determine insights into the data set.

# Scatterplot
ggplot(sales2, aes(x = NA_Sales, y = EU_Sales)) +
  geom_point() +
  labs(x = "North America Sales (millions)", y = "Europe Sales (millions)") +
  theme_minimal()

# Histogram
ggplot(sales2, aes(x = Global_Sales)) +
  geom_histogram(bins = 30, fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Global Sales (millions)", y = "Frequency") +
  theme_minimal()

# Boxplot
ggplot(sales2, aes(x = Platform, y = Global_Sales)) +
  geom_boxplot() +
  labs(x = "Platform", y = "Global Sales (millions)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# These plots mirror the findings of the qplots. The distribution of global sales
# is positively skewed, most game sales are clustered around 0 to 10m, but there
# are some outliers in NA and EU, and one extreme outlier. The NES and Wii
# platforms have a wide range of higher sales volumes (longer upper quartiles),
# and the extreme outlier is a Wii game. 

###############################################################################


## Determine the normality of the data set.

# Create QQ plots for all the sales data

# Q-Q plot for NA_Sales
qqNA <- ggplot(sales2, aes(sample = NA_Sales)) +
  geom_qq() +
  geom_qq_line(color = "red") +
  labs(title = "Q-Q plot for NA_Sales") +
  theme_classic()

# Q-Q plot for EU_Sales
qqEU <- ggplot(sales2, aes(sample = EU_Sales)) +
  geom_qq() +
  geom_qq_line(color = "red") +
  labs(title = "Q-Q plot for EU_Sales") +
  theme_classic()

# Q-Q plot for Global_Sales
qqglobal <- ggplot(sales2, aes(sample = Global_Sales)) +
  geom_qq() +
  geom_qq_line(color = "red") +
  labs(title = "Q-Q plot for Global_Sales") +
  theme_classic()

# Plot all QQ plots
grid.arrange(qqNA, qqEU, qqglobal, ncol=3)

# The QQ plots indicate that the data is not normally distributed, since the 
# data points deviate from the line of best fit. This is the case for NA, EU
# and global sales. The distribution has heavier tails than a normal
# distribution, while the clustering around the red line in the middle
# indicates that the central part of the distribution is more normally
# distributed. The heavier tails indicate that there is a lot of variation
# in the sales data - some games sell extremely well, and other unperformed,
# by a large margin. The clustering around the middle suggests that there are
# a significant number of games that have sales close to the average, suggesting
# the market may be saturated with many games that achieve similar sales figures.
# The business could focus on factors that lead to higher sales to identify and
# address the issues causing games to under perform. 

# Perform a Shapiro-Wilk test on all the sales data

shapiro_na_sales <- shapiro.test(sales2$NA_Sales)
shapiro_eu_sales <- shapiro.test(sales2$EU_Sales)
shapiro_global_sales <- shapiro.test(sales2$Global_Sales)

shapiro_na_sales
shapiro_eu_sales
shapiro_global_sales

# In all three cases, the p-value < 0.05. This means that the null hypothesis 
# is rejected, and that the data does not follow a normal distribution. In other
# words, the sales data for NA_Sales, EU_Sales, and Global_Sales is not normally
# distributed, which is consistent with the observations made from the Q-Q plots.

# Determine the Skewness and Kurtosis of all the sales data

# Install moments package
install.packages("moments")

# Load the moments library
library(moments)

skewness_na_sales <- skewness(sales2$NA_Sales)
skewness_eu_sales <- skewness(sales2$EU_Sales)
skewness_global_sales <- skewness(sales2$Global_Sales)

kurtosis_na_sales <- kurtosis(sales2$NA_Sales)
kurtosis_eu_sales <- kurtosis(sales2$EU_Sales)
kurtosis_global_sales <- kurtosis(sales2$Global_Sales)

skewness_na_sales
skewness_eu_sales
skewness_global_sales

kurtosis_na_sales
kurtosis_eu_sales
kurtosis_global_sales

# Skewness
# All three sales variables are right (positively) skewed, suggesting that there
# are more games with relatively low sales and fewer games with extremely high 
# sales. In other words, there may be a small number of products that are very 
# popular and sell exceptionally well, while the majority of products have more
# modest sales figures.

# Kurtosis:
# All three sales variables have kurtosis values significantly greater than 3, 
# which means they are all not normally distributed. This indicates that the 
# sales variables have heavier tails and more extreme values (outliers) than a 
# normal distribution and have more data points concentrated around the mean.

# Determine if there is any correlation between the sales data columns

cor_sales <- cor(sales2[, c("NA_Sales", "EU_Sales", "Global_Sales")])
cor_sales

# There is a moderately strong positive correlation between the number of games
# sold in NA and EU. When NA sales increase, EU sales also tend to increase, 
# and vice versa.

# There is a very strong positive correlation between NA and global sales. When
# NA sales increase, total global sales also tend to increase and vice versa

# There is a strong positive correlation between EU and global sales. When EU
# sales increase, global sales tend to increase and vice versa. 

###############################################################################

## Plot the data

# Scatterplots are used below to visualize the correlations between continuous
# variables (sales). 

# Scatterplot of NA_Sales vs. EU_Sales
plot_na_eu <- ggplot(sales2, aes(x = NA_Sales, y = EU_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "NA_Sales vs. EU_Sales",
       x = "NA_Sales (Millions)",
       y = "EU_Sales (Millions)") +
  theme_minimal()

# Scatterplot of NA_Sales vs. Global_Sales
plot_na_global <- ggplot(sales2, aes(x = NA_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "NA_Sales vs. Global_Sales",
       x = "NA_Sales (Millions)",
       y = "Global_Sales (Millions)") +
  theme_minimal()

# Scatterplot of EU_Sales vs. Global_Sales
plot_eu_global <- ggplot(sales2, aes(x = EU_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "EU_Sales vs. Global_Sales",
       x = "EU_Sales (Millions)",
       y = "Global_Sales (Millions)") +
  theme_minimal()

# Combine and display all scatterplots using gridExtra
library(gridExtra)
grid.arrange(plot_na_eu, plot_na_global, plot_eu_global, nrow = 1, ncol = 3)

# The trend lines are calculated using linear regression (method = "lm") and 
# plotted in red lines. The trend lines help visualize the overall direction 
# and strength of the relationship between the sales variables.

# All three plots show a high concentration of sales near the origin, with 
# significant outliers. Based on earlier correlation analysis, it is clear that
# global sales is most impacted by NA sales, then by EU sales, but that NA and 
# EU sales are also positively correlated. 

# Remove outliers

# Calculate IQR for each sales variable
iqr_na <- IQR(sales2$NA_Sales)
iqr_eu <- IQR(sales2$EU_Sales)
iqr_global <- IQR(sales2$Global_Sales)

# Determine lower and upper bounds for outliers
lower_bound_na <- quantile(sales2$NA_Sales, 0.25) - 1.5 * iqr_na
upper_bound_na <- quantile(sales2$NA_Sales, 0.75) + 1.5 * iqr_na

lower_bound_eu <- quantile(sales2$EU_Sales, 0.25) - 1.5 * iqr_eu
upper_bound_eu <- quantile(sales2$EU_Sales, 0.75) + 1.5 * iqr_eu

lower_bound_global <- quantile(sales2$Global_Sales, 0.25) - 1.5 * iqr_global
upper_bound_global <- quantile(sales2$Global_Sales, 0.75) + 1.5 * iqr_global

# Create new dataframe with outliers removed
sales3 <- sales2 %>%
  filter(NA_Sales >= lower_bound_na & NA_Sales <= upper_bound_na &
           EU_Sales >= lower_bound_eu & EU_Sales <= upper_bound_eu &
           Global_Sales >= lower_bound_global & Global_Sales 
         <= upper_bound_global)

# Replot the scatterplots withoutliers removed

# Scatterplot of NA_Sales vs. EU_Sales
plot_na_eu2 <- ggplot(sales3, aes(x = NA_Sales, y = EU_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "NA_Sales vs. EU_Sales",
       x = "NA_Sales (Millions)",
       y = "EU_Sales (Millions)") +
  theme_minimal()

# Scatterplot of NA_Sales vs. Global_Sales
plot_na_global2 <- ggplot(sales3, aes(x = NA_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "NA_Sales vs. Global_Sales",
       x = "NA_Sales (Millions)",
       y = "Global_Sales (Millions)") +
  theme_minimal()

# Scatterplot of EU_Sales vs. Global_Sales
plot_eu_global2 <- ggplot(sales3, aes(x = EU_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "EU_Sales vs. Global_Sales",
       x = "EU_Sales (Millions)",
       y = "Global_Sales (Millions)") +
  theme_minimal()

# Combine and display all scatterplots using gridExtra
library(gridExtra)
grid.arrange(plot_na_eu2, plot_na_global2, plot_eu_global2, nrow = 1, ncol = 3)

# Check for correlation
cor_sales2 <- cor(sales3[, c("NA_Sales", "EU_Sales", "Global_Sales")])
cor_sales2

# The removal of outliers shows there is still a high degree of variability 
# in the sales data, despite the trend lines fitting the data more closely. The
# results of the test for correlation shows similar results: a moderately
# positive relationship between EU and NA sales, and stronger positive
# correlations between NA/Global and EU/Global sales, albeit all with slightly
# lower correlation co-efficients. 
# The strongest correlation remains that between NA and global sales. 

## SUMMARY: week 4

# The sales data analysis revealed a wide variation in sales performance for 
# different products, with sales ranging from 4.2 to 67.85 million units. The 
# distribution of global sales is positively skewed, with most games clustering 
# around 0 to 10 million, but with some outliers. The data is not normally 
# distributed, as demonstrated by Q-Q plots, Shapiro-Wilk tests, and assessments
# of skewness and kurtosis. This suggests the presence of a few highly 
# successful games, while the majority have modest sales.
# The NES and Wii platforms exhibit higher sales volumes, including an extreme 
# outlier on the Wii platform. The correlation tests between global, NA, and EU
# sales indicate moderately strong to very strong positive correlations. This 
# implies that an increase in sales in one region is generally accompanied by 
# an increase in the other region and globally.
# After removing outliers, the data still shows considerable variability, with 
# slightly lower correlation coefficients. The strongest correlation remains 
# between NA and global sales. The business could benefit from identifying 
# factors contributing to higher sales and addressing issues causing 
# underperformance in order to capitalize on market opportunities.

###############################################################################
###############################################################################

# ASSIGNMENT ACTIVITY 6: MAKING RECOMMENDATIONS TO THE BUSINESS

# SCENARIO
# The sales department wants to better understand whether there is any 
# relationship between North America, Europe, and global sales.

# Investigate any possible relationship(s) in the sales data by creating a 
# simple and multiple linear regression model. Based on the models and your 
# previous analysis (modules 1 to 5), answer the following questions: 

# Do you have confidence in the models based on goodness of fit and accuracy of
# predictions?
# What would your suggestions and recommendations be to the business?
# If needed, how would you improve the model(s)?

################################################################################

# Load and explore the data

# NOTE: sales2 dataframe contains all data. 
# sales3 contains data with outliers removed

# View data frame created in Week 5.
view(sales3)

# Determine a summary of the data frame.
summary(sales3)

###############################################################################

# SIMPLE LINEAR REGRESSION

# Determine the correlation between columns
# Correlation
cor(sales3[, c("NA_Sales", "EU_Sales", "Global_Sales")])

# The strongest correlation is that between Global and NA sales (0.891), 
# followed by Global-EU sales (0.851) and finally EU-NA sales (0.653)

# Basic visualizations

# Global-EU
plot(sales3$Global_Sales, sales3$EU_Sales)

# Global-NA
plot(sales3$Global_Sales, sales3$NA_Sales)

# NA-EU
plot(sales3$NA_Sales, sales3$EU_Sales)

# Simple Linear Regression: Model 1 (Predicting Global Sales using EU Sales)

simple_model1 <- lm(Global_Sales~EU_Sales,
             data=sales3)

# View the model 
simple_model1

# The intercept of the regression line is 0.7858, which means that when EU Sales
# are 0, global sales are 0.7858. 
# The EU Sales coefficient is 2.5383, which means that for every unit 
# increase in EU sales, predicted global sales increases by 2.5383, indicating
# a positive relationship (as EU sales increase, Global sales increase)

# View the full regression table
summary(simple_model1)

# Output of summary table:
# The EU Sales coeeficient is significant.  
# The R2 value shows that 72.44% of the variation in global sales can be 
# explained by EU sales. 

# Plot the model.

# View residuals on a plot.
plot(simple_model1$residuals)

# Add a line of best fit
plot(sales3$EU_Sales, sales3$Global_Sales)
coefficients(simple_model1)

# Add line-of-best-fit.
abline(coefficients(simple_model1))

# Model 1: EU sales is a reasonably good predictor of Global sales. 

# Simple Linear Regression: Model 2 (Predicting Global Sales using NA Sales)
simple_model2 <- lm(Global_Sales ~ NA_Sales, data = sales3)

# View the model
simple_model2

# View the full regression table
summary(simple_model2)

# When NA sales are 0, global sales are 0.8129. 
# The NA is a significant predictor of global sales
# The NA sales coefficient is 1.7295, which means that for every unit increase
# in NA sales, predicted global sales will increase by 1.7295 (a positive
# relationship)
# The R-squared value shows that 79.45% of the variation in global sales
# can be explained by NA sales

# Plot the model
plot(sales3$NA_Sales, sales3$Global_Sales)
abline(coefficients(simple_model2))

# The chart shows that NA sales is a reasonably good predictor of global sales

###############################################################################

# MULTIPLE LINEAR REGRESSION

# Create a multiple linear regression model predicting Global Sales (Y) from
# NA and EU sales. 

# Create an object with numeric values only

mlr_sales <- data.frame(Global_Sales = sales3$Global_Sales,
                     EU_Sales = sales3$EU_Sales,
                     NA_Sales = sales3$NA_Sales)

# Determine correlation
cor(mlr_sales)

# Visualise the correlations

# Install and import the psych package
install.packages('psych')
library(psych)

# Use the corPlot() function to plot correlations, set character size (cex=2)
corPlot(mlr_sales, cex=2)

# Global Sales are highly correlated with NA Sales (0.89), slightly less with
# EU sales (0.85). EU and NA Sales are also positively correlated (0.65). 

# Multiple linear regression model.

# Create a new object and specify lm function and variables
mlrmodel = lm(Global_Sales ~ EU_Sales + NA_Sales, data=mlr_sales)

# Print the summary stats
summary(mlrmodel)

# The multiple linear regression model summary indicates that both EU_Sales and
# NA_Sales are significant predictors of Global_Sales. The model has an adjusted
# R-squared value of 0.9199, which means that 91.99% of the variance in 
# Global_Sales can be explained by EU_Sales and NA_Sales.

# Plot relationships between Global Sales and predictors (EU and NA sales)

# Scatterplot with regression lines
mlrplot1 <- ggplot(mlr_sales, aes(x = EU_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_minimal() +
  ggtitle("Global Sales vs. EU Sales")

mlrplot2 <- ggplot(mlr_sales, aes(x = NA_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_minimal() +
  ggtitle("Global Sales vs. NA Sales")

# Arrange the plots side by side
grid.arrange(mlrplot1, mlrplot2, ncol=2)

# Both plots show a positive relationship between global sales and EU and NA 
# sales, respectively.

# Plot residuals to identify any non-linear patterns
residuals <- resid(mlrmodel)
fitted_values <- fitted(mlrmodel)

ggplot() +
  geom_point(aes(x = fitted_values, y = residuals)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  theme_classic() +
  xlab("Fitted Values") +
  ylab("Residuals") +
  ggtitle("Residuals vs. Fitted Values")


# This plot shows that there is some non-linear relationship between the
# predictors and the response variable. In other words, the relationship
# between regional and global sales might be more complex, so we may need
# to consider more advanced techniques to better capture the complexity
# of this relationship.

# Check for normality: QQ Plot
# Normal Q-Q plot
ggplot() +
  geom_qq(aes(sample = residuals), distribution = qnorm) +
  geom_qq_line(aes(sample = residuals), distribution = qnorm) +
  theme_classic() +
  ggtitle("Normal Q-Q Plot of Residuals")

# This plot shows that the residuals are not normally distributed. 

###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.

# Predict global sales
predict_values <- data.frame(NA_Sales = c(34.02, 3.93, 2.73, 2.26, 22.08),
                             EU_Sales = c(23.80, 1.56, 0.65, 0.97, 0.52))

predicted_sales <- predict(mlrmodel, newdata = predict_values)
print(predicted_sales)

# NA Sales = 34.02 and EU_Sales = 23.80, predicted Global_Sales is 72.03
# NA_Sales = 3.93 and EU_Sales = 1.56, predicted Global_Sales = 6.78
# NA_Sales = 2.73 and EU_Sales = 0.65, predicted Global_Sales =  4.14
# NA_Sales = 2.26 and EU_Sales = 0.97, predicted Global_Sales =  4.06
# NA_Sales = 22.08 and EU_Sales = 0.52, predicted Global_Sales =  26.92

# These predicted values can be used by the business to estimate expected global
# sales based on regional sales figures. 

# Assess the performance of the model - plot Actual vs. Predicted values
predicted_values <- predict(mlrmodel, newdata = mlr_sales)

ggplot(mlr_sales, aes(x = Global_Sales, y = predicted_values)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  theme_classic() +
  xlab("Actual Global Sales") +
  ylab("Predicted Global Sales") +
  ggtitle("Actual vs. Predicted Global Sales")

# This plot shows that the model is predicting global sales well, particularly
# when sales values are smaller. The predictions become more spread out further
# up the red line, which suggests that the model's predictions may be less
# accurate for larger sales values. 
# The model can reasonably predict global sales based on NA and EU sales, but
# caution should be taken when using these predictions for decision-making. 


###############################################################################

# 5. Observations and insights
# Your observations and insights here...

# Sales data analysis shows a strong positive correlation between Global, NA, 
# and EU sales. Linear regression models were built to predict Global sales 
# using EU and NA sales. NA sales had a higher R-squared value (79.45%) than EU
# sales (72.44%) for predicting Global sales. A multiple linear regression 
# model, including both EU and NA sales, explained 91.99% of the variance in 
# Global sales.

# The models show reasonable predictions for Global sales based on regional 
# sales. However, the relationship between regional and global sales might be
# more complex, as the residuals are not normally distributed, and predictions 
# become less accurate for larger sales values.

# Recommendations:
  # Use the multiple linear regression model cautiously for decision-making, 
  # keeping in mind its limitations.
  # Explore more advanced techniques to better capture the complex relationship 
  # between regional and global sales.


###############################################################################
###############################################################################





