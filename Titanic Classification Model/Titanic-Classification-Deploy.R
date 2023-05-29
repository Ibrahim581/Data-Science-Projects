# Loading libraries
library(tidyverse) # Needed for visualizations
library(caret) # Used for basic ml techniques such as classification or regression
library(titanic) # Used to get the data set
library(psych) # Used for descriptive statistics
library(randomForest) # Used to build the model


# Titanic data

## Loading and cleaning the data


# Loading in the data
titanic <- carData::TitanicSurvival

# Removing the row names because we don't need them
rownames(titanic) <- NULL

# Removing the N/A values
titanic <- na.omit(titanic)

# Create a new categorical variable for Age_Category
titanic$Age_Category <- NA

# Define the age categories
age_categories <- c("Child", "Adult", "Elderly")

# Assign age categories based on age values
titanic$Age_Category[titanic$age < 18] <- age_categories[1]  # Child
titanic$Age_Category[titanic$age >= 18 & titanic$age < 65] <- age_categories[2]  # Adult
titanic$Age_Category[titanic$age >= 65] <- age_categories[3]  # Elderly

# Removing the age variable because we have the category variable
titanic <- titanic[,-3]


# Building a model

## Splitting our data

# Creating a train and a test set
set.seed(7)
train_index <- createDataPartition(titanic$survived, p = 0.8, list = FALSE)
train <- titanic[train_index,]
test <- titanic[-train_index,]


set.seed(7)
model <- randomForest(survived~.,data = train)
summary(model)


# Saving model to RDS file
saveRDS(model, 'model.rds')

# Reading in the model from RDS
read.model <- readRDS('model.rds')


# Predicting values based on our test set
Prediction <- predict(read.model,test)
test$predicted <- Prediction

# Making a confusion matrix to test the accuracy
CFM_test <- confusionMatrix(test$predicted, test$survived)
CFM_test


# Predicting values based on our test set
Prediction_train <- predict(read.model,train)
train$predicted <- Prediction_train

# Making a confusion matrix to test the accuracy
CFM_train <- confusionMatrix(train$predicted, train$survived)
CFM_train



