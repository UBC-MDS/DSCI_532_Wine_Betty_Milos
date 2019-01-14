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
                   min = 80, max = 100, value = c(15, 30))
       
     ),
     mainPanel(
       plotOutput("price_hist"),
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
   
   output$table <- renderDataTable(
     wine_filtered()
   )

}

# Run the application 
shinyApp(ui = ui, server = server)

