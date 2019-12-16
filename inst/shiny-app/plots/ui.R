shiny::shinyUI(
    shiny::fluidPage(
        theme = shinythemes::shinytheme("paper"),
        shiny::titlePanel(
            shiny::h1(shiny::br(),
                      "Air pollution in Switzerland",
                      align = "center",
                      style = "background-color:dodgerblue;padding-top:15px;font-size:38px;color:white;margin-left: -15px;
                        margin-right: -15px;", shiny::br(), shiny::br())
        ),
        shiny::navlistPanel(
            "Home",
            shiny::tabPanel("Welcome",
                            shiny::h3("Welcome", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("Welcome to this Shiny App!"),
                            shiny::p("This app has been created for the course \"Programming Tools
                         for Data Science\" given at the University of Lausanne."),
                            shiny::p("The aime of this tools is to provide users with a visualization
                         tools regarding air pollutation data of Switzerland. We propose
                         different tools to investigate the levels of concentration for
                         different types of pollutants.")
            ),

            "Map",
            shiny::tabPanel("Dynamic map",
                            shiny::h3("Evolution over time", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::selectInput("Pollutant2",
                                               label = strong("Pollutant"),
                                               choices= c(NO2 = "Map_NO2", O3 = "Map_O3",
                                                          PM10 = "Map_PM10", SO2 = "Map_SO2",
                                                          CO = "Map_CO", PM2.5 = "Map_PM2.5")),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_NO2'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_NO2", width = "700px", height = "500px")
                                )
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_O3'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_O3", width = "700px", height = "500px")
                                )
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_PM10'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_PM10", width = "700px", height = "500px"),
                                )
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_SO2'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_SO2", width = "700px", height = "500px"),
                                )
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_CO'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_CO", width = "700px", height = "500px")
                                )
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant2 == 'Map_PM2.5'",
                                shiny::div(align="center",
                                           plotly::plotlyOutput("Map_PM2.5", width = "700px", height = "500px")
                                )
                            ),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("The above map has been built using hourly pollution measures.
                     It is a usefull tool to display how the average monthly concentration of each pollutant changes over time and depending on the location.
                     Each location presents different colors and differ bubble sizes. Both the color and the size depend on the average monthly concentration of the pollutant.
                     Moreover, if the user places the mouse over one of the displayed points, a pop up box with information regarding longitude, latitude, time, average monthly pollution and location's name will appear.")
            ),

            "Explore plots",
            shiny::tabPanel(
                "Timeplot per pollutant",
                shiny::h3("Timeplot for Switzerland", align = "center"),
                shiny::br(),
                shiny::br(),
                shiny::radioButtons(
                    inputId = "poll",
                    label = strong("Pollutant"),
                    choices = pollutant,
                    inline = TRUE,
                    selected = "NO2"
                ),
                shiny::dateRangeInput(
                    inputId = "date",
                    label = strong("Date range"),
                    start = "2018-05-01",
                    end = "2019-10-29",
                    min = "2018-05-01",
                    max = "2019-10-29"
                ),
                plotly::plotlyOutput("ts_poll"),
                shiny::br(),
                shiny::br(),
                shiny::p("The above timeplot has been built using hourly pollution measures.
                     These plots enable to visualize the evolution of the quantity of the selected pollutant in the air over time. The limit level authorised in Switzerland to pevent a critical situation that become dangerous to health is defined by the red line.")
            ),
            shiny::tabPanel("Timeplot per location",
                            shiny::h3("Timeplot per location", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::selectInput(
                                inputId = "loc",
                                label = strong("Location"),
                                choices = loc
                            ),
                            shiny::checkboxGroupInput(
                                inputId = "poll2",
                                label = strong("Pollutant"),
                                choices = pollutant,
                                inline = TRUE
                            ),
                            shiny::dateRangeInput(
                                inputId = "date2",
                                label = strong("Date range"),
                                start = "2018-05-01",
                                end = "2019-10-29",
                                min = "2018-05-01",
                                max = "2019-10-29"
                            ),
                            plotly::plotlyOutput("ts_loc"),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("The above timeplot has also been built using hourly pollution measures.
                     It is possible to compare the evolution over time of the concentration of differents pollutants by location.")
            ),
            shiny::tabPanel("Barplot per pollutant",
                            shiny::h3("Pollutants' levels per location", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::selectInput("Pollutant",
                                               label = strong("Pollutant"),
                                               choices= c(NO2 = "Barplot_NO2", O3 = "Barplot_o3", PM2.5 = "Barplot_PM2.5",
                                                          PM10 = "Barplot_PM10", SO2 = "Barplot_SO2", CO = "Barplot_CO")),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_NO2'",
                                plotOutput("Barplot_NO2")
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_o3'",
                                plotOutput("Barplot_o3")
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_PM2.5'",
                                plotOutput("Barplot_PM2.5")
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_PM10'",
                                plotOutput("Barplot_PM10")
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_SO2'",
                                plotOutput("Barplot_SO2")
                            ),
                            shiny::conditionalPanel(
                                condition = "input.Pollutant == 'Barplot_CO'",
                                plotOutput("Barplot_CO")
                            ),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("The bar plot above represents the average concentration per hour of the selected pollutant in different Swiss cities.
                       In order to have a reference element, the red line corresponds to the maximum limit imposed by the Swiss Confederation (See section *About the data* for more information).")
            ),

            "Calendars",
            shiny::tabPanel(
                "Pollutant concentration and weather calendar",
                shiny::h3("Concentration of pollutant per day", align = "center"),
                shiny::br(),
                shiny::br(),
                shiny::radioButtons(
                    inputId = "poll3",
                    label = strong("Pollutant"),
                    choices = pollutant,
                    inline = TRUE,
                    selected = "NO2"
                ),
                shiny::plotOutput("calendar"),
                shiny::br(),
                shiny::br(),
                p("This calendar allows to see the average concentration difference of the selected particle for each day.
                  The days in grey indicate the dates on which the maximum limit for healthy living by the Swiss Confederation has been exceeded."),
                shiny::br(),
                shiny::br(),
                shiny::h3("Weather information per day", align = "center"),
                shiny::br(),
                shiny::br(),
                shiny::plotOutput("calendar_temperature"),
                shiny::plotOutput("calendar_precipitation"),
                shiny::br(),
                shiny::br(),
                shiny::p("The upper calendar displays the average amount of rain per day in mm in Switzerland.
                       By referring to the coloured bar on the left side, you can get an idea of the rainfall over the last year. The darker the box is, the more it rained.
                       The bottom calendar shows the average daily temperature in Celcius degree in Switzerland.")
            ),

            "About the data",
            shiny::tabPanel("Pollutants",
                            shiny::h3("Information about the pollutants", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("The visualizations presented contain real air pollution data
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
                            shiny:: p("It can affect as well human health, having an impact on the lungs,
          as the environment with acid rains. Being one of the winter smog
          compounds, it is important to be able to measure it. It is done by
          UV-fluorescence. Concentration is presented in μg m−3."),
                            shiny::strong("CO (carbon dioxide)"),
                            shiny::p("This pollutant is a good indicator for anthropogenic pollution,
          the contamination of the inner layers of nature due to the human
          activities that people perform day by day. The concentration is
          measured in mg m−3. The CO daily limit value 8 mg m−3."),
                            shiny::strong("PM 2.5 and PM10 (Particulate Matter 2.5 and 10)"),
                            shiny::p("The term PM define suspended solids. PM 2.5 refers to particles
          with a diameter until 2.5 micrometers and PM 10 with a diameter of less than 10
          micrometers. The larger they are, the faster they are eliminated from the atmosphere.
          PM10 are normally released from the atmosphere within a few hours of their emission.
          The concentration is presented in μg m−3")
            ),
            shiny::tabPanel("Table Swiss Limits",
                            shiny::h3("Recommended limits", align = "center"),
                            shiny::br(),
                            shiny::br(),
                            shiny::p("The below table presents the Swiss regulatory limits per pollutant."),
                            shiny::br(),
                            tags$img(src = "Table_swiss_limits.JPG", width="400", height="300", style="display: block; margin-left: auto; margin-right: auto;")
            ),
            widths = c(2, 10)
        )
    )
)







