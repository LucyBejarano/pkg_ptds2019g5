#' @title Run Demo
#'
#' @description Allows to run a demo of our shiny app which presents visualizations of air pollution in Switzerland
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

run_demo <- function() {
    appDir <- system.file("shiny-app", "plots", package = "ptds2019g5")
    if (appDir == "") {
        stop(
            "Could not find `plots` directory. Try re-installing `ptds2019g5`",
            call. = FALSE
        )
    }
    
    shiny::runApp(appDir, display.mode = "normal")
    
}
