#' @title Load Swiss Air Pollutant Data
#'
#' @description Load into a list several dataset as retrieved from https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html.
#'
#' @param path A \code{char} path to locate the target files
#' @param pollutant A \code{char} vector containing names of pollutant to load
#' @param file_ext A\code{char} string containing the second part of the target files' names
#' @return A \code{list} containing the loaded data
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clément Perez
#' @export

load_data <- function(path, pollutant, file_ext) {
    file <- paste(pollutant, file_ext, sep ="")
    tmp <- sapply(path, paste, file, sep = "")
    loaded_file <- sapply(tmp, read.csv, stringsAsFactors = FALSE, encoding = "UTF-8")
}


#' @title Clean Swiss Location Names
#'
#' @description Cleans names of Swiss location by removing all accent and replacing dashes by underscore.
#' @param name_vec A \code{char} vector containing the names to clean
#' @return A \code{vector} containing the cleaned names
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clément Perez
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
#' @description Takes an untidied list of dataframe and cleans it. Cleans the locations' names and variables' type.
#' @param loaded_file A \code{list} list containing all the dataframes (return by load_data())
#' @param pollutant A \code{char} vector containing names of pollutant
#' @return A \code{list} a cleaned and labelled list
#'
#' @author Anna Alfieri, Ana Lucy Bejarano Montalvo, Saphir Kwan, Erika Lardo, Clément Perez
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


