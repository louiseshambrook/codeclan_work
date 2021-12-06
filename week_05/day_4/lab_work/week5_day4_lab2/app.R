
library(shiny)
library(tidyverse)
library(shinythemes)

students_data <- CodeClanData::students_big

ui <- fluidPage(
  fluidRow(
    column(12,
           radioButtons("age_input",
                        "Age",
                        choices = unique(students_big$ageyears),
                        inline = TRUE)
    ),
    actionButton("update", "Update plots")
  ),
  fluidRow(
      column(width = 6,
      plotOutput("height_barplot")
            ),
      column(width = 6,
           plotOutput("arm_span_barplot")
          ),
  )
  # DT::dataTableOutput("table_output")
)

server <- function(input, output) {
  filtered_data <- eventReactive(input$update, {
    students_big %>%
      filter(ageyears == input$age_input)
  })
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  output$height_barplot <- renderPlot({
    filtered_data() %>%
      ggplot() +
      geom_histogram(aes(x = height), binwidth = 5)
  })
  
  output$arm_span_barplot <- renderPlot({
    filtered_data() %>%
      ggplot() +
      geom_histogram(aes(x = arm_span), binwidth = 5)
  })
}

shinyApp(ui = ui, server = server)
