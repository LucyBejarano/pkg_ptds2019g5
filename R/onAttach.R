.onAttach <- function(libname, pkgname) {
    
    if (!("openair" %in% rownames(installed.packages()))) {
        packageStartupMessage(
            paste0(
                "Please install `openair` by",
                " `devtools::install_github('davidcarslaw/openair')`"
            )
        )
    }
    
}