source("tabs.R", chdir=T, encoding="utf-8")

dashboardPage(
  dashboardHeader(
    title="Sparklyr Shiny example",
    dropdownMenuOutput("messageMenu"),
    dropdownMenuOutput("taskMenu"),
    dropdownMenuOutput("notifMenu"),
    tags$li(
      class="dropdown",
      useShinyjs(),
      extendShinyjs(text=jscode, functions=c("closeWindow")),
      tags$li(
        class="dropdown",
        actionButton("close", "", icon("power-off"),
          style="color: #fff;height: 50px;text-align: center;border-radius:50%;width:50px;background-color: #f06292;border-color: #f06292")
        )
      )
    ),
  dashboardSidebar(
    tags$head(
      tags$script(
        HTML(
          "
          $(document).ready(function(){
          // Bind classes to menu items, easiet to fill in manually
          var ids = ['subItemOne','subItemTwo','subItemThree','subItemFour'];
          for(i=0; i<ids.length; i++){
          $('a[data-value='+ids[i]+']').addClass('my_subitem_class');
          }

          // Register click handeler
          $('.my_subitem_class').on('click',function(){
          // Unactive menuSubItems
          $('.my_subitem_class').parent().removeClass('active');
          })
          })
          "
        )
      ),
      tags$style("#plotly{height: 80vh !important;}"),
      tags$style("#plotlyy{height: 100vh !important;}")
    ),
    sidebarMenu(
      menuItem("Onglet1", tabName="sub_onglet1_1", icon=icon("heartbeat"),
        menuSubItem("SubOnget1_1", tabName="sub_onglet1_1", icon=icon("bar-chart")),
        menuSubItem("SubOnglet1_2", tabName="sub_onglet1_2", icon=icon("line-chart")),
        menuSubItem("SubOnglet1_3", tabName="sub_onglet1_3", icon=icon("tachometer"))
      ),
      menuItem("Onglet2", tabName="sub_onglet2_1", icon=icon("th"),
        menuSubItem("SubOnglet2_1", tabName="sub_onglet2_1", icon=icon("bar-chart")),
        menuSubItem("SubOnglet2_2", tabName="sub_onglet2_2", icon=icon("line-chart"))
      )
    )
  ),
  dashboardBody(
    tabItems(sub_onglet1_1, sub_onglet1_2, sub_onglet1_3)
    # , sub_onglet2_1, sub_onglet2_2)
  )
)
