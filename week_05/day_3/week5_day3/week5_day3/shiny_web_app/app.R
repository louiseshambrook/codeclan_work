
library(shiny)
library(tidyverse)
library(shiny)

olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage(
  
      titlePanel("Title"),
      
      
      sidebarLayout(
        sidebarPanel(
          
          radioButtons("season_input", 
                       "Which season?",
                       choices = c("Summer", "Winter")
          ),
          
          selectInput("team_input", 
                         "Which team?", 
                         choices = c("United States", 
                                     "Soviet Union", 
                                     "Germany", 
                                     "Italy", 
                                     "Great Britain")
          )
          
        ),
        
        mainPanel(
          plotOutput("medal_plot")
        )
        
      )
)




server <- function(input, output) {
  
  
  output$medal_plot <- renderPlot({ 
    olympics_overall_medals %>%
      filter(team == input$team_input) %>%
      filter(season == input$season_input) %>%
      ggplot() +
      aes(x = medal, y = count, fill = medal) +
      geom_col()
    })
  
  
  
}


# Run the application 
shinyApp(ui = ui, server = server)
