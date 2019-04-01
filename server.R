function(input, output, session) {
  #### USEFUL FUNCTIONS ####
  read_data <- function(){
    path <- "data/spark_data.json"
    df <- sc %>%
    spark_read_json("name", path) %>%
    collect()
    return(df)
  }
  is_there_new_file <- function(){
    1
  }
  safe_plot_ly <- function(p){
    if (! is.null(p)){
      p$elementId <- NULL
      plotly_build(p)
    } else {
      plotly_empty(type="scatter")
    }
  }
  # data <- reactivePoll(30*1000, session, is_there_new_file, read_data)

  #### SUB_ONGLET_1_1 ####
  output$sub_onglet1_1_input_vars <- renderUI({
    list(selectInput("sub_onglet1_1_vars", "Variables à analyser", choices=vars, selected="latency"),
         selectInput("sub_onglet1_1_program", "Programmes à analyser", choices=programs, selected="tricky"))
  })
  output$sub_onglet1_1_plot <- renderPlotly({
    req(input$sub_onglet1_1_program, input$sub_onglet1_1_vars)
    df = streaming_data[streaming_data$program == input$sub_onglet1_1_program, ]
    plot = ggplot(data=df, aes(x=timestamps, y=get(input$sub_onglet1_1_vars))) +
      geom_line(color='steelblue', size=1, alpha=0.4) +
      scale_x_datetime(labels=date_format("%D/%m %H:%M"), breaks=date_breaks("6 hours")) +
      labs(y=input$sub_onglet1_1_vars) +
      theme(axis.text.x=element_text(angle=45, vjust=1, hjust=1))
    safe_plot_ly(plot)
  })

  #### SUB_ONGLET_1_2 ####
  output$sub_onglet1_2_input_vars <- renderUI({
    list(selectInput("sub_onglet1_2_vars", "Variables à analyser", choices=vars, selected="latency"),
         selectInput("sub_onglet1_2_program", "Programmes à analyser", choices=programs, selected="tricky"))
  })
  output$sub_onglet1_2_input_password <- renderUI({
    passwordInput("sub_onglet1_2_password", "Password :", value="")
  })
  output$sub_onglet1_2_plotly <- renderPlotly({
    req(input$sub_onglet1_2_vars, input$sub_onglet1_2_program, input$sub_onglet1_2_password)
    if(input$sub_onglet1_2_password == "XD"){
      df = streaming_data[(streaming_data$program == input$sub_onglet1_2_program), ]
      plot = ggplot(data=streaming_data, aes(x=timestamps, y=get(input$sub_onglet1_2_vars))) +
        geom_line(color='steelblue', size=1, alpha=0.4) +
        scale_x_datetime(labels=date_format("%D/%m %H:%M"), breaks=date_breaks("6 hours")) +
        labs(y=input$sub_onglet1_2_vars) +
        theme(axis.text.x=element_text(angle=45, vjust=1, hjust=1))
      safe_plot_ly(plot)
    } else {
      plotly_empty(type="scatter")
    }
  })

  #### BULLSHIT FANCY MENU ####
  output$messageMenu <- renderMenu({
    from <- c("Mario", "OSS117")
    message <- c("Hey it's me, ...", "23 à 0! C'est la piquette Jack! Tu sais pas jouer Jack! T'es mauvais!")
    messageData <- data.frame(from, message)
    msgs <- apply(messageData, 1, function(row){
      messageItem(from=row[["from"]], message=row[["message"]])
    })
    dropdownMenu(type="messages", .list=msgs)
  })
  output$notifMenu <- renderMenu({
    text <- c("On me dit le plus grand bien des harengs pommes à l'huile")
    status <- c("success")
    notifData <- data.frame(text, status)
    notifs <- apply(notifData, 1, function(row){
      notificationItem(text=row[["text"]], icon=shiny::icon("warning"), status=row[["status"]])
    })
    dropdownMenu(type="notifications", badgeStatus="info", .list=notifs)
  })
  output$taskMenu <- renderMenu({
    value <- c(100, 75)
    color <- c("green", "aqua")
    text <- c("Ayy", "Comment est votre blanquette ?")
    taskData <- data.frame(value, color, text)
    tasks <- apply(taskData, 1, function(row){
      taskItem(text=row[["text"]], value=row[["value"]], color=row[["color"]])
    })
    dropdownMenu(type="tasks", badgeStatus="success", .list=tasks)
  })
  #### USEFUL FUNCTIONS ####
  observeEvent(input$close, {
    js$closeWindow()
    stopApp()
  })
  session$onSessionEnded(stopApp)
}
