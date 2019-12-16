library(magrittr)
shiny::shinyServer(function(input, output) {

    # Add latitude and longitude to be able to draw a map
    cities <- tidyr::tibble(
        name = loc,
        latitude = c(46.949589, 46.524881, 46.010704, 47.376215, 47.536560, 47.401998, 47.309362, 46.219574, 46.147617,46.819803, 47.479756, 47.206372, 47.025573, 47.067360, 46.804398, 46.547502 ),
        longitude = c(7.440509,  6.638024, 8.958149, 8.533894, 7.570077, 8.611938, 7.818373, 7.329855, 8.854938, 6.940371, 8.907089, 8.191635, 6.954111, 8.465508, 9.836831, 7.982133)
    )

    # Download swiss map
    world_map <- rworldmap::getMap(resolution = "high")
    switzerland <- world_map@polygons[[40]]@Polygons[[1]]@coords
    switzerland <- tidyr::as_tibble(switzerland)

    # Add pollutants limits
    pollutants_limits <- data.frame(c("O3", "NO2", "SO2", "CO", "PM10", "PM2.5"),
                                    c(120, 30, 30, 8, 20, 10))
    colnames(pollutants_limits) <- c("pollutant", "limit")

    ## Maps
    pollutant_month_avg <- pollutant_data %>%
        dplyr::mutate(time = format(Date_time, format = "%Y-%m")) %>%
        dplyr::group_by(time, pollutant, name) %>%
        dplyr::summarise(pollutant_month_avg = mean(value, na.rm = TRUE)) %>%
        dplyr::left_join(cities, by="name")%>%
        tidyr::drop_na()

    output$Map_NO2 <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "NO2") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average NO2 concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=15, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    output$Map_O3 <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "O3") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average O3 concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=60, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    output$Map_PM10 <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "PM10") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average PM10 concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=10, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    output$Map_PM2.5 <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "PM2.5") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average PM2.5 concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=5, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    output$Map_SO2 <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "SO2") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average SO2 concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=15, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    output$Map_CO <- plotly::renderPlotly({
        plotly::ggplotly(
            pollutant_month_avg %>%
                dplyr::filter(pollutant == "CO") %>%
                ggplot2::ggplot() +
                ggplot2::geom_polygon(data = switzerland, ggplot2::aes(x = V1, y = V2), fill = "white", colour = "black") +
                ggplot2::geom_point(
                    ggplot2::aes(x = longitude, y = latitude, frame = time, color = pollutant_month_avg, size = pollutant_month_avg, tooltip = name)) +
                ggplot2::labs(title = "Average CO concentration per month \n(based on hourly data)", x = "Longitude", y = "Latitude", color = "Value")+
                ggplot2::theme(panel.background = ggplot2::element_rect(fill="white", color = "grey"), axis.line = ggplot2::element_line(colour = "grey"))+
                ggplot2::scale_color_gradient2(midpoint=4, low="green", mid = "yellow", high="red"), width = 700, height = 500
        )
    })

    ## Timeplots
    pollutant_complete <- dplyr::full_join(pollutant_data, pollutants_limits)

    output$ts_poll <- plotly::renderPlotly({
        pollutant_complete %>%
            dplyr::mutate(day = as.Date(Date_time, format = "%Y-%m-%d", tz="Europe/Zurich")) %>%
            dplyr::filter(pollutant == input$poll,
                          day >= input$date[1] &
                              day <= input$date[2]) %>%
            dplyr::group_by(day) %>%
            dplyr::summarise(avg = mean(value), lim = mean(limit)) %>%
            na.omit() %>%
            plotly::plot_ly(x = ~ day, y =  ~ avg,
                            type = "scatter", mode = "lines", name = "Average value per day") %>%
            plotly::add_lines(y =~lim, mode = "lines", name = "Recommended limit",
                              line = list(color = 'rgb(205, 12, 24)', width = 2, dash = "dash")) %>%
            plotly::layout(title = list(text = "Average value per day in Switzerland", x = 0.1) ,
                           xaxis = list(title = "Date"),
                           yaxis = list(title = "Value"))
    })

    output$ts_loc <- plotly::renderPlotly({
        pollutant_data %>%
            dplyr::mutate(day = as.Date(Date_time, format = "%Y-%m-%d", tz = "Europe/Zurich")) %>%
            dplyr::filter(name == input$loc,
                          day >= input$date2[1] &
                              day <= input$date2[2],
                          pollutant %in% input$poll2) %>%
            dplyr::group_by(day, pollutant) %>%
            dplyr::summarise(avg = mean(value, na.rm = TRUE)) %>%
            dplyr::ungroup() %>%
            plotly::plot_ly(x =~day, y=~avg, color =~pollutant,colors = "Set3",
                            type = "scatter", mode = "lines") %>%
            plotly::layout(title = list(text = "Average value per day", x = 0.1),
                           xaxis = list(title = "Date"),
                           yaxis = list(title = "Value"))
    })

    ## BarPlots
    pollutant_avg <- pollutant_data %>%
        dplyr::group_by(pollutant, name) %>%
        dplyr::mutate(average = mean(value, na.rm= TRUE)) %>%
        dplyr::select(pollutant, name, average) %>%
        unique()

    output$Barplot_NO2 <- shiny::renderPlot({
        pollutant_avg %>%
            dplyr::filter(pollutant == "NO2") %>%
            ggplot2::ggplot(
                ggplot2::aes (x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_hline(yintercept = 30, linetype = "dashed", color = "red") +
            ggplot2::geom_text(
                ggplot2::aes(3, 31, label = "Swiss Limit Regulation = 30"), color = "red") +
            ggplot2::ggtitle(label = "NO2") +
            ggplot2::labs(x = "Location", y = "Average concentration of NO2 in μg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    output$Barplot_o3 <- shiny::renderPlot({
        pollutant_avg %>%
            dplyr::filter(pollutant == "O3") %>%
            ggplot2::ggplot(
                ggplot2::aes (x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_hline(yintercept = 120, linetype = "dashed", color = "red") +
            ggplot2::geom_text(
                ggplot2::aes(3, 125, label = "Swiss Limit Regulation = 120"), color = "red") +
            ggplot2::ggtitle(label = "O3") +
            ggplot2::labs(x = "Location", y = "Average concentration of O3 in μg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    output$Barplot_SO2 <- shiny::renderPlot({
        pollutant_avg %>%
            dplyr::filter(pollutant == "SO2") %>%
            ggplot2::ggplot(
                ggplot2::aes (x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_hline(yintercept = 1.3, linetype = "dashed", color = "red") +
            ggplot2::geom_text(
                ggplot2::aes(2, 1.35, label = "Swiss Limit Regulation = 1.3"), color = "red") +
            ggplot2::ggtitle(label = "SO2") +
            ggplot2::labs(x = "Location", y = "Average concentration of SO2 in μg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    output$Barplot_PM2.5 <- shiny::renderPlot({
        pollutant_avg %>%
            dplyr::filter(pollutant == "PM2.5") %>%
            ggplot2::ggplot(
                ggplot2::aes (x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_hline(yintercept = 10, linetype = "dashed", color = "red") +
            ggplot2::geom_text(
                ggplot2::aes(3, 10.5, label = "Swiss Limit Regulation = 10"), color = "red") +
            ggplot2::ggtitle(label = "PM2.5") +
            ggplot2::labs(x = "Location", y = "Average concentration of PM2.5 in μg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    output$Barplot_PM10 <- shiny::renderPlot({
        pollutant_avg %>%
            dplyr::filter(pollutant == "PM10") %>%
            ggplot2::ggplot(
                ggplot2::aes (x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_hline(yintercept = 20, linetype = "dashed", color = "red") +
            ggplot2::geom_text(
                ggplot2::aes(3, 21, label = "Swiss Limit Regulation = 20"), color = "red") +
            ggplot2::ggtitle(label = "PM10") +
            ggplot2::labs(x = "Location", y = "Average concentration of PM10 in μg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    output$Barplot_CO <- shiny::renderPlot({ pollutant_avg %>%
            dplyr::filter(pollutant == "CO") %>%
            ggplot2::ggplot(
                ggplot2::aes(x = reorder(name, average), y = average)) +
            ggplot2::geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
            ggplot2::geom_text(
                ggplot2::aes(2, 0.30, label = "Swiss Limit Regulation = 8 mg m−3"), color = "red") +
            ggplot2::ggtitle(label = "CO") +
            ggplot2::labs(x = "Location", y = "Average concentration of CO in mg m−3") +
            ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 20),
                           panel.background = ggplot2::element_rect(fill = "white"),
                           panel.grid.major = ggplot2::element_line(colour = "grey88"))
    })

    ## Calendars
    output$calendar <- shiny::renderPlot({
        pollutant_data_cal <- pollutant_data %>%
            dplyr::mutate(day = as.Date(Date_time, format = "%Y-%m-%d", tz="Europe/Zurich")) %>%
            dplyr::group_by(day, pollutant) %>%
            dplyr::summarise(avg = mean(value, na.rm = TRUE)) %>%
            tidyr::spread(key = pollutant, value = avg) %>%
            dplyr::rename(date = day)

        openair::calendarPlot(
            pollutant_data_cal,
            pollutant = input$poll3,
            w.shift = 2,
            breaks =
                if (input$poll3 == "CO") {
                    c(0, 2, 8, 1000)
                }
            else if (input$poll3 == "NO2") {
                c(0, 7, 30, 1000)
            }
            else if (input$poll3 == "O3") {
                c(0, 30, 120, 1000)
            }
            else if (input$poll3 == "PM10") {
                c(0, 5, 20, 1000)
            }
            else if (input$poll3 == "SO2") {
                c(0, 7, 30, 1000)
            }
            else if (input$poll3 == "PM2.5") {
                c(0, 2.5, 10, 1000)
            }
            ,
            labels = c("low", "regular", "high"),
            cols = c("green", "yellow",  "red")
        )
    })

    output$calendar_temperature <- shiny::renderPlot({
        weather_df <- weather_data %>% tidyr::spread(weather, value)
        weather_df$date <- as.Date(format(weather_df$Date_time, "%Y-%m-%d"))

        openair::calendarPlot(weather_df, pollutant = "temperature", w.shift = 2,
                              cols = "jet", main = "Temperature")
    })

    output$calendar_precipitation <- shiny::renderPlot({
        weather_df <- weather_data %>% tidyr::spread(weather, value)
        weather_df$date <- as.Date(format(weather_df$Date_time, "%Y-%m-%d"))

        openair::calendarPlot(weather_df, pollutant = "precipitation", w.shift = 2,
                              cols = c("white", "blue 1", "blue 4"), main = "Precipitation")
    })
})



