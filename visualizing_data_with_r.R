# Data Visualization Examples

# Import Earthquake Excel Data
setwd("D:/Foundation of Business Analytics/August 2021/Class 2")
library(readxl)

# spreadsheet records the number of earthquakes each year
# from 1900 to 2020 with magnitudes 7.0 or bigger on the richter scale
quakes <- read_excel(
"D:\\Foundation of Business Analytics\\August 2021\\Class 2\\number of world earthquakes GE 7.xlsx")

quakes
attach(quakes)

### some time series and scatter plots
# a simple time series line plot in R
# plot (x, y)
plot(Year, Frequency, type='l')

# can make lines more bolded with the "lwd" command
plot(Year, Frequency, type='l', lwd=4)

# to plot just the points, do this
plot(Year, Frequency, type='p')

# to add a title, can use the "main" argument
plot(Year, Frequency, type='p', main="Number of Earthquakes by Year")

# Can remove the box around the chart
plot(Year, Frequency, type='p', main="Number of Earthquakes by Year", frame=F)

# Can have custom axis titles
plot(Year, Frequency, type='p', main="Number of Earthquakes by Year", frame=F,
     xlab="Year of Earthquake (Magnitudes > 7.0",
     ylab="Number of Earthquakes")

# Can change the plot character to solid dots
plot(Year, Frequency, type='p', main="Number of Earthquakes by Year", frame=F,
     xlab="Year of Earthquake (Magnitudes > 7.0",
     ylab="Number of Earthquakes", pch=19)


# Can change the color of your dots 
plot(Year, Frequency, type='p', main="Number of Earthquakes by Year", frame=F,
     xlab="Year of Earthquake (Magnitudes > 7.0",
     ylab="Number of Earthquakes", pch=19, col="darkblue")

# can add lines to your plot to make time series more clear
lines(Year, Frequency, col = "darkred")

# Can also add a smoothed line to highlight the overall trend in quakes over time
smoothed <- lowess(x=Year, y=Frequency, f=.2)$y
lines(Year, smoothed, col="black", lwd=3)

# Can also use R libraries for even higher resolution plots
library(ggplot2)
ggplot(quakes, aes(x=Year, y=Frequency)) + geom_line(color="red")

# Let's collapse the data into bins of four years each
# the cut function in R can do this
N <- length(Year) # 121 years of data
num.bins = floor(N/4)
num.bins

# define the sequences of years
sequences <- seq(from=1900, to=2016, by=4)
sequences

# cut the data based on your sequences
cuts <- cut(Year, breaks=num.bins, include.lowest=TRUE, labels=sequences)

# extract the repeated values from cuts as a numerical vector
years.binned <- as.numeric(as.vector(cuts))

cbind(years.binned, Frequency)

# finally, aggregate the number of earthquakes according to your years.binned
# we want to sum up the total number of earthquakes every four years
aggregate(x = Frequency, by = list(years.binned), FUN=sum )
aggregated <- aggregate(x = Frequency, by = list(years.binned), FUN=sum )
attach(aggregated)

# replot the aggregated time series data
# much easier to look at now
plot(Group.1, x, type="l")

# let's redo some of the other settings
plot(Group.1, x, type="p", pch=19, frame=F, 
     main="Number of Earthquakes: Four Year Intervals",
     xlab="Beginning Year", ylab="Frequency",
     font.axis=2, font.lab=2) # we can bold the labels and axes too

# add a smoother
smoothed2 <- lowess(x=Group.1, y=x, f=.2)$y
lines(Group.1, smoothed2, col="darkred", lwd=3)

# how to plot multiple time series
multseries <- read_excel(
"D:\\Foundation of Business Analytics\\August 2021\\Class 2\\Multiple Time Series.xlsx")
head(multseries)

attach(multseries)

# we want to plot Y1, Y2, and Y3 as a function of time
plot(Time, Y1, col="darkred", type='l')
lines(Time, Y2, col="darkgreen")
lines(Time, Y3, col="darkblue")

# We need to change the plotting limits of Y
plot(Time, Y1, col="darkred", type='l', ylim=c(0,150), xlim=c(0,20),
     frame=FALSE, lwd=2, font.lab=2, font.axis=2,
     ylab="Time Series", xlab="Time")
lines(Time, Y2, col="darkgreen", lwd=2)
lines(Time, Y3, col="darkblue", lwd=2)

# what if we wanted to shade the values in between the  lines?
plot(Time, Y1, col="darkred" , ylim=c(0,150), xlim=c(0,20),
     frame=FALSE, lwd=2, font.lab=2, font.axis=2, main="Three Time Series",
     ylab="Time Series", xlab="Time", type='n') # don't plot anything yet

