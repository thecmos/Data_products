
shinyUI(fluidPage(
  fluidRow(
    column(12,offset=4,
           h4("Select lower and upper population limits")
    )
  ),
  
  fluidRow(
    column(12,offset=4,
           sliderInput("sliderPop", "",10000, 40*10^6, value = c(4*10^6, 6*10^6))
    )
  ),
  fluidRow(
    column(2,offset=2,
           checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE)
    ),
    column(2,
           checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE)
    ),
    column(2,
           checkboxInput("show_title", "Show/Hide Title",value=TRUE)
    ),
    column(2,
           checkboxInput("show_labels", "Show/Hide Labels",value=TRUE)
    )
    
  ),
  hr(),
  fluidRow(
    column(12,div(style="height:10px"),plotOutput('plot1') )
    
  )
  ,
  fluidRow(
    
    column(12,align="center",offsett=5, div(style="height:10px"), h5("Count of cities:"),textOutput('text1') )
    
  )
  
  ,
  fluidRow(
    column(12,div(style="height:10px"),plotOutput('plot3') )
    
  )
  
)
)

