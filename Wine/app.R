library(shiny)
library(tidyverse)
wine <- read.csv("winemag-data-130k-v2.csv", stringsAsFactors = FALSE) %>% 
  select("country":"winery")

# Define UI for application that draws a histogram
ui <- fluidPage(
   sidebarLayout(
     sidebarPanel(
       sliderInput("priceInput", "Select your desired price range.",
                   min = 0, max = 100, value = c(15, 30), pre="$"),
       sliderInput("ratingInput", "Select your desired rating range.",
                   min = 80, max = 100, value = c(80, 85))
       
     ),
     mainPanel(
      # plotOutput("price_hist"),
      # dataTableOutput("table")
       tabsetPanel(type = "tabs",
                   tabPanel("Histogram_Price", plotOutput("price_hist"),dataTableOutput("table")),
                   #tabPanel("Summary", verbatimTextOutput("summary")),
                   tabPanel("Histogram_Rating", plotOutput("rating_hist"))
                   
       )
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
     wine_filtered()
     
     #this is for the table below

   )

}

# Run the application 
shinyApp(ui = ui, server = server)

