# HP GT 4081 R Project
# Hetu Patel, hetuptl99@gatech.edu
# Created 09-16-2019
# DataSet Link: "https://catalog.data.gov/dataset/mypyramid-food-raw-data-f9ed6"
# This data set contains the common foods and their nutritional content

# install.packages("ggplot2")
# install.packages("vegan")
# install.packages("pheatmap")
# install.packages("wordcloud")
# install.packages("tm")

library(ggplot2)
library(vegan)
library(pheatmap)
library(wordcloud)
library(tm)

#Tabling the Data
FoodDisTable <- read.csv("Food_Display_Table.csv", header = TRUE)
FoodsNeedCond <- read.csv("Foods_Needing_Condiments_Table.csv", header = TRUE)
CondFoodTable <- read.csv("lu_Condiment_Food_Table.csv", header = TRUE)

# General Plots between nutritional value correlations
plot(FoodDisTable$WholeGrains~FoodDisTable$SaturatedFats, col = "red", main = "Correlation between Whole Grains & Sat Fats", xlab = "Sat Fats", ylab = "Whole Grains")
plot(FoodDisTable$Vegetables~FoodDisTable$SaturatedFats, col = "blue", main = "Correlation between Vegetables & Sat Fats", xlab = "Sat Fats", ylab = "Vegetables")

# General Histograms to see how different nutritional contents are spread out
hist(FoodDisTable$WholeGrains, main = "Amount of Whole Grains in Our Common Foods", xlab = "Whole Grains", col = rainbow(4), xlim = c(0,2))
hist(FoodDisTable$SaturatedFats, main = "Sat Fat Content in Common Foods", xlab = "Saturated Fat Content", col = rainbow(5), xlim = c(0,25))

# Heat Map of Nutrients for each food
# FoodTable2 <- FoodDisTable[,c("SaturatedFats", "Calories",
#                               "Grains", "WholeGrains", "Vegetables", "OrangeVegetables",
#                               "DrkgreenVegetables", "Starchyvegetables", "OtherVegetables",
#                               "Fruits", "Milk", "Meats", "Soy",
#                               "DrybeansPeas", "Oils", "SolidFats", "AddedSugars",
#                               "Alcohol")]
# 
# food_hellinger <- decostand(FoodTable2, method = "hellinger", na.rm = TRUE)
# pheatmap(food_hellinger, cluster_cols=FALSE, cellwidth=8, cellheight=8, main='Common Foods')

# Plots showing other nutritional splits based on dietary restrictions
ggplot(FoodDisTable, aes(x=FoodDisTable$Soy, y=FoodDisTable$SaturatedFats, color = FoodDisTable$Dietary)) + geom_point()

ggplot(data=FoodDisTable, aes(x=FoodDisTable$SolidFats, y=FoodDisTable$Calories)) + 
  geom_point(aes(col=FoodDisTable$Dietary)) + 
  geom_smooth(method=loess, se=FALSE, color="darkorchid4") +
  geom_smooth(method=lm, aes(col=FoodDisTable$Dietary))

# Data visualization to show common foods
wordcloud(words = FoodDisTable$DisplayName, min.freq = 20,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
