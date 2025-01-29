<p align="center">
<img src="https://github.com/user-attachments/assets/cb8b8e30-ee68-4bc0-9f06-76ecdb2317d7" alt="Data Visualization"/>
</p>

<h1>Data Visualization Examples in R</h1>
<p>This project demonstrates various data visualization techniques in R, including time series plots, scatter plots, bar charts, histograms, and 3D plots using real-world earthquake data and synthetic datasets.</p><br />

<h2>Video Demonstration</h2>

- ### [YouTube: Data Visualization in R](https://www.youtube.com/watch?v=wNsKf7wSqhQ)

<h2>Environments and Technologies Used</h2>

- R Programming
- RStudio
- ggplot2, plotly, and base R visualization tools

<h2>Operating Systems Used </h2>

- Windows 11

<h2>List of Prerequisites</h2>

Before running this project, ensure you have:
- R and RStudio installed.
- Required R libraries: `ggplot2`, `plotly`, `readxl`.
- Access to the datasets in the folder (`number of world earthquakes GE 7.xlsx`, `Multiple Time Series.xlsx`, `income.txt`).

<h2>Installation Steps</h2>

### 1. Install Required Libraries

```r
install.packages(c("ggplot2", "plotly", "readxl"))
```

### 2. Load and Preprocess Data

```r
library(readxl)

# Load Earthquake Data
quakes <- read_excel("D:/number of world earthquakes GE 7.xlsx")
attach(quakes)
```
<h2>Time Series Visualization</h2>

### 3. Basic Time Series Plot  

```r
plot(Year, Frequency, type='l', main="Number of Earthquakes by Year", col="darkblue", lwd=2)
```
<p> <img src="https://github.com/user-attachments/assets/b7d22d3e-4306-4cb7-a1c8-850b84c98303" height="50%" width="50%" alt="Time-Series Plot"/> </p>

### 4. Adding Smoothed Trend Line

```r
smoothed <- lowess(x=Year, y=Frequency, f=.2)$y
lines(Year, smoothed, col="red", lwd=3)
```
<p> <img src="https://github.com/user-attachments/assets/e9e66fd5-9be3-4b74-8236-f1c6f9553c6f" height="50%" width="50%" alt="Smooth Trend Line"/> </p>

<h2>Aggregating Time Series Data</h2>

### 5. Group the Data into Four-Year Intervals

```r
sequences <- seq(from=1900, to=2016, by=4)
cuts <- cut(Year, breaks=floor(length(Year)/4), include.lowest=TRUE, labels=sequences)
years.binned <- as.numeric(as.vector(cuts))

# Aggregate Data
aggregated <- aggregate(x = Frequency, by = list(years.binned), FUN=sum)
attach(aggregated)
```

### 6. Plot Aggregated Data
```r
plot(Group.1, x, type="p", pch=19, frame=F, 
     main="Number of Earthquakes: Four Year Intervals",
     xlab="Beginning Year", ylab="Frequency",
     font.axis=2, font.lab=2)
```
<p> <img src="https://github.com/user-attachments/assets/5c20c7ab-d418-4641-9caa-02d485b458b7" height="50%" width="50%" alt="Aggregated Time-Series"/> </p>

<h2>Multiple Time Series Visualization</h2>

### 7. Load Multiple Time Series Data
```r
multseries <- read_excel("D:/Multiple Time Series.xlsx")
attach(multseries)
```

### 8. Plot Multiple Time Series
```r
plot(Time, Y1, col="darkred", type='l', ylim=c(0,150), xlim=c(0,20),
     frame=FALSE, lwd=2, font.lab=2, font.axis=2, 
     ylab="Time Series", xlab="Time")
lines(Time, Y2, col="darkgreen", lwd=2)
lines(Time, Y3, col="darkblue", lwd=2)
```

<p> <img src="https://github.com/user-attachments/assets/27fd63e8-a5e2-48a8-8d1b-c8e88a496a76" height="50%" width="50%" alt="Multiple Time Series"/> </p>

### 9. Add Shaded Regions

```r
polygon(c(Time, rev(Time)), c(Y3, rev(Y2)), col="lightgray", border=F)
polygon(c(Time, rev(Time)), c(Y1, rev(Y3)), col="lightyellow", border=F)
lines(Time, Y1, col="darkred", lwd=3)
lines(Time, Y2, col="darkgreen", lwd=3)
lines(Time, Y3, col="darkblue", lwd=3)
```
<p> <img src="https://github.com/user-attachments/assets/c71d3647-08bd-424a-ac11-5cba5fa43e64" height="50%" width="50%" alt="Shaded Time Series"/> </p>

<h2>Scatter Plots and Correlation</h2>

### 10. Basic Scatter Plot
```r
plot(Y1, Y2, pch=19, frame=F, xlim=c(0,160), ylim=c(0,50), cex=2)
```

### 11. Add Regression Line
```r
reg <- lm(Y2 ~ Y1)
abline(reg, col="red", lwd=2)
```

### 12. Scatterplot Matrix
```r
pairs(cbind(Y1, Y2, Y3), pch=19, cex=2, font.axis=2, font.lab=2, lower.panel=NULL)
```

<h2>Histogram and Barplots</h2>

### 13. Creating a Barplot
```r
max.temp <- c(22, 27, 26, 24, 23, 26, 28)
days <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

barplot(max.temp, main="Maximum Temperatures in a Week",
        ylab="Degree Celsius", xlab="Day",
        names.arg=days, col="darkred")
```

### 14. Histogram of Income Distribution
```r
income <- read.table("D:/income.txt", header=T, sep="\t")
hist(income$avg_income, main="Distribution of US Census Average Income", 
     ylab="Frequency of Observations", xlab = "Average Disposable Income",
     breaks=100, col="lightgreen", font=2)
```

<p> <img src="https://github.com/user-attachments/assets/b5f33bf8-e6b5-4d42-b6c8-69907499573a" height="50%" width="50%" alt="Histogram Plot"/> </p>

### 15. 3D Perspective Plot
```r
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
```
<p> <img src="https://github.com/user-attachments/assets/2ff19f8d-923c-4b3b-9bbb-6a7a2edb501e" height="30%" width="30%" alt="3D Perspective"/> </p>

<h2>Conclusion</h2>

- Time series visualization was used to explore earthquake trends.
- Scatter plots helped analyze correlation in datasets.
- Histograms and bar charts were utilized for distribution insights.
- 3D surface and perspective plots provided advanced visualization.

<h2>Future Improvements</h2>

- Experiment with interactive dashboards using Shiny.
- Implement geospatial mapping for earthquake locations.
- Explore machine learning models for trend prediction.














