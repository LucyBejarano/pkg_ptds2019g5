shinyServer(function(input, output) {
    output$tmp <- renderPlotly({
        pollutant_data %>%
            mutate(day = as.Date(Date_time, format = "%Y-%m-%d")) %>%
            filter(pollutant == input$poll,
                   day >= input$date[1] &
                       day <= input$date[2]) %>%
            group_by(day) %>%
            summarise(avg = mean(value)) %>%
            na.omit() %>%
            plot_ly(x = ~ day,
                    y =  ~ avg,
                    mode = 'lines')
    })
    # output$calendar <- renderPlot({
    #     pollutant_data_cal <- pollutant_data %>%
    #         mutate(day = as.Date(Date_time, format = "%Y-%m-%d")) %>%
    #         group_by(day, pollutant) %>%
    #         summarise(avg = mean(value)) %>%
    #         spread(key = pollutant, value = avg) %>%
    #         rename(date = day)
    #
    #     calendarPlot(
    #         pollutant_data_cal,
    #         pollutant = input$poll2,
    #         w.shift = 2,
    #         breaks =
    #             if (input$poll2 == "CO") {
    #                 c(0, 0.2, 0.3, 1000)
    #             }
    #         else if (input$poll2 == "NO2") {
    #             c(0, 15, 25, 1000)
    #         }
    #         else if (input$poll2 == "O3") {
    #             c(0, 50, 100, 1000)
    #         }
    #         else if (input$poll2 == "PM10") {
    #             c(0, 15, 30, 1000)
    #         }
    #         else if (input$poll2 == "SO2") {
    #             c(0, 0.5, 1.5, 1000)
    #         }
    #         else if (input$poll2 == "PM2.5") {
    #             c(0, 7, 15, 1000)
    #         }
    #         ,
    #         labels = c("low", "regular", "high"),
    #         cols = c("lightskyblue", "lightskyblue3",  "grey60")
    #     )
    # })
})


