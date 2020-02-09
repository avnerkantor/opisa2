
# updateSelectInput(session, "analyzeVariables", "", c("All", analyzeVariables%>%select(variable)%>%unlist()%>%as.vector()))

updateCheckboxGroupInput(session, "show_vars", "", colnames(analyzeData), selected = c("Country", "Subject", "variable", "r.squared", "p.value"), inline=TRUE)

output$analyzeTable = DT::renderDataTable(
  
  analyzeData%>%select(input$show_vars),
  filter = 'top', 
  server = TRUE,
  rownames= FALSE,
  #extensions = 'Buttons',
  options = list(
    pageLength = 5,
    scrollX = TRUE,
    fixedColumns = TRUE,
    order = list(list(3, 'desc')),
    searchCols = list(
      list(search = 'Israel'),
      list(search = 'Math')
    )
    #dom = 'Bfrtip',
    #buttons = c('copy', 'excel')
  )
)

# output$variablesTable = renderDT(
#   
#   surveyVariables%>%
#     mutate(Type="survey")%>%
#     bind_rows(analyzeVariables%>%mutate(Type="indices")),
#   filter = 'top', 
#   server = TRUE,
#   rownames= FALSE,
#   #extensions = 'Buttons',
#   options = list(
#     pageLength = 5,
#     autoWidth = TRUE
#     #dom = 'Bfrtip',
#     #buttons = c('copy', 'excel')
#   )
# )

