source("helper_function.R")


# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  # App title ----
  titlePanel("Heatmap"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Integer for the number of bins ----
      radioButtons(inputId = "group_name", 
                   label = "Group Variable",
                   choices = c("food_total", 
                               "cloth_total",
                               "school_total",
                               "hygiene_total",
                               "diaper_total"), 
                   selected = "food_total", 
                   inline = FALSE),
      dateRangeInput('dateRange',
                     label = 'Date range input: yyyy-mm-dd',
                     start = "2010-01-01", end = "2017-12-31",
                     min = "1991-01-01", max = "2018-12-31"
      ),
      p(textOutput(outputId = "dateStatement"))
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Violin Plotn----
      plotOutput(outputId = "popPlot")
    )
  )
)

# Define server logic required to draw a violin plot ----
server <- function(input, output) {
  # renderPlot creates histogram and links to ui
  output$popPlot <- renderPlot({
    group_name = input$group_name
    make_graph(group_name)
  })
  output$dateRangeText  <- renderText({
    paste("input$dateRange is", 
          paste(as.character(input$dateRange), collapse = " to ")
    )
  })
  output$dateStatement <- renderText({
    paste("The allowable date range is 1991-01-01 to 2018-12-31")
  })
}

shinyApp(ui = ui, server = server)

