ui <- fluidPage(
  selectInput("region", "Region:",
              choices = unique(whisky_df$Region)),
  leafletOutput("whiskey_map")
  
)