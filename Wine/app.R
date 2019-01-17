library(shiny)
library(shinyWidgets) 
library(tidyverse)
library(DT)

wine <- read.csv("winemag-data-130k-v2.csv", stringsAsFactors = FALSE) %>% 
  select("price","points", "country", "province", "variety", "title", "taster_name", "description")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Wind Down the Wine", 
             windowTitle = "Wine Review App"),
   sidebarLayout(
     sidebarPanel(
       chooseSliderSkin("HTML5", color = '#778899'),
       tags$head(tags$style(HTML( '.has-feedback .form-control { padding-right: 0px;}' ))),
       sliderInput("priceInput", "Select your desired price range.",
                   min = 0, max = 100, value = c(15, 30), pre="$"),
       sliderInput("ratingInput", "Select your desired rating range.",
                   min = 80, max = 100, value = c(80, 85))
       
     ),
     mainPanel(
       tabsetPanel(
         tabPanel("Price Distribution", plotOutput("price_hist")),
         tabPanel("Rating Distribution",plotOutput("rating_hist"))),
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
       ggplot(aes(price), fill) + 
       geom_histogram(fill ='lightblue', colour='grey') +
       xlab("Price ($)") +
       theme(text = element_text(size=15)) +
       theme_bw()
   )
   
  output$rating_hist <- renderPlot(
    wine_filtered() %>% 
       ggplot(aes(points)) + 
       geom_histogram(fill ='pink', colour='grey') +
       xlab("Rating (out of 100)") +
       theme(text = element_text(size=20)) +
       theme_bw()
   )
   
  output$table <- renderDataTable(
    datatable(wine_filtered(), 
              caption = "Table contains filtered results based on selected price and rating ranges. 
              \n Further filtering can be performed using the search boxes under each column.",
              filter = "top",
              colnames = c("Price","Rating", "Country", "Province", "Variety", "Title", "Name of Rater", "Description"),
              options = list(
                autoWidth = TRUE,
                scrollX = TRUE,
                columnDefs = list(list(width = '200', targets = c(8))),
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

