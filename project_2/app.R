source("helper_function.R")

# Use the Shiny Dashboard layout instead of fluidui
ui <- dashboardPage(
  dashboardHeader(title="UMD Services Heatmap", titleWidth= 300),
  dashboardSidebar(
    # Create a sidebar with options
    # Put data first and details later for those interested
    sidebarMenu(
      # Icon names come from font awesome
      menuItem("Heatmap", tabName="heatmap", icon=icon("chart-bar")),
      menuItem("Background", tabName="background", icon=icon("star")),
      menuItem("Technical Details", tabName="technical", icon=icon("database")),
      menuItem("Data", tabName="datatable", icon=icon("table"))
    )
  ),

  dashboardBody(
    tabItems(
      tabItem(tabName="heatmap",
        img(src = "images/image.png"),
        h2("UMD Service Heatmap"),
        p("Scroll down to toggle plot options. Questions? Contact Alvin at alvin {at} unc.edu."),
        fluidRow(
          column(width=12,
            box(title="UMD Services Heatmap", status="primary",
              solidHeader=TRUE, width=12,
              plotOutput(outputId = "popPlot"),
              h3("What am I looking at?"),
              p("This heat map shows how often this service was provided
                during a given month and year. Months are indicated on the
                y-axis (1=January, 2=February, ... , 12=December)"),
              p("The darker the color, the more times that
                service was offered during that month (relative to other
                months)."),
              h3("What visual trends can I see?"),
              p("If you see the color getting darker from left to right
                (horizontally), that means that
                UMD has, in general, provided more of that service over the
                years."),
              p("If you see the color change along from top to bottom
                (vertically), that might indicate seasonal trends (i.e.
                more services in the winter months.)"),
              h3("What if the plot is mostly yellow?"),
              p("It's possible that the data capture for this service is poor
                or that this service was not offered during whole
                time period.")
            )
          )
        ),
        fluidRow(
          box(title="Plot Topic", status="primary",
            solidHeader=TRUE, width=4,
            radioButtons(inputId = "group_name",
                         label = "UMD Food Pantry/Clothing Closet Service",
                         choices = c("Food" = "food_total",
                                     "Clothes" = "cloth_total",
                                     "School Kits" = "school_total",
                                     "Hygiene Kits" = "hygiene_total",
                                     "Diapers" = "diaper_total"),
                         selected = "food_total",
                         inline = FALSE),
            p("Select the service that you would like to plot. These services
            were provided by the Urban Ministries of Durham Clothing
            Closet/Food Pantry. Additional Information can be found in the
            backgroun section.")
          ),
          box(title="Plot Dates", status="primary",
            solidHeader=TRUE, width=4,
            dateRangeInput(inputId = "dateRange",
                           label = "Date range: yyyy-mm-dd",
                           start = "2010-01-01", end = "2017-12-31",
                           min = "1991-01-01", max = "2018-12-31",
                           format = "yyyy-mm-dd",
                           startview = "year"),
            p("Enter the time period that you would like to plot. Whole months
            are encournaged but not required."),
            p("Allowable range: 1991-01-01 to 2018-12-31"),
            p("Recommended range: 2010-01-01 to 2017-12-31")
          ),
          box(title="Outlier Control", status="primary",
            solidHeader=TRUE, width=4,
            sliderInput(inputId = "outlier_coef", label = "Beta",
                        min = 0, max = 5, value = 3, step = 0.25),
            p("Select how to handle extreme values. The larger the beta
            (5=maximum), the more data you are cutting out.
            The smaller the beta (0=minumum), the more data
            you are including. Extreme values may be due to typing errors
            and could result in incorrect trends. The recommend value is 3.")
          )
        )
      ),
      tabItem(tabName="background",
        h2("Background"),
        p (
          "The Urban Ministries of Durham (UMD) fights poverty and homeless
          by offering food, shelter, and a future to neighbors in need.
          During the 2017-2018 fiscal year, UMD provided 54,378 nights of
          shelter to homeless neighbors (792 unique individuals),
          served 248,028 meals through the community cafe, and provided
          clothing and groceries to over 500 households per month. They
          ended homelessness for 243 individuals."
        ),
        p(
          "The three primary arms of UMD are the community shelter,
          community cafe, and food pantry/clothing closet. UMD is
          also engaged in community outreach and enrichment. About
          80% of UMD's contributions (excluding in-kind donations)
          come from gifts and grants from foundations, the government,
          and communities of faith."
        ),
        h2("Objective"),
        p(
          "Our objective is to create an interactive tool that
          will help UMD access some of their data on food
          pantry/clothing closet services.
          The tool will allow for user-driven analytic choices
          (e.g. how to handle outliers) and present data in a clean,
          attractive format appropriate for reports."
        )
      ),
      tabItem(tabName="technical",
        h2("Data Source"),
        p(
          "The dataset was provided by UMD and can be found
          under the data repository on GitHub (https://github.com/datasci611/
          bios611-projects-fall-2019-alvinthomas/tree/master/project_2). 
          The original datasets are TSV files."
        ),
        h2("Outliers"),
        p(
          "The Outlier selection beta is based on the boxplotstat R pacakge.
          Data outside the range interquartile range*beta will be considered outliers."
        )
      ),
      tabItem(tabName="datatable",
        h2("Data"),
        fluidRow(
          box(title="Summary Table", status = "primary",
            solidHeader = TRUE,
            dataTableOutput(outputId = "popTable"), width=12

          )
        )
      )
    )
  )
)

server = function(input, output) {
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

  output$popTable <- DT::renderDataTable({
    date_range = paste(as.character(input$dateRange), collapse = " to ")
    dat <- filter_date(proj2, date_range = date_range)
    dat <- address_outliers(data = dat, ceof_out = input$outlier_coef)
    dat_clients <- sum_by_clients(dat)
    dat_client_year <- sum_by_client_year(dat)
    dat_date <- sum_by_date(dat)
    DT::datatable(dat_date,
      options = list(lengthMenu = c(8, 20, 50), pageLength = 8))
  })
}

shinyApp(ui, server)
