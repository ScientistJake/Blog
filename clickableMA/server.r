server <- function(input, output, session){
  
  #read in the table as a function of the select input
  dataFrame <- reactive({
    filename <- paste0("tags.de.",input$inputFile,".txt")
    read.table(file=filename, header=T, sep='\t')
  })
  
  # filter the table by CPM:
  dataFilter <- reactive({
    dataFrame()[dataFrame()$logCPM > input$cpmCut,]
  })
  
  #plot it normally with ggplot:
  output$volcanoPlot <- renderPlot({ 
    ggplot(dataFilter(),aes(x=logFC, y=negLogFDR, color=sig)) +
      geom_point() +
      coord_cartesian() +
      ylab("-log10 FDR") +
      xlab("log2 fold change")
  })
  
  #get the clicked points!
  clicked <- reactive({
    # We need to tell it what the x and y variables are:
    nearPoints(dataFilter(), input$plot_click, xvar = "logFC", yvar = "negLogFDR")
  })
  
  #output those points into a table
  
  output$clickedPoints <- renderTable({
    clicked()
  }, rownames = T)
}