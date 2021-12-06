
library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)
students_data <- students_big

ui <- fluidPage(

    #creates a sidebar on the main page
   sidebarLayout(
     
     # creates a sidebar panel on the main page - brackets must wrap around its element
     sidebarPanel(
       
       #creates the first dropdown box on the sidebar panel - element
       selectInput("gender_id",
                   "Gender",
                   choices = unique(students_data$gender)),
       
       # creates dropdown box - element
       selectInput("region_id", 
                   "Region",
                   choices = unique(students_data$region)),
       
       #creates dropdown box - element
       actionButton("update", "Update plots and table")
     
    # closes the sidebar panel  
     ),
     
    # creates a main panel (if there's a sidebar panel, you must have a main panel)
     mainPanel(
       
       #this creates the idea of tabs INSIDE the main panel
       tabsetPanel(
         
         # this actually adds the first tab
         tabPanel(tags$b("Plots"),
                  
                  # this sets out how many columns there are in the main page (on the first tab)
                  fluidRow(column(width = 6,
                                  # this sets the content of the tab
                                  plotOutput("internet_plot")),
                           (column(width = 6,
                                   # this sets the content of the tab
                                   plotOutput("pollution_plot"))))),
         
         # this adds the the second tab
          tabPanel(tags$b("Data"),
                   
                   # this adds the content of the second tab (which is not split up)
                   DT::dataTableOutput("table_output")
                   
          )
       )
     )
   )
)

server <- function(input, output) {
  
  filtered_data <- eventReactive(input$update,{
    students_data %>%
      filter(gender == input$gender_id) %>%
      filter(region == input$region_id) 
  })
  
output$table_output <- DT::renderDataTable({
  filtered_data()
})

output$internet_plot <- renderPlot({
  filtered_data() %>%
    ggplot(aes(x = importance_internet_access))+
    geom_histogram()
})

output$pollution_plot <- renderPlot({
  filtered_data() %>%
    ggplot(aes(x = importance_reducing_pollution))+
    geom_histogram()
})

  
}

# Run the application 
shinyApp(ui = ui, server = server)
