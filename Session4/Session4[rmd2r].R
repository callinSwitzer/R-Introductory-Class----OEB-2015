#' ---	
#' title: "Session 4 - Answers"	
#' author: "Callin Switzer"	
#' date: "Oct 5, 2015"	
#' output: html_document	
#' ---	
#' 	
#' ---	
#' 	
#' #### Topics:	
#' 	
#' * Visualization using ggplot()	
#'      * coloring data based on a variable	
#'      * reordering the bars or boxes in a plot	
#'      * adding lines from loess or linear models to scatterplots	
#' * Loops and apply functions()	
#' * ** Writing your own functions	
#' 	
#' **if time	
#' 	
#' 	
#' 	
# print system time, so we know when the last update was	
paste("Last knit to html at: ", Sys.time())	
#' 	
#' 	
#' ---	
#' 	
#' # Review	
#' #### What we learned last time:	
#' 1. Navigate your data frames, using square-bracket and "$" notation.	
#' 2. Use logical statements to subset and clean data.	
#' 3. Exporting data	
#' 4. Formatting data for ggplot	
#' 5. Changing ggplot themes	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(0): 	
#' </span>	
#' 	
#' ### 0.1 Set your working directory to the Session4 folder.	
#' 	
#' ### 0.2 Import the "CallinPollen.csv" dataset, and call it "flr".	
#' 	
#' ### 0.3 Make sure the "ggplot2" and "grid" libraries is loaded with e.g. "library(ggplot2)".  If you're having trouble, use "install.packages("ggplot2")" before loading the library.	
#' 	
#' ### 0.4 Use ggplot to plot a scatterplot like this: 	
#' 	
#'      ggplot(flr, aes(x = shakeNumber, y = slope)) + 	
#'           geom_point() + 	
#'           theme_bw()	
#'           	
#' 	
#' ---	
#' 	
#' 	
# 0.1	
setwd("/Users/callinswitzer/Dropbox/Harvard/RByCall/RClassMaterials/Session4")	
	
# 0.2	
library(ggplot2)	
library(grid) # we need this for the "unit" function	
	
# 0.3	
flr <- read.csv("Datasets/CallinPollen.csv")	
	
# 0.4	
p1 <- ggplot(flr, aes(x = shakeNumber, y = slope)) + 	
     geom_point() + 	
     theme_bw()	
p1	
#' 	
#' 	
#' 	
#' 	
#' # 1. Visualization with ggplot	
#' 	
#' ## Coloring / shaping points based on a factor	
#' 	
# read in data	
crs <- read.csv("Datasets/mtcars.txt", sep = " ")	
	
# plot it	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point()	
	
# color points, based on the number of cylinders	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(color = cyl))	
	
# same thing	
ggplot(crs, aes(x = wt, y = mpg, color = cyl)) + 	
     geom_point()	
	
# we don't want a spectrum of colors, so we'll make crs$cyl into a factor	
crs$cyl <- as.factor(crs$cyl)	
	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(color = cyl))	
	
# change color scheme	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(fill= cyl), color = "black",  shape = 21, size = 4) + 	
     theme_classic() + 	
     scale_fill_manual(values = c("black", "grey50", "white"))	
	
	
# color points, based the cyl being greater than 4	
Cyl.Gr.4 <- as.numeric(as.character(crs$cyl)) > 4	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(fill= Cyl.Gr.4), color = "black",  shape = 21, size = 4) + 	
     theme_classic() + 	
     scale_fill_manual(values = c("black", "white"))	
	
	
# size points, based on a factor	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(size = Cyl.Gr.4), color = "black", fill = "grey",  shape = 21) + 	
     theme_classic() + 	
     scale_size_manual(values = c(1, 10))	
	
	
# you can do the same thing with shape	
ggplot(crs, aes(x = wt, y = mpg)) + 	
     geom_point(aes(shape = Cyl.Gr.4), color = "black", fill = "grey", size = 4) + 	
     theme_classic() + 	
     scale_shape_manual(values = c(22, 21), name = "Num. Cyl. \n    > 4")	
	
