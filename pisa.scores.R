updateSelectInput(session, "Country1", choices = unique(countries$Hebrew), selected = "ישראל")
updateSelectInput(session, "Country2", choices = unique(countries$Hebrew), selected = "הולנד")

v <- reactiveValues(data = NULL)

observeEvent(input$Gender, {
  v$Gender <- input$Gender
})

observeEvent(input$Escs, {
  v$Escs <- input$Escs
})

observeEvent(input$generalBtn, {
  v$Gender <- NULL
})

observe({
  
  SubjectExpertiseLevels<-ExpertiseLevels %>%
    select(Level, contains(input$Subject))%>%
    filter(!is.na(input$Subject))
  
  plotData1<-pisaScores%>%filter(Subject==input$Subject)%>%select(-Subject)
  #TODO
  if(is.null(input$Gender)){
    if(is.null(input$Escs)){
      plotData2<-plotData1 %>%
        filter(Gender==0, ESCS==0)
    } else {
      plotData2<- plotData1 %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    }
  } else {
    if(length(input$Gender)==1){
      if(is.null(input$Escs)) {
        plotData2<- plotData1 %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS == 0)
      } else {
        plotData2<- plotData1 %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS %in% c(input$Escs))
      }
    } else {
      plotData2<- plotData1 %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    } 
  }
  
  scoresPlotFunction<-function(country){
    
    plotData3 <- plotData2%>%filter(Country==country)
    
    participatedNumber<-length(unique(plotData3$Year))
    
    gg<-ggplot(plotData3, aes(x=Year, y=Average, colour=GenderESCS, text=round(Average))) +
      scale_colour_manual(values = groupColours) +
      guides(colour=FALSE) +
      labs(title="", y="רמת מיומנות" ,x= "שנת מבחן") +
      theme_bw() +
      #geom_label() +
      theme(plot.margin=unit(c(0,15,5,10), "pt"),
            panel.border = element_blank(),
            axis.ticks = element_blank(),
            panel.grid.major.x=element_blank(),
            panel.grid.major.y = element_line(colour="#e0e0e0", size=0.3),
            legend.position="none",
            axis.line = element_line(color="#c7c7c7", size = 0.3),
            axis.title=element_text(colour="#777777", size = 10)
      ) +
      scale_x_continuous(breaks=c(2006, 2009, 2012, 2015, 2018)) +
      scale_y_continuous(
        #minor_breaks=SubjectExpertiseLevels[2],
        breaks=SubjectExpertiseLevels[2],
        labels=SubjectExpertiseLevels[1],
        #limits = c(200,700),
        limits=c(as.numeric(unlist(ExpertiseLevelsLimits[input$Subject])))
      )
    
    if(participatedNumber>0) {
      if(participatedNumber>1) {
        gp<-gg+geom_line(size=1)
        ggplotly(gp, tooltip = c("text"))%>%
          config(p = ., displayModeBar = FALSE)%>%
          layout(hovermode="x")
        
      } else{
        gp<-gg+geom_point(size=2)
        ggplotly(gp, tooltip = c("text"))%>%
          config(p = ., displayModeBar = FALSE)%>%
          layout(hovermode="x")
      }
    } 
    else 
    {
      gg+annotate("text", label = "לא השתתפו",
                  x = 2012, y = 500, size = 6, 
                  colour = "#c7c7c7")%>%config(p = ., displayModeBar = FALSE)
    }
  }
  
  if(!input$Country1==""){
    output$Country1Plot<-renderPlotly({
      scoresPlotFunction(input$Country1)
    })
    output$Country2Plot<-renderPlotly({
      scoresPlotFunction(input$Country2)
    })
  }
})





