####################################################
#      Bi-Plot App    #
####################################################

library("shiny")
#library("foreign")

shinyUI(pageWithSidebar(
  # Header:
  headerPanel("Bi Plot App"),
  # Input in sidepanel:
  sidebarPanel(

    h5(p("Data Input")),
    fileInput("file", "Upload input data (csv file with header))"),
    sliderInput("k1", "Scale down factor", min = 0.1,  max = 10, value = 1.8,round = FALSE),
    sliderInput("k4", "No of data points to print", min = 0,  max = 400, value = 50),
    sliderInput("cex", "Data point labels font size", min = 0.1,  max = 10, value = 1,round = FALSE),
    sliderInput("cex2", "Attribute labels font size", min = 0.1,  max = 10, value = 1.2,round = FALSE),
    br()
  ),
  # Main:
  mainPanel( 
    
    tabsetPanel(type = "tabs",
                #
                tabPanel("BiPlot",plotOutput("biplot", height = 800, width = 840))
                )
            ) 
        ) 
    )
