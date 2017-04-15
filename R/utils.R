na_omit <- function(x) x[!is.na(x)]

check_dictionary <- function(x){

    if(anyDuplicated(x[[1]]) > 0) stop("Duplicate tokens found in column one of the lemma dictionary.")

}


numreg <-  "(?<=^| )[-.]*\\d+(?:\\.\\d+)?(?= |\\.?$)|\\d+(?:,\\d{3})+(\\.\\d+)*"