# create the shading between Y2 and Y3
# the command for shading in between lines is :
# polygon( c(x, reverse x), c(top curve, reverse bottom curve) )

polygon( c(Time, rev(Time)), c(Y3, rev(Y2)), col="lightgray", border=F)

# create shading in between Y1 and Y3
polygon( c(Time, rev(Time)), c(Y1, rev(Y3)), col="lightyellow", border=F)

# now add your lines back
lines(Time, Y1, col="darkred", lwd=3)
lines(Time, Y2, col="darkgreen", lwd=3)
lines(Time, Y3, col="darkblue", lwd=3)

###

# let's do a scatterplot of Y1 vs. Y2
plot(Y1, Y2, pch=19, frame=F, xlim=c(0,160), ylim=c(0,50),
     cex=2) # cex changes the size of the plot characters

# we can add a regression line to the chart to show the linear relationship
reg <- lm(Y2 ~ Y1) # run a linear regression
abline(reg, col="red", lwd=2) # add to the plot

# you can do scatterplots of all variables with the pairs function
pairs(cbind(Y1, Y2, Y3), pch=19, cex=2, font.axis=2, font.lab=2, lower.panel=NULL)

detach(quakes)
detach(aggregated)
detach(multseries)

# delete all R objects
rm(list=ls(all=T))

# sampling is very useful
# sometimes you don't want to plot every data point
# let's create a sample of 10000 data points for X and Y
# we want the two variables to be positively correlated
set.seed(55); X <- rnorm(10000, mean= 100, sd=25); Y <- 15+1.6*X + rnorm(10000, mean=0, sd=20)

plot(X,Y, pch=19) # This is fine but the chart is really cluttered
# let's take a random sample of 300 values and plot that instead
# the sample function can do this for you

set.seed(1); samps <- sample(x=(1:10000), size=300, replace=FALSE)
plot(X[samps], Y[samps], pch=19, xlab="X",ylab="Y", frame=F) # easier to visualize

# can make the dots smaller to make it easier to visualize
plot(X[samps], Y[samps], pch=19, xlab="X",ylab="Y", frame=F,
     cex=.5, col="darkblue") # smaller dots
abline(lm(Y[samps] ~ X[samps]), lwd=2)# add regression line

# 3D surface plots
# you can also make beautiful 3D plots
# here is an illustration
library(plotly)
p <- plot_ly(z = volcano, type = "surface")
p 

# can also do 3d perspective plots
cone <- function(x, y){
     sqrt(x^2+y^2)
}

x <- y <- seq(-1, 1, length= 20)
z <- outer(x, y, cone)

persp(x, y, z,
      main="Perspective Plot of a Cone",
      zlab = "Height",
      theta = 30, phi = 15,
      col = "springgreen", shade = 0.5)

# see https://plotly.com/r/
# see https://www.r-graph-gallery.com/
###

# barplots
# barplots can be created in R using the barplot() function

# create some temperatures in Celsius
max.temp <- c(22, 27, 26, 24, 23, 26, 28)

# make a barplot
barplot(max.temp)

# can flip the barplot with the horiz=TRUE argument
barplot(max.temp, horiz=TRUE)

# can add labels and change color
days <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

barplot(max.temp,
        main = "Maximum Temperatures in a Week",
        ylab = "Degree Celsius",
        xlab = "Day",
        names.arg = days,
        col = "darkred")

# Plotting the ages of different college freshman
# make up 1000 ages of college students
set.seed(155); ages <- rpois(1000, 22)
ages[ages < 18] <- 18
table(ages) # frequency count

# extract the labels from the table
age.vals <- names(table(ages))
age_dist <- table(ages)

barplot(age_dist,
        main = "Frequency Count of Number of Freshman by Age",
        ylab = "Frequency",
        xlab = "Age (Years)",
        names.arg = age.vals,
        col = "darkblue")

# But what if you have data that isn't easily binned?
# A histogram is more useful
setwd("D:/Foundation of Business Analytics/August 2021/Class 2")
income <- read.table("income.txt", header=T, sep="\t")
attach(income)
table(avg_income) # it doesn't make sense to do a bar plot

# A histogram is a better bet

# let's add our own titles
hist(avg_income, main="Distribution of US Census Average Income", 
     ylab="Frequency of Observations", xlab = "Average Disposable Income")

?hist # for help on hist

# We can also increase the number of bars in the histogram, given the large amount of data we have
# let's create 100 bars to get a smoother picture of the data. the "breaks" command does this:
hist(avg_income, main="Distribution of US Census Average Income", 
     ylab="Frequency of Observations", xlab = "Average Disposable Income",
     breaks=100, col="lightgreen", font=2) # font = 2 means to make everything bold

# how many unique values of income do we have? Almost 80,000 
length(unique(avg_income))


