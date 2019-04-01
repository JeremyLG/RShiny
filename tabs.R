jscode <- "shinyjs.closeWindow = function() { window.close(); }"

sub_onglet1_1 <- tabItem(tabName= "sub_onglet1_1",
                        fluidRow(
                          uiOutput("sub_onglet1_1_input_vars"),
                          plotlyOutput("sub_onglet1_1_plot", height="600")
                        )
                      )

sub_onglet1_2 <- tabItem(tabName= "sub_onglet1_2",
                        fluidRow(
                          column(4, uiOutput("sub_onglet1_2_input_password")),
                          column(4, uiOutput("sub_onglet1_2_input_vars")),
                          column(4, uiOutput("sub_onglet1_2_input_calendar"))
                        ),
                        fluidRow(
                          plotlyOutput("sub_onglet1_2_plotly", height="600")
                        )
                      )

sub_onglet1_3 <- tabItem(tabName= "sub_onglet1_3",
                        fluidRow(
                          uiOutput("sub_onglet1_3_input"),
                          plotlyOutput("sub_onglet1_3_plot", height="600")
                        )
                      )
