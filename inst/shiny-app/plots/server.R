library(shiny)
library(ggplot2)
library(dplyr)


shinyServer(function(input, output) {
    output$tmp <- renderPlot({
        pollutant_data %>%
            mutate(day = as.Date(Date_time, format = "%Y-%m-%d")) %>%
            filter(pollutant == input$poll,
                   day >= input$date[1] & day <= input$date[2]) %>%
            group_by(day) %>% 
            summarise(avg = mean(value)) %>%
            na.omit() %>%
            ggplot(aes(day, avg)) + geom_line() +
            theme_minimal()
        
        
    })
    
})
