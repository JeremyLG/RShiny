library(shinydashboard)
library(shinyjs)
library(dplyr)
library(shiny)
library(ggplot2)
library(scales)
library(data.table)
library(plotly)
library(htmlwidgets)

options(shiny.maxRequestSize=30*1024^2)
source("sparklyr_config.R", chdir=T)
spark_disconnect_all()
sc=spark_context()

vars=c("requests", "latency")
programs=c("tricky", "topkek", "issou")

read_data <- function(){
  path <- "data/spark_data.json"
  df <- sc %>%
  spark_read_json("name", path) %>%
  collect()
  return(df)
}
streaming_data = read_data()
streaming_data$timestamps <- as.POSIXct(gsub("T", " ", substr(streaming_data$timestamp, 0, 19))) + 2*60*60
