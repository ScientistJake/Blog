shinyUI(fluidPage(
  h1("Clickable Volcano Plots!"),
  selectInput('inputFile', label='select a file:',choice='WT.mut'),
  plotOutput('volcanoPlot',click='plot_click'),
  sliderInput('cpmCut', label="log(CPM) cutoff",-10,10,-10, width="200px"),
  #here the table for the clicked points:
  tableOutput('clickedPoints')
))