library(shiny)
library(tidyverse)
library(leaflet)

whisky_df <- CodeClanData::whisky %>%
  rename(long = Latitude,
         lat = Longitude)