#' 	
#' 	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(1): 	
#' </span>	
#' 	
#' #### 1.1 With the cars dataset, use ggplot to make a scatterplot of x = disp, y = mpg.  Color the points differently, based on the "am" column (automatic transmission). Make sure that "am" is a factor or logical.  Feel free to change the size, theme, etc.	
#' 	
#' 	
#' ---	
#' 	
#' 	
#' ### Making boxplots	
#' 	
#' 	
################################  EXAMPLE 1 ################################ 	
# making a boxplot 	
################################  EXAMPLE 1 ################################ 	
	
# here's a plot that looks weird as points	
ggplot(flr, aes(x = shakeNumber, y = slope)) + 	
     geom_point()	
	
# say we think that shake number should be represented with a boxplot, rather than with dots	
p2 <- ggplot(flr, aes(x = shakeNumber, y = slope)) + 	
     geom_boxplot()	
p2 # not quite right	
	
p3 <- ggplot(flr, aes(x = as.factor(shakeNumber), y = slope)) + 	
     geom_boxplot()	
p3 # much better	
	
# log transform 	
p3 + scale_y_log10()	
	
	
################################  EXAMPLE 2 ################################	
# changing the order of the boxes in a plot	
################################  EXAMPLE 2 ################################	
	
# a basic boxplot	
p4 <- ggplot(flr, aes(x = trt, y = int)) + 	
     geom_boxplot()	
p4	
	
# changing order of the boxes -- change levels of a factor	
str(flr$trt) # factor with levels alphabetized	
	
# we can change the order of the factor levels to change the plot	
levels(flr$trt)	
newlevels <- c('heat and humidifier in alcove', 'heat and humidifier', 'AC', 'AC and dehumidifier', 'AC set to 62 overnight', 'heat set to 80F overnight', 'Ambient', 'dehumidifier', 'Humidifier')	
flr$trt <- factor(flr$trt, levels =  newlevels)	
	
p5 <- ggplot(flr, aes(x = trt, y = int)) + 	
     geom_boxplot() + 	
     theme(axis.text.x = element_text(angle = 45, hjust = 1), # make text 45 degrees	
           plot.margin = unit(c(2,1,1,1), "cm")) # move the left margin over	
p5	
	
# we can order the factor levels based on their means	
(trtMeans <- tapply(X = flr$int, FUN = mean, INDEX = flr$trt))	
	
# sort the treatments	
(trtMeans.sort <- trtMeans[order(trtMeans, decreasing = TRUE)])	
names(trtMeans.sort) # sorted vector, based on mean	
	
	
# change the factor levels     	
flr$trt <- factor(flr$trt, levels = names(trtMeans.sort))	
	
p6.ordered <- ggplot(flr, aes(x = trt, y = int)) + 	
     geom_boxplot(fill = 'black', alpha = 0.5, outlier.colour = NA) + # don't show outliers	
     theme_bw() + 	
     theme(axis.text.x = element_text(angle = 45, hjust = 1), 	
           panel.grid.major = element_blank(), 	
           panel.grid.minor = element_blank(), 	
           plot.margin = unit(c(2,1,1,1), "cm")) + 	
     labs(x = "Treatment", y = "Pollen release (integration method)")	
	
p6.ordered 	
	
	
	
p6.ordered + geom_point() # add points to our plot	
p7 <- p6.ordered + geom_point(position = position_jitter(width = 0.1, height = 0), alpha = 0.5)	
p7	
	
# save the plot	
ggsave("boxpltTrt.pdf", plot = p7,  device = cairo_pdf, width = 89, height = 60, unit = "mm")	
file.remove("boxpltTrt.pdf") # remove plot 	
	
	
################################  EXAMPLE 3 ################################	
# changing the order of the bars in a plot	
################################  EXAMPLE 3 ################################	
surv <- read.csv("Datasets/survey.csv")	
	
# map values to shorter words	
library(plyr)	
surv$Rexp <- mapvalues(surv$Rexp, from = as.character(levels(surv$Rexp)), to = c("Instar", "Adult", "Egg", "Pupa"))	
	
