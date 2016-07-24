#################################################
#      Bi-plot App    #
#################################################

homebrew.biplot = function(data3,    # input data with row and col names
                           k1,       # arbit scale down factor for unit locations
                           k4,cex,cex2
                           ){       # how many units to show on the plot
  fit.pc = princomp(data3, 
                    cor = TRUE, 
                    scores = TRUE)
  plot(fit.pc$loadings[,1:2], # use only top 2 prinComps
       
       type ="n",
       bg = "beige",
       xlim=c(-1.5,1.5), 
       ylim=c(-1.5,1.5), # plot parms
       
       main ="Biplot - Home-brew on R") # plot title
  abline(h=0); abline(v=0) # build horiz & vert axes
  attribnames = colnames(data3)
  brdnames = rownames(data3)
  # <-- insert attrib vectors as arrows--
  for (i1 in 1:nrow(fit.pc$loadings)){
    
    arrows(0, 0, 
           x1 = fit.pc$loadings[i1,1]*fit.pc$sdev[1], 
           y1 = fit.pc$loadings[i1,2]*fit.pc$sdev[2], col="blue", lwd=1.5);
    
    text(x = fit.pc$loadings[i1,1]*fit.pc$sdev[1], 
         y = fit.pc$loadings[i1,2]*fit.pc$sdev[2], 
         labels = attribnames[i1], 
         col="blue", 
         cex=cex2)}
  # --- add preferences to map ---#
  # k1 = 2.5;                                           # arbit scale-down factor
  k2 = min(k4, nrow(fit.pc$scores))
  set.seed(0201989)
  k3 = sample(1:nrow(fit.pc$scores),k2,replace = F)
  #   a0 = runif(k2)
  #   k3 = round(a0*nrow(data3), 0)
  
  for (i1 in 1:k2){
    
    i2 = k3[i1]
    
    points(x = fit.pc$scores[i2, 1]/k1, 
           y = fit.pc$scores[i2, 2]/k1, 
           pch=19, 
           col="black")
    
    text(x = fit.pc$scores[i2,1]/k1, 
         y = fit.pc$scores[i2,2]/k1, 
         labels = rownames(fit.pc$scores)[i2], 
         adj = c(0.5, 0.5), 
         col ="red", 
         cex = cex)  }
} 

shinyServer(function(input, output,session) {
  
  output$downloadData <- downloadHandler(
    filename = function() { "socioeconomics.csv" },
    content = function(file) {
      write.csv(read.csv("data/bi-plot example data socioeconomics.csv"), file, row.names=F, col.names=F)
    }
  )
  
Dataset <- reactive({
  if (is.null(input$file)) { return(NULL) }
  else{
    Dataset <- as.data.frame(read.csv(input$file$datapath ,header=TRUE, sep = ","))
    row.names(Dataset) = Dataset[,1]
    Dataset = Dataset[,2:ncol(Dataset)]
    return(Dataset)
  }
})

output$biplot = renderPlot({
  if (is.null(input$file)) { return(NULL) }
  else{
  homebrew.biplot(Dataset(), input$k1, input$k4, input$cex,input$cex2)  
}
  })





})

