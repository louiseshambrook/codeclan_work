library(shiny)
library(shinythemes) 
library(tidyverse)

olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")
all_teams <- unique(olympics_overall_medals$team)

ui <- fluidPage(
  
  titlePanel(("Olympic Medals")),
  
  tabsetPanel( 
              
    tabPanel("Plot",
      plotOutput("medal_plot")
    ),
    
    tabPanel("Which season?",
             radioButtons("season_input",
                          "Summer or Winter Olympics?",
                          choices = c("Summer", "Winter")
             )
    ),
    
    tabPanel("Which team?",
             selectInput("team_input",
                         "Which team?",
                         choices = all_teams)
    ),
    tabPanel("Website",
             tags$a("The Olympics Website",
                    href = "https://www.Olympic.org")
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
