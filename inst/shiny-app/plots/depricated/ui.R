shiny::shinyUI(
    shiny::fluidPage(
        theme = shinytheme("paper"),
        shiny::titlePanel(
            shiny::h1(shiny::br(),
               "Air pollution in Switzerland",
               align = "center",
               style = "background-color:dodgerblue;padding-top:5px;font-size:38px;color:white;margin-left: -15px;
                        margin-right: -15px;"
               ,shiny::br(),shiny::br())
        ),

        shiny::navlistPanel(
            "Timeplot",
            shiny::tabPanel(
                "Timeplot per pollutant",
                shiny::radioButtons(
                    inputId = "poll",
                    label = strong("Pollutant"),
                    choices = pollutant,
                    inline = TRUE
                ),
                shiny::dateRangeInput(
                    inputId = "date",
                    label = strong("Date range"),
                    start = "2018-05-01",
                    end = "2019-10-29",
                    min = "2018-05-01",
                    max = "2019-10-29"
                ),
                plotly::plotlyOutput("tmp")
            ),
            shiny::tabPanel(
                "Timeplot"),
            "Map",
            shiny::tabPanel("Interactive map"),
            shiny::tabPanel("Pollution concentration over time"),
            "Pollutants calendar",
            shiny::tabPanel(
                "Pollutant concentration calendar",
                shiny::radioButtons(
                    inputId = "poll2",
                    label = strong("Pollutant"),
                    choices = pollutant,
                    inline = TRUE
                ),
                shiny::plotOutput("calendar")
            ),
            "About the data",
            shiny::tabPanel("Pollutants",
                            shiny::br(),
                            shiny::br(),
                            p("The visualizations presented contain real air pollution data
                                     extracted from the webpage of The Federal Office for the Environment of Switzerland.
                                     To visit the source and even download the data you can",
                              tags$a(href="https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html", "click here.")),
                            shiny::strong("O3 (Ozone)"),
                            shiny::p("Its concentration depends on solar radiation,
                   emissions, amount of precursors, as well as temperature.
                   The measurement of ozone is based on a UV absorption method,
                   comparing the transmission of light with the presence of ozone
                   in an air sample and when it is removed. It is presented in μg m−3."),
                            shiny::strong("NO2 (nitrogen oxide)"),
                            shiny::p("It is a toxic reddish-brown gas with a characteristic bitter and
          pungent smell. It is a major pollutant of the Earth's atmosphere
          produced by internal combustion engines and thermal power plants.
          Concentration is presented in μg m−3."),
                            shiny::strong("SO2 (sulfur dioxide)"),
                            shiny::p("It can affect as well human health, having an impact on the lungs,
          as the environment with acid rains. Being one of the winter smog
          compounds, it is important to be able to measure it. It is done by
          UV-fluorescence. Concentration is presented in μg m−3."),
                            shiny::strong("CO (carbon dioxide)"),
                            shiny::p("This pollutant is a good indicator for anthropogenic pollution,
          the contamination of the inner layers of nature due to the human
          activities that people perform day by day. The concentration is
          measured in mg m−3. The CO daily limit value 8 mg m−3."),
                            shiny::strong("PM10 (Particulate Matter 10)"),
                            shiny::p("The term PM define suspended solids. PM 10 refers to particles with
          a diameter of less than 10 micrometers. The larger they are, the
          faster they are eliminated from the atmosphere. PM10 are normally
          released from the atmosphere within a few hours of their emission.
          The concentration is presented in μg m−3")),
            "Recomendations",
            shiny::tabPanel("How can I help?"),
            "-----"
        )
    )
)






