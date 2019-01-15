library(shiny)
library(shinyWidgets) 
library(tidyverse)
library(DT)

wine <- read.csv("winemag-data-130k-v2.csv", stringsAsFactors = FALSE) %>% 
  select("price","points", "country", "province", "variety", "title", "taster_name", "description")

# Define UI for application that draws a histogram
ui <- fluidPage(
   sidebarLayout(
     sidebarPanel(
       chooseSliderSkin("HTML5", color = '#778899'),
       sliderInput("priceInput", "Select your desired price range.",
                   min = 0, max = 100, value = c(15, 30), pre="$"),
       sliderInput("ratingInput", "Select your desired rating range.",
                   min = 80, max = 100, value = c(80, 85))
       
     ),
     mainPanel(
       tabsetPanel(
         tabPanel("Price Distribution", plotOutput("price_hist")),
         tabPanel("Rating Distribution",plotOutput("rating_hist")),
         tabPanel("Map")),
       dataTableOutput("table")
                   
       )
     )
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  observe(print(input$priceInput))
  
  wine_filtered <-  reactive(
    wine %>% 
      filter(price > input$priceInput[1],
             price < input$priceInput[2],
             points > input$ratingInput[1],
             points < input$ratingInput[2])
    )
  
   output$price_hist <- renderPlot(
     wine_filtered() %>% 
       ggplot(aes(price)) + 
       geom_histogram()
   )
   
  output$rating_hist <- renderPlot(
    wine_filtered() %>% 
       ggplot(aes(points)) + 
       geom_histogram()
   )
   
  output$table <- renderDataTable(
    datatable(wine_filtered(), 
              filter = "top",
              colnames = c("Price","Rating", "Country", "Province", "Variety", "Title", "Name of Rater", "Description"),
              options = list(
                autoWidth = TRUE,
                scrollX = TRUE,
                columnDefs = list(list(width = '400', targets = c(8))),
                initComplete = JS(
                  "function(settings, json) {",
                  "$(this.api().table().header()).css({'background-color': '#778899', 'color': '#fff'});",
                  "}"
                )
              )
    )
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)

