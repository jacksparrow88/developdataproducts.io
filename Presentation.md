---
title: "Coursera Developing Data Products"
author: "Himanshu Singh"
highlighter: highlight.js
hitheme: tomorrow
knit: slidify::knit2slides
mode: selfcontained
subtitle: Project Deck
framework: io2012
widgets: []
---

## US Rig Count Dataset Explorer  

This Shiny App is for searching and visulizating US Rig Count information from year 1987 to 2015. The total number of records is 333, seperated across Onshore, Offshore, Crude Oil and Natura Gas Rigs.
The dataset is from U.S. Energy Information Administration (http://www.eia.gov/dnav/ng/NG_ENR_DRILL_S1_M.htm).  

Data Source: http://www.eia.gov/dnav/ng/NG_ENR_DRILL_S1_M.htm  
  

--- .class #id 

# The Data for the Rig Counts

```
##         Date TotalNumberofRigs Onshore Offshore CrudeOil NaturalGas Year
## 1 1987-08-01              1003     894      109      626        352 1987
## 2 1987-09-01              1101     987      114      713        364 1987
## 3 1987-10-01              1124    1008      116      727        377 1987
## 4 1987-11-01              1152    1034      118      746        386 1987
## 5 1987-12-01              1162    1034      128      746        403 1987
## 6 1988-01-01              1076     949      127      663        391 1988
```
# Melted Flat Dataset


```
##         Date Year variable value
## 1 1987-08-01 1987  Onshore   894
## 2 1987-09-01 1987  Onshore   987
## 3 1987-10-01 1987  Onshore  1008
## 4 1987-11-01 1987  Onshore  1034
## 5 1987-12-01 1987  Onshore  1034
## 6 1988-01-01 1988  Onshore   949
```

--- .class #id 

## Total Number of Rig Counts in the US for each type

<iframe src=' assets/fig/unnamed-chunk-3-1.html ' scrolling='no' frameBorder='0' seamless class='rChart nvd3 ' id=iframe- chart2d3c19fa2c2b ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>

--- .class #id 

## Total Number of Rig Counts in the US

<iframe src=' assets/fig/unnamed-chunk-4-1.html ' scrolling='no' frameBorder='0' seamless class='rChart nvd3 ' id=iframe- chart2d3c20d94e3c ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>

