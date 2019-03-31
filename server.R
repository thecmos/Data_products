library(shiny)
library(dplyr)
library(ggplot2)
library(rnaturalearth)
shinyServer(function(input, output) {
output$text1<- reactive({
  minX <- input$sliderPop[1]
  maxX <- input$sliderPop[2]
  worldcities<-read.csv("worldcities_comma.csv",sep=";")
  wc<-worldcities
  wc$lat<-gsub(",",".",wc$lat)
  wc$lng<-gsub(",",".",wc$lng)
  wc<-transform(wc,lat=as.numeric(lat),lng=as.numeric(lng))
  wccap<-filter(wc,capital=="primary")
  caps<-filter(wccap,population>minX & population<maxX)
  nrow(caps)
})

output$plot1 <- renderPlot({
  
  
  
  minX <- input$sliderPop[1]
  maxX <- input$sliderPop[2]
  worldcities<-read.csv("worldcities_comma.csv",sep=";")
  wc<-worldcities
  wc$lat<-gsub(",",".",wc$lat)
  wc$lng<-gsub(",",".",wc$lng)
  wc<-transform(wc,lat=as.numeric(lat),lng=as.numeric(lng))
  wccap<-filter(wc,capital=="primary")
  caps<-filter(wccap,population>minX & population<maxX)
  xlab <- ifelse(input$show_xlab, "Longitude", "")
  ylab <- ifelse(input$show_ylab, "Latitude", "")
  main <- ifelse(input$show_title, "Latitude and Longitude of the World Capitals within the selected population range", "")
  leg<- ifelse(input$show_legend, "right", "none")
  lab_sz<- ifelse(input$show_labels,4,0)
  
  spdf_world <- ne_countries()
  world<-fortify(spdf_world)
  
  g<-ggplot(world,aes(long,lat))
  g<- g+geom_polygon(aes(group = group), colour = "grey50", fill = NA) +
    coord_quickmap()
  g<-g+theme_bw()
  g<-g+geom_point(data=caps,mapping=aes(x=lng,y=lat,color=city,size=population,alpha=1/3))
  g<-g+theme(legend.position="none") 
  g<-g+ scale_x_continuous(limits = c(-180, 180))+scale_y_continuous(limits = c(-90, 90))+ labs(x=xlab,y=ylab,title=main,subtitle="Source: https://simplemaps.com/data/world-cities , as of August 2018")+ guides(color=guide_legend("Country"))
  g<-g+theme(plot.title = element_text(hjust = 0.5,size=20.25)) +theme(plot.subtitle=element_text(size=16, hjust=0.5, face="italic", color="blue"))
  
  g<-g+geom_text(data=caps,aes(x=lng,y=lat,label=city
  ) ,hjust=0.5, vjust=-1,size=lab_sz
  )
 g 
})


output$plot2<- renderPlot({
  minX <- input$sliderPop[1]
  maxX <- input$sliderPop[2]
  worldcities<-read.csv("worldcities_comma.csv",sep=";")
  wc<-worldcities
  wc$lat<-gsub(",",".",wc$lat)
  wc$lng<-gsub(",",".",wc$lng)
  wc<-transform(wc,lat=as.numeric(lat),lng=as.numeric(lng))
  wccap<-filter(wc,capital=="primary")
  caps<-filter(wccap,population>minX & population<maxX)
  
  ## h<-ggplot(caps,aes(x=lng,y=lat,color=iso3))+geom_point(size=4)+coord_cartesian(xlim=c(0,0),ylim=c(0,0))+ guides(color=guide_legend("Country"))+theme_bw()+scale_x_continuous(breaks = NULL)+scale_y_continuous(breaks = NULL)+theme(panel.border = element_blank())+labs(x=element_blank(),y=element_blank())+theme(legend.title=element_text(size=11),legend.text=element_text(size=10),legend.text.align=0,legend.position="top",legend.box="horizontal",legend.justification="center",legend.key.width=unit(2,"cm")) 
  ##h
  
})

output$plot3<- renderPlot({
  minX <- input$sliderPop[1]
  maxX <- input$sliderPop[2]
  worldcities<-read.csv("worldcities_comma.csv",sep=";")
  wc<-worldcities
  wc$lat<-gsub(",",".",wc$lat)
  wc$lng<-gsub(",",".",wc$lng)
  wc<-transform(wc,lat=as.numeric(lat),lng=as.numeric(lng))
  wccap<-filter(wc,capital=="primary")
  caps<-filter(wccap,population>minX & population<maxX)
  
  m<-ggplot(caps,aes(x=lng,y=lat,color=city))+geom_point(size=4)+coord_cartesian(xlim=c(0,0),ylim=c(0,0))+ guides(color=guide_legend(""))+theme_bw()+scale_x_continuous(breaks = NULL)+scale_y_continuous(breaks = NULL)+theme(panel.border = element_blank())+labs(x=element_blank(),y=element_blank())+theme(legend.title=element_text(size=11),legend.text=element_text(size=11),legend.text.align=0,legend.position="top",legend.box="horizontal",legend.justification="center",legend.key.width=unit(2,"cm")) 
  m
})

})

