#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
# Define UI for application that draws a histogram #this lasys out website essentially a floorplan 
#ui and server are must haves 
#ui mkes the button appear, the server part is what happens when the button is clicked
#fluid page is a shiny function for setting up webpages
#use a comma prior to each line when adding something to the layout
#slider input changes the range of the slider for the bins 

# Define server logic required to draw a histogram
#output$distPlot finds the thing and adresses it by putting a plot into it
#input$bins allows you to adjust the slider object


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("select_species",
                  label = h3("select box"),
                  choices = unique(starwars$species),
                  multiple= TRUE,
                  selected = 1), 
      
      
      sliderInput("height_range",
                  label = h3("pick height range"),
                  min = min(starwars$height,
                      na.rm=TRUE),
                  max = max(starwars$height,
                       na.rm = TRUE),
                        value = c(100, 150))
    ),
    mainPanel(
    dataTableOutput("sw")
    )
)
)


# server
server <- function(input, output) {
  #redner the star wars data table into the server output
  output$sw <- renderTable({
    a <-starwars[,1:10] %>%
      filter(height >= input$height_range[1],
             height <= input$height_range[2])
    
  })
  
}

server <- function(input, output) {
  
  
  output$sw <- renderDataTable({
    starwars[,1:10] %>%
      filter(height >= input$height_range[1],
             height <= input$height_range[2],
             species %in% input$select_species == TRUE)
  })
}

shinyApp(ui = ui, server = server)


