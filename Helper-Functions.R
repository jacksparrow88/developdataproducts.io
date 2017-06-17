# setwd("c:/users/kadriu/Documents/GetHub/Coursera-Developing-Data-Products")

# require(data.table)
require(xlsx)
require(base64enc)
library(dplyr)
library(DT)
library(rCharts)
library(reshape)

# Read data
data <- read.xlsx("./USRigCount.xlsx", sheetName = "Aggregated", header=TRUE)
setnames(data, "Total.Rigs", "TotalNumberofRigs")
setnames(data, "Crude.Oil", "CrudeOil")
setnames(data, "Natural.Gas", "NaturalGas")
data$Year<-as.POSIXlt(data$Date)$year+1900
setnames(data, "Year", "Year")
flatdata<-melt(data[,c("Date","Year","Onshore","Offshore","CrudeOil","NaturalGas")], id=c("Date","Year"))

# Explorations and data checks
head(data)
sum(is.na(data)) # 0
length(unique(data$Date)) # 332
table(data$Date)
years <- sort(unique(data$Date))

## Helper functions


#' Select the year interval
#' @param dt data table
#' @param minYear
#' @param maxYear
#' @return data table
#'
groupByDate <- function(dt, minYear, maxYear) {
        result <- dt %>% filter(Year >= minYear, Year <= maxYear) 
        return(result)
}

#' Select the year interval and rig type
#' @param dt data table
#' @param minYear
#' @param maxYear
#' @return data table
#'
groupByDateAndRigType <- function(dt, minYear, maxYear, rigtypes) {
        result <- dt %>% filter(Year >= minYear, Year <= maxYear, variable %in% rigtypes) 
        return(result)
}

#' Plot number of rigs by year interval
#' 
#' @param dt data table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel number of rigs
#' @return RigsByYear plot
plotRigCountByYear <- function(dt, dom = "RigsByYear", 
                               xAxisLabel = "Date",
                               yAxisLabel = "Number of Rigs") {
        RigsByYear <- nPlot(
                TotalNumberofRigs ~ Date,
                data = dt,
                #stackedAreaChart
                #lineChart
                type = "scatterChart",
                dom = dom, width = 650
        )
        RigsByYear$chart(margin = list(left = 100, top = 100))
        RigsByYear$chart(color = c('purple', 'blue', 'green'))
        RigsByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
                         return '<h5><b>Total Rigs</b>: ' 
                         + e.point.TotalNumberofRigs + '<br>'
                         + '</h5>'
} !#")
        RigsByYear$yAxis(axisLabel = yAxisLabel, width = 80)
        RigsByYear$xAxis(axisLabel = xAxisLabel, width = 70)
        RigsByYear$xAxis(tickFormat ="#! function(d) {return d3.time.format('%Y/%m')(new Date(d*1000*3600*24));} !#")
        RigsByYear 
        }

#' Plot number of rigs by year interval
#' 
#' @param dt data table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel number of rigs
#' @return RigsByYear plot
plotRigCountByYearAndRigType <- function(dt, dom = "RigsByYearAndRigType", 
                                         xAxisLabel = "Date",
                                         yAxisLabel = "Number of Rigs") {
        RigsByYear <- nPlot(
                value ~ Date,
                group = 'variable',
                data = dt,
                #stackedAreaChart
                #lineChart
                type = "lineChart",
                dom = dom, width = 650
        )
        RigsByYear$chart(margin = list(left = 100, top = 100))
        RigsByYear$chart(color = c('purple', 'blue', 'green', 'red'))
        RigsByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
                   return '<h5><b>Total Rigs</b>: ' 
                   + e.point.value + '<br>'
                   + '</h5>'
} !#")
        RigsByYear$yAxis(axisLabel = yAxisLabel, width = 80)
        RigsByYear$xAxis(axisLabel = xAxisLabel, width = 70)
        RigsByYear$xAxis(tickFormat ="#! function(d) {return d3.time.format('%Y/%m')(new Date(d*1000*3600*24));} !#")
        RigsByYear 
}