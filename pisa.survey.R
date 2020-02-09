updateCheckboxGroupInput(session, "show_survey_vars", "", colnames(surveyAnalyze), selected = c("Country", "subject", "variable", "r.squared", "p.value"), inline=TRUE)

output$surveyTable = DT::renderDataTable(
  surveyAnalyze%>%select(input$show_survey_vars),
  filter = 'top', 
  server = TRUE,
  rownames= FALSE,
  #extensions = 'Buttons',
  options = list(
    pageLength = 5,
    scrollX = TRUE,
    fixedColumns = TRUE,
    # order = list(list(5, 'desc')),
    searchCols = list(
      list(search = 'Israel'),
      list(search = 'ESCS')
    )
    #dom = 'Bfrtip',
    #buttons = c('copy', 'excel')
  )
)