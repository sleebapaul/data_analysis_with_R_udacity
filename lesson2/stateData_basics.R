getwd()
setwd('Introduction to R -- Udacity/')
df<-read.csv('stateData.csv')
subset(df,state.region==1) # Using Subset 
some_thing=df[df$state.region==1, ] # Using the idea that if we need to select something then us this df[Rows,Columns]
head(some_thing)
dim(some_thing)
df[df$state.area==max(df$state.area), ]
