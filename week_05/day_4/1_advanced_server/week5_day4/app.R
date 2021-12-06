library(shiny)
library(tidyverse)
library(CodeClanData)



ui <- fluidPage(
  
  fluidRow(
    
    column(2,
           radioButtons("handed_input",
                        "Handedness",
                        choices = unique(students_big$handed),
                        inline = TRUE)
    ), 
    
    column(3,
           selectInput("region_input", 
                       "Which Region?", 
                       choices = unique(students_big$region))
    ), 
    
    column(3,
           selectInput("gender_input", 
                       "Which Gender?",
                       choices = unique(students_big$gender))
    ),
    # ADD colour input for graphs
    column(2,
           radioButtons("colour_input",
                        "Select a Colour",
                        choices = c("steel blue", "red"))
    ), 
    # ADD AN ACTION BUTTON IN HERE
    column(2,
           br(),
           actionButton("update",
                        "Update dashboard")
    ),
  ),
  
  
  
  # ADD IN A FLUID ROW WITH OUR NEW PLOTS HERE
  fluidRow(
    column(6,
           plotOutput("travel_barplot")
    ),
    column(6,
           plotOutput("spoken_barplot")
    )
  ),
  DT::dataTableOutput("table_output")
)

server <- function(input, output) {
  
  filtered_data <- eventReactive(input$update, {
    students_big %>%
      filter(handed == input$handed_input) %>%
      filter(region == input$region_input) %>%
      filter(gender == input$gender_input)
  })  
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  # ADD IN OUR PLOTS HERE TO SERVER
  output$travel_barplot <- renderPlot({
    ggplot(filtered_data()) + 
      geom_bar(aes(x = travel_to_school), fill = input$colour_input)
  })
  
  output$spoken_barplot <- renderPlot({
    filtered_data() %>% 
      ggplot() + 
      geom_bar(aes(x = languages_spoken), fill = input$colour_input)
  })
  
}

shinyApp(ui = ui, server = server)