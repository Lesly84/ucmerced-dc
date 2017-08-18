##Script from yosemite data carpentry 
##Lesly Lopez
##llopez84@ucmerced.edu


##Download data ----
#download.file("https://ndownloader.figshare.com/files/2292169",
#              "data/portal_data_joined.csv")

##Read in data into R ----
surveys <- read.csv("data/portal_data_joined.csv")

##Explore our data ----
##See first six rows of data
head(surveys)
##See last six rows of data
tail(surveys)
##See first 12 rows of data
tail(surveys,12)
##See structure of data
str(surveys)
##Get statistical info of data
summary(surveys)
dim(surveys)

##Plot data
plot(surveys$year,surveys$weight,'b')
hist(surveys$month)
##see factors in data
levels(surveys$taxa)
nlevels(surveys$taxa)

table(surveys$taxa)
hist(table(surveys$taxa))
barplot(table(surveys$taxa))


##Subset in base R ----
## [rows, columns]
surveys[surveys$genus=='Ammodramus', ]

##Return a few columns
surveys[surveys$genus=='Ammodramus',
        c('record_id','month','weight')]

##How many observations (rows) are there in Jan (1) and Feb(2)
nrow(surveys[surveys$month == 1 | surveys$month == 2, ]) #this or that
nrow(surveys[surveys$month == 1 & surveys$month == 2, ]) #this and that
nrow(surveys[surveys$month == 1, ])

##NOTE if written as below, integer 2 is always true => always get true
nrow(surveys[surveys$month == 1 | 2, ]) #this or that

dim(surveys[surveys$month == 1 | surveys$month == 2, ]) #this or that
## ?dim dimensions of an object; retrieve or set the dimension of an obj

table(surveys$month == 1 | surveys$month == 2)#get number of false and true cases

##How many observations before March (3)
length(which(surveys$month<3))
##Get which obs before March (3)
surveys[which(surveys$month <3),] #need comma because matrix
