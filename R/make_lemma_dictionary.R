#' x <- c('the dirtier dog has eaten the pies',
#'     'that shameful pooch is tricky and sneaky',
#'     'There are skies of blue and red roses too!'
#' )
#' make_lemma_dictionary(x)
#' make_lemma_dictionary(x, engine = 'treetagger')

make_lemma_dictionary <- function(..., engine = 'hunspell', path = NULL) {

    lemma <- token <- NULL
    tokens <- unique(unlist(quanteda::tokenize(tolower(unlist(...)))))

    switch(engine,
        treetagger = {
            path <- tree_tagger_location(path)

            tagged.results <- suppressMessages(koRpus::treetag(
                unlist(tokens),
                treetagger="manual",
                format="obj",
                TT.tknz=FALSE ,
                lang="en",
                TT.options=list(path=path, preset="en")
            ))

            out <- dplyr::rename(dplyr::arrange(dplyr::distinct(dplyr::filter(
                tagged.results@TT.res[c("token", "lemma")],
                lemma != "<unknown>" & nchar(token) > 1 & token != tolower(lemma)
            )), token), lemma = lemma)
        },
        hunspell = {
                out <- unlist(Map(function(y, x){
                    if (length(y) == 0) return(NA)
                    y[length(y)]
                }, hunspell::hunspell_stem(tokens), tokens))

                out <- data.frame(
                    token = tokens[!out == tokens & !is.na(out)],
                    lemma = out[!out == tokens & !is.na(out)],
                    stringsAsFactors = FALSE
                )

        }
    )
    out
}




tree_tagger_location <- function(path = NULL) {

    if (is.null(path)){
        myPaths <- c("TreeTagger",  "~/.cabal/bin/TreeTagger",
            "~/Library/TreeTagger", "C:\\PROGRA~1\\TreeTagger",
            "C:/TreeTagger")

        path <- myPaths[file.exists(myPaths)]
    }

    tt <- file.exists(path)|length(path) == 0

    if (!tt) {
        message("TreeTagger does not appear to be installed.\nWould you like me to open a download browser?")
        ans <- utils::menu(c("Yes", "No"))

        if (ans == 1) {
            utils::browseURL("http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/#Windows")
            stop("Retry after downloading TreeTagger or setting `path` to the correct location.")
        } else {
            stop('Download tagger from: "http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger"\nand place in the root director')
        }
    }
    path
}





tree_tagger_location <- function(path = NULL) {

    if (is.null(path)){
        myPaths <- c("TreeTagger",  "~/.cabal/bin/TreeTagger",
            "~/Library/TreeTagger", "C:\\PROGRA~1\\TreeTagger",
            "C:/TreeTagger")

        path <- myPaths[file.exists(myPaths)]
    }

    tt <- file.exists(path)|length(path) == 0

    if (!tt) {
        message("TreeTagger does not appear to be installed.\nWould you like me to open a download browser?")
        ans <- utils::menu(c("Yes", "No"))

        if (ans == 1) {
            utils::browseURL("http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/#Windows")
            stop("Retry after downloading TreeTagger or setting `path` to the correct location.")
        } else {
            stop('Download tagger from: "http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger"\nand place in the root director')
        }
    }
    path
}

