# (shiny.sanitize.errors = FALSE)
library(readr)
library(readxl)

load("data/pisaScores.rda")
# load("data/surveyAnalyze2.rda")
load("data/analyzeData4.rda")
analyzeData<-analyzeData%>%select(-estimate, -std.error)
load("data/israel2018a.rda")

countries <- read_csv("data/countries.csv")

pisaScores<-pisaScores%>%left_join(countries, by="Country")%>%select(-Country)%>%rename(Country=Hebrew)
# surveyData<-surveyData%>%left_join(countries, by="Country")%>%select(-Country)%>%rename(Country=Hebrew)


ExpertiseLevels<-read.csv("data/ExpertiseLevels.csv", header = TRUE, sep=",")
ExpertiseLevelsLimits<-read.csv("data/expertiseLevelsLimits.csv", header = TRUE, sep=",")
# LevelExplenation<-read.csv("data/LevelExplenation.csv", header = TRUE, sep=",")

groupColours<- c(
  General="#b276b2", 
  Male="#5da5da", 
  Female="#f17cb0", 
  GeneralLow="#bc99c7", 
  GeneralMedium="#b276b2", 
  GeneralHigh="#7b3a96", 
  MaleHigh="#265dab", 
  MaleLow="#88bde6", 
  MaleMedium="#5da5da", 
  FemaleHigh="#e5126f", 
  FemaleLow="#f6aac9", 
  FemaleMedium="#f17cb0"
) 



shinyServer(function(input, output, session) {
  source('pisa.scores.R', local=TRUE)
  # source('pisa.survey.R', local=TRUE)
  source('pisa.analyze.R', local=TRUE)
  
  output$output <- renderPrint({
    input$eval1
    eval(parse(text = isolate(input$code)))
  })
  
  output$knitDoc <- renderUI({
    input$eval2
    HTML(knitr::knit2html(text = isolate(input$rmd), fragment.only = TRUE, quiet = TRUE))
  })
  

  # output$downloadData <- downloadHandler(
  #   filename = function() {
  #     data <- israel2018
  #     myfile <- "pisa_israel_2018.csv"
  #     write.csv(data, myfile)
  #     myfile
  #   },
  #   content = function(file) {
  #     file.copy(file, file)
  #   }
  # )
  
})



