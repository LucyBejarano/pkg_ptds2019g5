library(shiny)

ui <- fluidPage(

    titlePanel(h1("Air pollution in Switzerland",align="center",
                  style="padding-top:15px;font-size:28px;color:#3474A7")),

    #Structure tabs
    mainPanel(
        tabsetPanel(
            tabPanel("Interactive Map", plotOutput("map")),
            tabPanel("Timeplot",
                     radioButtons(inputId = "poll", label = strong("Pollutant"),
                                  choices = pollutant),
                     dateRangeInput(inputId ="date", label = strong("Date range"),
                                    start = "2018-05-01", end = "2019-10-29",
                                    min = "2018-05-01", max = "2019-10-29"),
                     plotlyOutput("tmp")
            ),
            tabPanel("Recomendations", plotOutput("recomend"))
        )
    )
)
