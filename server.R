library(shiny)

# Load data processing file
source("Helper-Functions.R")
rigtypes <- c("Onshore", "Offshore", "CrudeOil", "NaturalGas")

# Shiny server
shinyServer(
        function(input, output) {
                
                # Initialize reactive values
                values <- reactiveValues()
                values$rigtypes <- rigtypes
                
                # Create event type checkbox
                output$rigtypesControl <- renderUI({
                        checkboxGroupInput('rigtypes', 'Rig Types:'
                                           ,rigtypes 
                                           ,selected = values$rigtypes)
                })
                
                
                # Prepare dataset
                dataTable <- reactive({
                        groupByDate(data, input$timeline[1], 
                                    input$timeline[2])
                })
                
                dataTable2 <- reactive({
                        groupByDateAndRigType(flatdata, input$timeline[1], 
                                              input$timeline[2],input$rigtypes )
                })
                
                # Render data table
                output$dTable <- renderDataTable({
                        dataTable()
                } #, options = list(bFilter = FALSE, iDisplayLength = 50)
                )
                
                
                output$RigsByYear <- renderChart({
                        plotRigCountByYear(dataTable())
                })
                
                
                output$RigsByYearAndRigType <- renderChart({
                        plotRigCountByYearAndRigType(dataTable2())
                })
                
        })    
# end of function(input, output)