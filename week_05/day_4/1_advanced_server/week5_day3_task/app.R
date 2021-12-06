
library(shiny)
library(tidyverse)
library(shinythemes)
dogs_data <- CodeClanData::nyc_dogs

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("yeti"),
  titlePanel(tags$h1(tags$b("Dogs"
  ))),               
  sidebarLayout(
    sidebarPanel(
      radioButtons("dog_gender",
                   "Gender",
                   choices = unique(dogs_data$gender)
                  ),
      
      selectInput("dog_colour",
                  "Colour",
                  choices = unique(dogs_data$colour)
                  ),
      
      selectInput("dog_borough",
                  "borough",
                  choices = unique(dogs_data$borough)
                  ),
      selectInput("dog_breed",
                  "breed",
                  choices = unique(dogs_data$breed)
                  ),
      actionButton("update",
                   "Update Dashboard"),
    ),
    mainPanel(DT::dataTableOutput("dog_table")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  filtered_data <- eventReactive(input$update, {
    dogs_data %>%
      filter(gender == input$dog_gender) %>%
      filter(colour == input$dog_colour) %>%
      filter(borough == input$dog_borough) %>%
      filter(breed == input$dog_breed)
  })  
  output$dog_table <- DT::renderDataTable({
    filtered_data()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
