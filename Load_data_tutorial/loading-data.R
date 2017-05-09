#####
#
# Loading and Formatting Data
#
#####


# Prelim: Export from Excel, Google Spreadsheets, download as CSV, etc.


#
# Load CSV files
#

income <- read.csv("Load_data_tutorial/data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.csv")

# Be more specific.
income <- read.csv("Load_data_tutorial/data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.csv", stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))

# Tab-delimited
income <- read.csv("Load_data_tutorial/data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.tsv", stringsAsFactors=FALSE, sep="\t", colClasses=c("GEO.id2"="character"))

# Load from URL
income <- read.csv("http://datasets.flowingdata.com/tuts/2015/load-data/ACS_13_5YR_S1903.csv", stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))


#
# Structure
#

str(income)
head(income)
dim(income)
names(income)

# Quick summary
summary(income)


#
# Subset
#

# Just the first columns
income_total <- income[,1:7]
head(income_total)
dim(income_total)

# Based on value
income_upper <- subset(income_total, HC02_EST_VC02 >= 58985)

# Extract missing data (in thise case, returns empty)
income_without_na <- na.omit(income)


#
# Edit
#

# Change column names
names(income_total) <- c("id", "FIPS", "name", "households", "households_moe", "med_income", "med_income_moe")
head(income_total)

# New columns
income_total$med_min <- income_total$med_income - income_total$med_income_moe
income_total$med_max <- income_total$med_income + income_total$med_income_moe

# Convert existing column
income_total$med_min <- income_total$med_min / 1000
income_total$med_max <- income_total$med_max / 1000


#
# Merge
#

# Load two datasets
income2008 <- read.csv("data/ACS_08_3YR_S1903/ACS_08_3YR_S1903.csv", stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))
income2013 <- read.csv("data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.csv", stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))

# Subset
income2008p <- income2008[,c("GEO.id2", "HC02_EST_VC02", "HC02_MOE_VC02")]
income2013p <- income2013[,c("GEO.id2", "HC02_EST_VC02", "HC02_MOE_VC02")]

# Rename headers
names(income2008p) <- c("FIPS", "med2008", "moe2008")
names(income2013p) <- c("FIPS", "med2013", "moe2013")

# Combine
income0813 <- merge(income2008p, income2013p, by="FIPS")
head(income0813)

#
# Save data file
#

write.table(income_total, "data/income-totals.csv", row.names=FALSE, sep=",")
write.table(income0813, "data/income-2008-13.csv", row.names=FALSE, sep=",")
