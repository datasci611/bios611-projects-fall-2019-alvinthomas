source("helper_function.R")

ui <- fluidPage(
  # App title ----
  titlePanel("Heatmap"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Integer for the number of bins ----
      h3("Type of Service"),
      radioButtons(inputId = "group_name",
                   label = "Service Variable",
                   choices = c("food_total",
                               "cloth_total",
                               "school_total",
                               "hygiene_total",
                               "diaper_total"),
                   selected = "food_total",
                   inline = FALSE),
      br(),
      h3("Plot Dates"),
      dateRangeInput(inputId = "dateRange",
                     label = "Date range: yyyy-mm-dd",
                     start = "2010-01-01", end = "2017-12-31",
                     min = "1991-01-01", max = "2018-12-31",
                     format = "yyyy-mm-dd",
                     startview = "year"),
      p("Allowable range: 1991-01-01 to 2018-12-31"),
      br(),
      h3("Outlier Control"),
      sliderInput(inputId = "outlier_coef", label = "Beta", 
                  min = 0, max = 5, value = 3, step = 0.25),
      p("Select a beta value.
        Data outside the range IQR*beta will be considered outliers.")
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Violin Plotn----
      plotOutput(outputId = "popPlot")
    )
  )
)

server <- function(input, output) {
  output$popPlot <- renderPlot({
    date_range = paste(as.character(input$dateRange), collapse = " to ")
    dat <- filter_date(proj2, date_range = date_range)
    dat <- address_outliers(data = dat, ceof_out = input$outlier_coef)
    dat_clients <- sum_by_clients(dat)
    dat_client_year <- sum_by_client_year(dat)
    dat_date <- sum_by_date(dat)
    group_name = input$group_name
    make_graph(data = dat_date, var_name = group_name)
  })
}

shinyApp(ui = ui, server = server)

