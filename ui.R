library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
        navbarPage("US Rig Counts", 
                   tabPanel("Explore the Data",
                            sidebarPanel(
                                    sliderInput("timeline", 
                                                "Timeline:", 
                                                min = 1987,
                                                max = 2017,
                                                sep = "",
                                                value = c(2010, 2015)),
                                    uiOutput("rigtypesControl")
                                    
                            ),
                            mainPanel(
                                    tabsetPanel(
                                            # Data 
                                            tabPanel(p(icon("table"), "Dataset"),
                                                     dataTableOutput(outputId="dTable")
                                            ), # end of "Dataset" tab panel
                                            tabPanel(p(icon("line-chart"), "Visualize the Data"),
                                                     h4('Number of Rigs by Year', align = "center"),
                                                     h5('Please hover over each point to see the Total Number of Rigs.', 
                                                        align ="center"),
                                                     showOutput("RigsByYear", "nvd3"),
                                                     h4('Number of Rigs by Year and Rig Type', align = "center"),
                                                     h5('Please hover over each point to see the Total Number of Rigs for each Type.', 
                                                        align ="center"),
                                                     showOutput("RigsByYearAndRigType", "nvd3")
                                            ) # end of "Visualize the Data" tab panel
                                            
                                    )
                                    
                            )     
                   ), # end of "Explore Dataset" tab panel
                   
                   tabPanel("About",
                            mainPanel(
                                    includeMarkdown("about.md")
                            )
                   ) # end of "About" tab panel
        )  
)