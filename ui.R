####################################################
#      Bi-Plot App    #
####################################################

library("shiny")
#library("foreign")

shinyUI(fluidPage(
  # Header:
  #headerPanel("Bi Plot App"),
  titlePanel(title=div(img(src="logo.png",align='right'),"Bi Plot App")),
  # Input in sidepanel:
  sidebarPanel(

    h5(p("Data Input")),
    fileInput("file", "Upload input data (csv file with header)"),
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
                tabPanel("Overview",
                         h4(p("Data input")),
                         p("To plot Bi-plot, this app needs one input from the user. In left-sidebar panel, click on Browse and upload the data file. Note that this data file should be in csv format with headers. Also first column of the data should be row names. You can download and see the example file for this app from below download link.",align="justify"),
                         
                         downloadButton('downloadData', 'Download Example file'),
                         
                         br(),br(),
                         
                         p("Please note that download will not work with RStudio interface. Download will work only in web-browsers. So open this app in a web-browser and then download the example file. For opening this app in web-browser click on \"Open in Browser\" as shown below -"),
                         
                         img(src = "example1.png")), #, height = 280, width = 400
                         
                tabPanel("BiPlot",plotOutput("biplot", height = 800, width = 840))
                )
            ) 
        ) 
    )
