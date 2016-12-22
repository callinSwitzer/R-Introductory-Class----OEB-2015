# Callin Switzer
# 15 Sept 2015
# Session 1

var1 <- "hi"
var2 <- 4
var2
var3 <- "Hello people!"

var4 <- matrix(1:10, ncol= 2)
var4

var4 + 4

myVar = "4"
class(myVar)
typeof(myVar)
mode(myVar)


# 7 Data types:
# factors
var1 <- "a"
var1 <- 4
fac1 <- factor("a")
class(fac1)
fc2 <- factor(x = c("a", "b", "c"))
fc2


# character
ch1 <- "foo"
class(ch1)
  
# numeric
num1 <- 4
class(num1)

myVar1 <- as.numeric(myVar)


# logical
tf1 <- TRUE
class(tf1)

# null
N1 <- NULL
N1


# 8 Data structures
# vectors
vec <- c(1,2,45,6,7,8,8,6,45,43,4)
vec

vec1 <- c("hi", "boo", "Cat", "at")
vec3 <- c("hi", 'double')
class(vec3)
is.vector(vec3)


# matrix
mat <- matrix( 1 : 100 , nrow=10)
mat
mode(mat)
class(mat)


# factors problems
f2 <- factor(c(0, 14,2223,3123))
f2
as.numeric(f2)

f3 <- factor(c("a", "b", "c"))
f3
as.numeric(f3)

# lists
l1 <- list(var1, f2, f3, mat)
l1
l1[[1]]
l1[1:3]

# data frames
df1 <- as.data.frame(mat)
df1
class(df1)
mode(df1)

df1[["V1"]]
df1["V1"]

df1[2:5, 1]
df1[ , 5]
df1[[5]]

df1$V4

# 9 functions
summary(df1)
nrow(df1)
length(df1)

df1$ExtraCol <- 1:10
df1
length(df1)
length(df1$V1)
ncol(df1)
str(df1)
colnames(df1) <- c(letters[1:11])
colnames(df1)

colnames(df1)[3] <- "CO1"
colnames(df1)

head(df1)
tail(df1)

setwd("~/Dropbox/Harvard/RByCall/RClassMaterials/Session1")

file.choose()
dat <- read.csv("/Users/callinswitzer/Dropbox/Harvard/RByCall/RClassMaterials/Session1/FlowerPollenExperiment-ExampleRClass.csv")

