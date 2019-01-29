library(shiny)
library(shinyWidgets) 
library(tidyverse)
library(DT)
library(ggmap)

wine <- read.csv("winemag-data-130k-v2.csv", stringsAsFactors = FALSE) %>% 
  select("price","points", "title", "country", "province", "variety", "taster_name", "description")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Wind Down the Wine", 
             windowTitle = "Wine Review App"),
    #Add sidebar Panel
    sidebarLayout(
     sidebarPanel(
       chooseSliderSkin("HTML5", color = '#778899'),
       tags$head(tags$style(HTML( '.has-feedback .form-control { padding-right: 0px;}' ))),
       sliderInput("priceInput", "Select your desired price range.",
                   min = 0, max = 3300, value = c(15, 30), pre="$"),
       sliderInput("ratingInput", "Select your desired rating range.*",
                   min = 80, max = 100, value = c(80, 85)),
       hr(),
       span('*the lowest rating in this dataset is 80'),
       hr(),
       span('Source: https://www.kaggle.com/zynicide/wine-reviews/data')
     ),
     # Main Panel
     mainPanel(
       # Tabs for Price and Rating Distribution
       tabsetPanel(
         tabPanel("Price Distribution", plotOutput("price_hist")),
         tabPanel("Rating Distribution",plotOutput("rating_hist")),
         tabPanel("Map", plotOutput("map"))),
       p("Table of filtered results are shown below:", style='font-size:120%'),
       dataTableOutput("table")
       )
     )
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  observe(print(input$priceInput))
  
  # filter dataset based on user input values
  wine_filtered <-  reactive(
    wine %>% 
      filter(price > input$priceInput[1],
             price < input$priceInput[2],
             points > input$ratingInput[1],
             points < input$ratingInput[2])
    )
  # filter dataset to count country based on selected price and rating input
  wine_map <- reactive(
    wine %>%
      mutate(country = str_replace_all(country, "England", "United Kingdom")) %>%
      mutate(ISO = countrycode::countrycode(country, "country.name", "iso2c")) %>%
      filter(price > input$priceInput[1] &
               price < input$priceInput[2] &
               points > input$ratingInput[1] &
               points < input$ratingInput[2]) %>%
      group_by(ISO) %>%
      summarise(count = n()) %>%
      na.omit()
  )
  
  # Pull world map using ggmap
  world_map <- reactive(map_data("world") %>%
                          mutate(ISO = countrycode::countrycode(region, "country.name", "iso2c")))
  
  # Join count of countries to world map
  map_wine <- reactive( world_map() %>%
                          left_join(wine_map(), by = "ISO"))
  
  # Price histogram
   output$price_hist <- renderPlot(
     wine_filtered() %>% 
       ggplot(aes(price), fill) + 
       geom_histogram(fill ='lightblue', colour='grey') +
       xlab("Price ($)") +
       theme_bw() +
       theme(text = element_text(size=20))
   )
  
  # Rating histogram 
  output$rating_hist <- renderPlot(
    wine_filtered() %>% 
       ggplot(aes(points)) + 
       geom_histogram(fill ='pink', colour='grey') +
       xlab("Rating (out of 100)") +
       theme_bw() +
       theme(text = element_text(size=20))
   )
  
  # Plot world map 
  output$map <- renderPlot(
    map_wine() %>%
      ggplot(aes(long, lat, group = group, fill=count)) +
      geom_polygon()+
      xlab("longitude") +
      ylab("latitude") +
      theme_bw() +
      theme(text = element_text(size=20))
  )
  
  # filtered results table 
  output$table <- renderDataTable(
    datatable(wine_filtered(), 
              caption = "Table contains filtered results based on selected price and rating ranges. 
              \n Further filtering can be performed using the search boxes under each column.
              \n Further filter Price and Rating using the pop-up slider or input a range in the search                box (ex. 19...30).",
              filter = "top",
              colnames = c("Price","Rating", "Title", "Country", "Province", "Variety", "Name of Rater", "Description"),
              options = list(
                autoWidth = TRUE,
                scrollX = TRUE,
                columnDefs = list(list(width = '200', targets = c(8)), 
                                  list(width = '100', targets = c(1,2))),
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

