library(shiny)
library(shinythemes)
library(tidyverse)

# load sac county groundwater data and sac county polygon
gwl <- read_csv(here::here("data", "gwl", "gwl_sac_shiny.csv"))

# ------------------------------------------------------------------------
# user interface
ui <- fluidPage(

    # change default theme
    theme = shinytheme("united"),

    # application title
    titlePanel("Sacramento County Groundwater Level Data"),

    # sidebar with a dropdown input for site_code
    sidebarLayout(
        sidebarPanel(
            selectInput("site_code",
                        "Select a site code:",
                        choices = unique(gwl$SITE_CODE))
        ),

        # tabs with hydrograph and data table
        mainPanel(
            tabsetPanel(
                tabPanel("Hydrograph", plotly::plotlyOutput("gwl_plot")),
                tabPanel("Data", DT::dataTableOutput("gwl_data"))
            )
        )
    )
)

# ------------------------------------------------------------------------
# Define server logic required to draw a histogram
server <- function(input, output) {

    # --------------------------------------------------
    # create hydrograph
    output$gwl_plot <- plotly::renderPlotly({

        # draw the ggplot based on the "site_code" user input
        p <- filter(gwl, SITE_CODE == input$site_code) %>%
            ggplot(aes(MSMT_DATE, WSE)) +
            geom_line(alpha = 0.5) +
            geom_smooth(method = "lm", se = FALSE) +
            labs(title = input$site_code,
                 x = "", y = "Groundwater level (ft AMSL)")

        # render the plotly object
        plotly::ggplotly(p)
    })


    # --------------------------------------------------
    # create data table
    output$gwl_data <- DT::renderDataTable({

        # draw the plot based on the "site_code" user input
        DT::datatable(
            filter(gwl, SITE_CODE == input$site_code),
            extensions = 'Buttons',
            options =
                list(dom = 'Bfrtip',
                     buttons = c('copy', 'csv', 'excel', 'pdf', 'print'))
        )
    })
}

# ------------------------------------------------------------------------
# Run the application
shinyApp(ui = ui, server = server)
