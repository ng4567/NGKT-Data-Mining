rm(list = ls())

### election dataset

election <- read.csv("countypres_2000-2016.csv")

election <- subset(election, year == 2016)

election <- subset(election, party == "democrat" | party == "republican")

library(dplyr)

election <- election %>%
  dplyr::select(-state_po, -office, -candidate, -version, -totalvotes, -year)

library(tidyr)

election <- election %>% spread(party, candidatevotes)

election$dem <- ifelse(election$democrat > election$republican,1,0)

election <- election %>% dplyr::select(-democrat,-republican)

### start after here because some editing was done in excel that is not featured here
census <- read.csv("censusnew.csv")

str(census)

library(stringr)

county <- as.numeric(str_extract_all(census$id, "(?<=US\\s{0,1})[-0-9.]+"))
census <- cbind(county,census)

election$county <- election$FIPS

dat <- merge(election, census, by = "county")

final <- dat %>% dplyr::select(-county, -state, -FIPS, -id, -Geographic.Area.Name)

write.csv(final, "finaldata.csv")

library(Boruta)

str(final)

final$dem <- as.factor(final$dem)

###

res <- cor(final[,-1])

hc = findCorrelation(res, cutoff=0.70) # putt any value as a "cutoff" 
hc = sort(hc)
reduced_final = final[,-c(hc)]
reduced_final$dem = final$dem


library(corrplot)
corrplot(res)


borutatrain <- Boruta(dem ~ . -median - totalmale, data = reduced_final, doTrace = 2)

plot(borutatrain, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(borutatrain$ImpHistory),function(i)
  borutatrain$ImpHistory[is.finite(borutatrain$ImpHistory[,i]),i])
names(lz) <- colnames(borutatrain$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(borutatrain$ImpHistory), cex.axis = 0.7)

library(MASS)

fit7 <- glm(dem ~ 1, family = binomial, data = reduced_final)
mbti.mod <- glm(dem ~ . - totalmale, family = binomial, data = reduced_final)

scope <- list(upper=formula(mbti.mod), lower=formula(fit7))
stepAIC(fit7, direction = "forward", scope = scope)
stepAIC(mbti.mod, direction = "backward", scope = scope)


summary(reduced_final)


ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

mod_fit <- train(dem ~ . -totalmale,
                 data=reduced_final, method="glm", family="binomial",
                 trControl = ctrl, tuneLength = 5)

mod_fit

experimental_fit <- train(dem ~ X20to24 + X75to84  + white + black + asian,
                          data=reduced_final, method="glm", family="binomial",
                          trControl = ctrl, tuneLength = 5)

experimental_fit

Train <- createDataPartition(reduced_final$dem, p=0.8, list = F)
training <- reduced_final[ Train, ]
testing <- reduced_final[ -Train, ]

table(final$dem)

pred <- predict(experimental_fit, newdata=testing, na.action = na.pass)
confusionMatrix(data=pred, testing$dem)

library("klaR")
library(e1071)
x <- c("asian", "white")
y <- "dem"

nb_model = train(reduced_final[,x], reduced_final$dem,'nb',trControl=ctrl)
nb_model


tree = train(dem ~ . - totalmale, 
                  data=reduced_final, 
                  method="rpart", 
                  trControl = ctrl)

tree

knnFit <- train(dem ~ . - totalmale,  data = training, method = "knn", trControl = ctrl, tuneLength = 20)

#Output of kNN fit
knnFit

pred <- predict(knnFit, newdata=testing, na.action = na.pass)
confusionMatrix(data=pred, testing$dem)




library("lime")
explainer <- lime(training, knnFit)

explanation <- explain(reduced_final[sample(1:3114, 6, replace = F), ], explainer, n_labels = 1, n_features = 5)

plot_features(explanation)
plot_explanations(explanation)


summary(glm(dem ~ X20to24 + X75to84 + white + black + asian,
data=reduced_final, family="binomial"))


