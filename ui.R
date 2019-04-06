library(shiny)
shinyUI(fluidPage(
  fluidRow(
    column(4,offset=3,
           h4("Select lower and upper population limits")
    )
  ),
  
  fluidRow(
    column(4,offset=3,
           sliderInput("sliderPop", "",10000, 40*10^6, value = c(4*10^6, 6*10^6))
    ),
    column(4,
           checkboxInput("show_labels", "Show/Hide Labels",value=TRUE)
    )
  ),
 
  
  fluidRow(
    column(12,div(style="height:10px"),plotOutput('plot1',height="400px") )
    
  )
  
  ,
  
  
  fluidRow(
    
    column(12,align="center", h5("Count of cities:"),textOutput('text1') )
    
  )
  
  ,
  fluidRow(
    column(12,div(style="height:10px"),plotOutput('plot3') )
    
  )
  
  
)
)
