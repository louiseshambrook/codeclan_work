
library(shiny)
library(tidyverse)
library(shinythemes)
olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage(
  theme = shinytheme("cyborg"),
  
  titlePanel(tags$h1(tags$b("Five Country Medal Comparison"
  ))),
  tabsetPanel(
    tabPanel(tags$b("Main Page"),
             sidebarLayout(
               sidebarPanel(
                 radioButtons("season_id", 
                              "Which season?",
                              choices = c("Summer",
                                          "Winter")
                 )
               ),
               mainPanel(
                 plotOutput("medal_plot")
               )
          )
      ),
    tabPanel(tags$b("Website"),
             br(),
             br(),
             br(),
             tags$b(tags$a("Here is a website",
                    href = "https://www.olympics.org/"
                    ))
             ),
    tabPanel(tags$b("Which Medal"),
             radioButtons("medal_type", 
                          "Which medal?",
                          choices = c("Gold",
                                      "Silver",
                                       "Bronze")
                          )
             
            )
  )
)


server <- function(input, output) {

  output$medal_plot <- renderPlot ({
    olympics_overall_medals %>%
    filter(team %in% c("United States",
                       "Soviet Union",
                       "Germany",
                       "Italy",
                       "Great Britain")) %>%
    filter(medal == input$medal_type) %>%
    filter(season == input$season_id) %>%
    ggplot() +
    aes(x = team, y = count, fill = medal) +
    geom_col() +
    scale_fill_manual(values = c("Gold" = "Gold",
                                  "Silver" = "#c0c0c0",
                                  "Bronze" = "#b08d57"))
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

