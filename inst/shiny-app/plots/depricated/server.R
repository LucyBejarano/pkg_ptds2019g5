shiny::shinyServer(function(input, output) {
    output$tmp <- plotly::renderPlotly({
        pollutant_data %>%
            dplyr::mutate(day = as.Date(Date_time, format = "%Y-%m-%d")) %>%
            dplyr::filter(pollutant == input$poll,
                   day >= input$date[1] &
                       day <= input$date[2]) %>%
            dplyr::group_by(day) %>%
            dplyr::summarise(avg = mean(value)) %>%
            na.omit() %>%
            plotly::plot_ly(x = ~ day,
                    y =  ~ avg,
                    mode = 'lines')
    })
    output$calendar <- shiny::renderPlot({
        pollutant_data_cal <- pollutant_data %>%
            dplyr::mutate(day = as.Date(Date_time, format = "%Y-%m-%d")) %>%
            dplyr::group_by(day, pollutant) %>%
            dplyr::summarise(avg = mean(value)) %>%
            tidyr::spread(key = pollutant, value = avg) %>%
            dplyr::rename(date = day)

        openair::calendarPlot(
            pollutant_data_cal,
            pollutant = input$poll2,
            w.shift = 2,
            breaks =
                if (input$poll2 == "CO") {
                    c(0, 0.2, 0.3, 1000)
                }
            else if (input$poll2 == "NO2") {
                c(0, 15, 25, 1000)
            }
            else if (input$poll2 == "O3") {
                c(0, 50, 100, 1000)
            }
            else if (input$poll2 == "PM10") {
                c(0, 15, 30, 1000)
            }
            else if (input$poll2 == "SO2") {
                c(0, 0.5, 1.5, 1000)
            }
            else if (input$poll2 == "PM2.5") {
                c(0, 7, 15, 1000)
            }
            ,
            labels = c("low", "regular", "high"),
            cols = c("lightskyblue", "lightskyblue3",  "grey60")
        )
    })
})