ggplot(surv, aes(x = Rexp)) + 	
     geom_bar()  + 	
     theme_minimal()	
	
# set new levels	
surv$Rexp <- factor(surv$Rexp, levels = c("Egg", "Instar", "Pupa", "Adult"))	
	
# replot	
ggplot(surv, aes(x = Rexp)) + 	
     geom_bar() + 	
     theme_minimal()	
	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(1, cont'): 	
#' </span>	
#' 	
#' #### 1.2 Read in (redo it, if you've read it in earlier) the surv.csv file. Use these commands to clean your data:	
#'      	
#'      # makes a new, small data frame that contains only the same levels as the Rexp column	
#'      # drops factor levels with 0 items	
#'      s.sm <- droplevels(surv[surv$BestExp %in% surv$Rexp, ]) 	
#'      	
#'      # maps values to one-word, instead of long strings	
#'      library(plyr)	
#'      s.sm$BestExp <- mapvalues(s.sm$BestExp, from = as.character(levels(s.sm$BestExp)), to = c("Instar", "Adult", "Egg", "Pupa"))	
#'      	
#' #### Make a barplot of the s.sm $ BestExp. Change the order of the bars so that they go like this: Egg, Instar, Pupa, Adult	
#' 	
#' ---	
#' 	
#' ### Adding lines to ggplot	
#' 	
#' 	
	
# plot horsepower vs quarter second time	
ggplot(crs, aes(x = hp, y = qsec)) + 	
     geom_point()	
	
# add a loess (local regression) line	
ggplot(crs, aes(x = hp, y = qsec)) + 	
     geom_point() + 	
     geom_smooth(method = "loess")	
	
# add least squares line, without standard errors	
ggplot(crs, aes(x = hp, y = qsec)) + 	
     geom_point() + 	
     geom_smooth(method = "lm", se = FALSE)	
	
# same thing	
ggplot(crs, aes(x = hp, y = qsec)) + 	
     geom_point() + 	
     stat_smooth(method = "lm", se = FALSE)	
	
	
# same thing, specifying formula	
ggplot(crs, aes(x = hp, y = qsec)) + 	
     geom_point() + 	
     stat_smooth(method = "lm", se = FALSE, formula = y~log(x) )	
	
#' 	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(1, cont'): 	
#' </span>	
#' 	
#' #### 1.3 With the mtcars.txt data, use ggplot to plot x = drat, y = hp. Add a line to your plot. Feel free to change the line color, theme, point color, etc.	
#' 	
#' ---	
#' 	
#' 	
#' # 2. Loops and apply functions	
#' 	
#' 	
################################  EXAMPLE 1 ################################	
# for and while loops	
################################  EXAMPLE 1 ################################	
# for loops repeat a specific number of times	
for(i in 1:10){	
     print(i + 100)	
}	
	
# make fake data	
df1 <- data.frame(person = c("bob", "sue", "jack", "ann"), number1 = c(4,5,6,1), number2 = c(2,4,6,6))	
df1	
	
# another for loop	
for(ii in df1$person){	
    print(rep(ii, times = df1[df1$person == ii, "number1"]))	
}	
	
	
# another for loop to make lots of plots	
for(foo in c("wt", "hp", "mpg", "qsec", "disp")){	
     hist(crs[ , foo], main = foo)	
     rug(crs[ ,foo])	
}	
	
	
	
## while loops repeat until something happens	
x <- 1	
while(x < 10){	
     print(x + 100) 	
     x <- x + 1	
}	
	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(2): 	
#' </span>	
#' 	
#' ### 2.1 Write a for loop to print the numbers 1:100	
#' 	
#' ---	
#' 	
#' 	
	
################################  EXAMPLE 2 ################################	
# if/else	
################################  EXAMPLE 2 ################################	
	
# you can use "if" and "else" inside loops to do different things	
	
for(i in 1:10){	
     if(i > 5) print(i + 100)	
     else print("hello")	
}	
	
# same	
for(i in 1:10){	
     if(i > 5){	
         print(i + 100) 	
     } 	
     else{	
          print("hello")	
     } 	
}	
	
	
# example with data frame	
for(nums in 1:length(df1$number1)){	
     print(nums)	
}	
	
	
for(nums in 1:length(df1$number1)){	
     print(as.character(df1$person[nums]))	
}	
	
for(nums in 1:length(df1$number1)){	
     if(as.character(df1$person[nums]) == "sue"){	
          print("sue was here")	
     }	
     else if(as.character(df1$person[nums]) == "bob"){	
          print("bob was here")	
     }	
     else print("ann or jack")	
}	
	
# example of making a new vector	
vec1 <- rep(NA, nrow(df1))	
for(nums in 1:length(df1$number1)){	
     if(as.character(df1$person[nums]) == "sue"){	
          vec1[nums] <- ("sue was here")	
     }	
     else if(as.character(df1$person[nums]) == "bob"){	
          vec1[nums] <- ("bob was here")	
     }	
     else vec1[nums] <- ("ann or jack")	
}	
	
vec1	
	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(2, cont'): 	
#' </span>	
#' 	
#' ### 2.2 Write one for loop for the numbers 1:100.  	
#' * If the number is > 25, print "low"	
#' * If the number is >= 25 and <= 75, print "middle"	
#' * If the number is > 75, print "High"	
#' 	
#' ### Extra Practice	
#' ### Write a for loop that cycles through the columns of the mtcars.txt dataset (called "crs", earlier), and makes a histogram, only if the column is numeric.	
#' 	
#' ---	
#' 	
#' ## Apply functions	
#' 	
#' 	
	
################################  EXAMPLE 2 ################################	
# apply functions	
################################  EXAMPLE 2 ################################	
	
# here's a simple function	
x2 <- function(x) x^2	
	
x2(5)	
	
# here is a function	
trimMean <- function(vect) {	
     qs <- quantile(vect, probs = c(.10, .90))	
     mean(vect[vect > qs[1] & vect < qs[2]])	
}	
	
nums <- c(1:100, 1000)	
nums2 <- c(50:100, 1500, 1)	
nums3 <- c(1,3,5,6,7,7,5,4,34,.76,87,8,8,8,6,5,4.4,4,56,7,7,88,33)	
	
# make a new list, from our numbers	
listNums <- list(nums, nums2, nums3)	
	
trimMean(nums)	
trimMean(nums2)	
trimMean(nums3)	
	
# trimMean(listNums) doesn't work	
# trimMean(nums, nums2) #doesn't work	
trimMean(c(nums, nums2, nums3)) # doesn't give three different numbers	
	
# we could write a for loop	
listMNS <- numeric(length(listNums))	
for(i in 1:length(listNums)){	
     listMNS[i] <- trimMean(listNums[[i]])	
}	
listMNS	
	
# or we could use apply	
sapply(listNums, FUN = trimMean)	
	
	
## Apply functions are often faster than loops	
	
# this for loop is slow, because we grow the newVec variable on every iteration of the loop	
# note: loop isn't needed here, you could just use 1:30000 + 100 to get a new vector.	
system.time({	
     newVec <- numeric()	
     for(ii in 1:30000){	
          newVec[ii] <- ii + 100	
     }	
})	
head(newVec)	
	
	
## sapply function (for illustration only....sapply is not necessary here)	
# first, we write a function for what we want to happen	
x100 <- function(x) x + 100	
	
	
# apply that function to a vector	
system.time({	
     newVec.sa <- sapply(X = 1:100000, FUN = x100)	
})	
	
head(newVec.sa)	
	
	
	
	
## you can speed up a for-loop by pre-allocating space	
system.time({	
	
     newVec <- numeric(100000)	
     for(ii in 1:100000){	
          newVec[ii] <- ii + 100	
     }	
})	
	
	
## you can use apply functions on a data frame	
	
# say you want to calculate the trimmed mean (removing the max and min) for several columns in your data frame	
	
tMean <- function(x){	
     x <- x[x != min(x, na.rm = TRUE) & x != max(x, na.rm = TRUE)]	
     return(mean(x, na.rm=TRUE))	
}	
	
tMean(c(1:100, 10000, NA, NA))	
mean(c(1:100, 10000, NA), na.rm =TRUE)	
	
	
# you could use a for loop	
tms <- numeric()	
for(ii in c("temp", "humidity", "int", "slope")){	
     tms[ii] <- tMean(flr[, ii])	
}	
	
tms	
	
# or you could use apply	
# apply allows you to choose the margin -- I think it converts to a matrix first	
apply(X = flr[, c("temp", "humidity", "int", "slope")], MARGIN = 2, FUN = tMean)	
	
# same thing	
sapply(X = flr[, c("temp", "humidity", "int", "slope")], FUN = tMean)	
	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(2, cont'): 	
#' </span>	
#' 	
#' ### 2.3 The following function prints the max or the highest level of a factor.	
#' 	
#' 	
maxHighF <- function(thing) {	
     if(is.numeric(thing)) return(max(thing, na.rm = TRUE))	
     else if(is.factor(thing)) return(levels(thing)[length(levels(thing))])	
     else return(NA)	
}	
#' 	
#' 	
#' You'll notice this:	
#' 	
#'      maxHighF(crs$hp) # works	
#'      maxHighF(flr$trt) # works	
#'      maxHighF(flr[, c("trt", "humidity")]) # doesn't work	
#' 	
#' ### Apply this function to every column of the flower data frame, using sapply	
#' 	
#' 	
#' ---	
#' 	
#' 	
#' ## Writing your own functions	
#' 	
#' 	
#' 	
# functions take in something, do something, then output something	
	
# example 1	
printNum.plus5 <- function(num){	
     print(num + 5)	
}	
	
	
printNum.plus5(5)	
printNum.plus5(1000)	
	
	
# example 2	
plotWithAxisLabels <- function(x1, y1){	
     plot(x = x1, y = y1, xlab = "Here is x1", ylab = "Here is y1", 	
          bty = "l", pch = 20)	
}	
	
plotWithAxisLabels(x1 = flr$distance, y1 = flr$slope)	
	
	
# example 3 with sapply	
# fake data	
df1 <- data.frame(person = c("bob", "sue", "jack", "ann"), number1 = c(4,5,6,1), number2 = c(2,4,6,6))		
df1	
	
# want to convert to long format	
longerizer1 <- function(name){	
     rep(name, times = df1[df1$person == name, "number1"])	
}	
	
longerizer1("bob")	
df1	
longerizer1("sue")	
	
longerizer1(c("bob", "sue"))	
	
#' 	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Exercises(3): 	
#' </span>	
#' 	
#' ### Write a function that takes a column name from the flr dataframe as an argument.  If the column is numeric, make a scatterplot of x = that column, y = int, with points colored red.  If the column is a factor, then make a boxplot of x = column, y = int, where the boxes are filled with blue.	
#' 	
#' ---	
#' 	
#' <span style="color:red; font-family:Georgia; font-size:2em;">	
#' Extra Practice: 	
#' </span>	
#' 	
#' ### E.1 Read in the "loblolly.txt" dataset, if you haven't already.  Call it "lob". Use ggplot() to plot a scatterplot (geom_point()) with x= age, y = height.	
#' 	
#' ### E.2 Using the "lob" dataframe, convert "age" to a factor. 	
#'      	
#'      lob$age <- as.factor(lob$age)	
#' 	
#' ### Now make a boxplot where x = age, and y = height with ggplot()	
#' 	
#' 	
#' ### E.3 Using the "lob" dataframe, add points to the boxplot from 3.7. *Advanced change the color of the points, based on the "Seed" variable from the "lob" dataframe (you may want to convert it to a factor first)*	
#' 	
#' 	
#' ### E.4 Change the theme from your previous plot to the "classic" theme with theme_classic().	
#' 	
#' 	
