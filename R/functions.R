#' @title Load Swiss Air Pollutant Data
#'
#' @description Load into a list several dataset as retrieved from https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html.
#' Please name your datasets following this pattern: pollutant_date.csv where "pollutant" is the name of the pollutant
#' and "date" the concerned months.
#'
#' @param path A \code{char} path to locate the target files
#' @param pollutant A \code{char} vector containing the names of the pollutants you want to load
#' @param file_ext A\code{char} string containing the second part of the target files' names
#' @return A \code{list} containing the loaded data
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

load_data <- function(path, pollutant, file_ext) {
    file <- paste(pollutant, file_ext, sep ="")
    tmp <- sapply(path, paste, file, sep = "")
    loaded_file <- sapply(tmp, read.csv, stringsAsFactors = FALSE, encoding = "UTF-8")
}

#' @title Load Swiss Air Weather Data
#'
#' @description Load into a list several dataset as retrieved from https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html.
#' Please name your datasets following this pattern: weather_date.csv where "pollutant" is the name of the weather mesurement
#' and "date" the concerned months.
#'
#' @param path A \code{char} path to locate the target files
#' @param pollutant A \code{char} vector containing the names of the pollutants you want to load
#' @param file_ext A\code{char} string containing the second part of the target files' names
#' @return A \code{list} containing the loaded data
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

load_data2 <- function(path, pollutant, file_ext) {
    file <- paste(pollutant, file_ext, sep ="")
    tmp <- sapply(path, paste, file, sep = "")
    loaded_file <- lapply(tmp, read.csv2, stringsAsFactors = FALSE, encoding = "UTF-8")
}


#' @title Clean Swiss Location Names
#'
#' @description Cleans names of Swiss locations by removing all accents and replacing dashes by underscores.
#' @param name_vec A \code{char} vector containing the names to clean
#' @return A \code{vector} contains the cleaned names
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

clean_names <- function(name_vec){
    name_vec <- gsub("/","_", name_vec)
    name_vec <- gsub("-","_", name_vec)
    name_vec <- gsub("\xe0", "e", name_vec)
    name_vec <- gsub("\xe9", "e", name_vec)
    name_vec <- gsub("\xfc", "u", name_vec)
    name_vec <- gsub("\xe4", "a", name_vec)
}

#' @title Clean list of Swiss Air Pollutant dataframe
#'
#' @description Takes an untidied list of dataframes and cleans it. Cleans the locations' names and variables' type.
#' @param loaded_file A \code{list} list containing all the dataframes (returned by load_data())
#' @param pollutant A \code{char} vector containing names of pollutant
#' @return A \code{list} a cleaned and named list
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

clean_list <- function(loaded_file, pollutant){

    for (i in 1:length(loaded_file)) {
        var_names_tmp <- loaded_file[[i]][5,]
        var_names_tmp <- clean_names(var_names_tmp)
        colnames(loaded_file[[i]]) <- var_names_tmp
        loaded_file[[i]] <- loaded_file[[i]][-c(1:5),]
        loaded_file[[i]][, 1] <- as.POSIXct(loaded_file[[i]][,1], format = "%d.%m.%y %H:%M")
        for (j in 2:ncol(loaded_file[[i]])) {
            loaded_file[[i]][, j] <- as.numeric(loaded_file[[i]][, j])
        }
    }
    names(loaded_file) <- pollutant
    return(loaded_file)
}


#' @title Retrieve Swiss Location Names
#'
#' @description Retrieve the names of the Swiss locations present in the data
#' @param name_vec A \code{list} list containing the datasets as returned by clean_file()
#' @return A \code{vector} contains the locations' names
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clement Perez
#' @export

get_location_name <- function(loaded_file) {
    max_found <- 0
    index <- NULL
    for (i in 1:length(loaded_file)) {
        if (length(loaded_file[[i]]) > max_found) {
            max_found <- length(loaded_file[[i]])
            index <- i
        }
    }
    loc <- names(loaded_file[[index]])
    loc <- loc[-1]
    return(loc)
}
