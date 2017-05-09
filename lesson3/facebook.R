library(ggplot2)
pf<-read.csv('lesson3/pseudo_facebook.tsv',sep = "\t")
names(pf)
qplot(x=dob_day,data = pf) +
  scale_x_continuous(breaks = 1:31) +
  facet_wrap(~dob_month,ncol = 3)

# we can use ggplot also
ggplot(data = pf, aes(x = dob_day)) + 
  geom_histogram(binwidth = 1) + 
  scale_x_continuous(breaks = 1:31) + 
  facet_wrap(~dob_month)

# plotting the histogram on friend_count by adding a rescaling layer  

ggplot(data = pf, aes(x = friend_count)) + 
  geom_histogram(binwidth = 25) + scale_x_continuous(lim=c(0,1000),breaks = seq(0,1000,50)) 
+ facet_wrap(~gender)


# using qplot and xlim


library(ggplot2)
qplot(x=friend_count,data =subset(pf,!is.na(gender)),binwidth=10)+ 
  scale_x_continuous(lim=c(0,1000),breaks = seq(0,1000,50)) + facet_wrap(~gender)

qplot(x=friend_count,data =na.omit(pf),binwidth=10)

qplot(x=friend_count,data =na.omit(pf),binwidth=10)+ 
  scale_x_continuous(lim=c(0,1000),breaks = seq(0,1000,50)) + facet_wrap(~gender)


table(pf$gender) # find the count 

by(pf$friend_count,pf$gender,summary) #find the statistics of two variables

# there are some things to be noted here 
# median is more accountable here, since mean is shifted to right beacuse the distribution is longtailed
# some high values on the right side is pulling mean to the right which is not reflecting the real scene

# bin width make sense as tenure is in number of days 
qplot(x=tenure/365,data = pf, color=I("black"),fill=I("#099009"),binwidth=30) 


# bin width make sense as tenure is in number of year 
qplot(x=tenure/365,data = pf, color=I("black"),fill=I("#099009"),binwidth=.25, 
      xlab = "No. of years", ylab = "No. of Users") +
  scale_x_continuous(breaks = seq(1,7,1),limits = c(0,7))
summary(pf$tenure)

# plotting the user age groups
summary(pf$age)
table(pf$age)
qplot(x=pf$age,data = pf, color=I("black"),fill=I("#099009"),binwidth=1, 
      xlab = "No. of years", ylab = "No. of Users") 
  #scale_x_continuous(breaks = seq(1,100,10),limits = c(0,100))

#creating the box plot
qplot(x=gender,y=friend_count,
      data=subset(pf,!is.na(gender)),
      geom = 'boxplot',ylim = c(0,1000))
# same can be done using scale_y_continous


qplot(x=gender,y=friend_count,
      data=subset(pf,!is.na(gender)),
      geom = 'boxplot')+
  coord_cartesian(ylim = c(0,1000))

# y lim removes data points and makes the plot inaccurate
#coord_cartesian() will zoom it for us without losing this removal of points








