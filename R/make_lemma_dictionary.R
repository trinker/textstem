#' Generate a Lemma Dictionary
#'
#' Given a set of text strings, the function generates a dictionary of lemmas
#' corresponding to words that are not in base form.
#'
#' @param \ldots A vector of texts to generate lemmas for.
#' @param engine One of: "hunspell", "treetragger" or "lexicon".  The lexicon and hunspell choices use
#' the \pkg{lexicon} and \pkg{hunspell} packages, which may be faster than
#' TreeTagger, have the tooling available without installing external tools but
#' are likely less accurate.  TreeTagger is likely more accurate but requires installing
#' the \href{http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger}{TreeTagger}
#' program (\url{http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger}.
#' @param path Path to the TreeTagger program if \code{engine = "treetagger"}.
#' If \code{NULL} \code{textstem} will attempt to locate the location of
#' TreeTagger.
#' @return Returns a two column \code{\link[base]{data.frame}} with tokens and
#' corresponding lemmas.
#' @export
#' @examples
#' x <- c('the dirtier dog has eaten the pies',
#'     'that shameful pooch is tricky and sneaky',
#'     "He opened and then reopened the food bag",
#'     'There are skies of blue and red roses too!'
#' )
#' make_lemma_dictionary(x)
#' \dontrun{
#' make_lemma_dictionary(x, engine = 'treetagger')
#' }
make_lemma_dictionary <- function(..., engine = 'hunspell', path = NULL) {

    lemma <- token <- NULL
    tokens <- na_omit(unique(unlist(quanteda::tokens(tolower(unlist(...))))))

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
                !lemma %in% c("<unknown>", '@card@') & nchar(token) > 1 & token != tolower(lemma)
            )), token), lemma = lemma)
        },
        hunspell = {
            out <- unlist(Map(function(y, x){
                if (length(y) == 0 | (length(x) == 1 && x %in% keeps)) return(NA)
                y[length(y)]
            }, hunspell::hunspell_stem(tokens), tokens))

            out <- data.frame(
                token = tokens[!out == tokens & !is.na(out)],
                lemma = out[!out == tokens & !is.na(out)],
                stringsAsFactors = FALSE
            )
        },
        lexicon = {
            out <- as.data.frame(dplyr::filter(dplyr::tbl_df(lexicon::hash_lemmas), token %in%  tokens), stringsAsFactors = FALSE)
        },
        stop('`engine` must be one of: "hunspell", "treetragger", or "lexicon"')
    )
    out
}

keeps <- c('then')


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

        path <- myPaths[file.exists(myPaths)][1]

    }

    tt <- length(path) == 1 && file.exists(path)

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

