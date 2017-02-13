#' Lemmatize a Vector of Words
#'
#' Lemmatize a vector of words.
#'
#' @param x A vector of words.
#' @param dictionary A dictionary of base terms and lemmas to use for
#' replacement.  The first column should be the full word form in lower case
#' while the second column is the corresponding replacement lemma. The default
#' uses \code{\link[lexicon]{hash_lemmas}}.  This may come from
#' \code{\link[textstem]{make_lemma_dictionary}} as well, giving a more
#' targetted, smaller dictionary.  \code{\link[textstem]{make_lemma_dictionary}}
#' has schoices in \code{engine}s to use for the lemmatization.
#' @param \ldots ignored.
#' @return Returns a vector of lemmatized words.
#' @export
#' @seealso \code{\link[textstem]{lemmatize_strings}}
#' @examples
#' x <- c("the", NA, 'doggies', ',', 'well', 'they', 'aren\'t', 'Joyfully', 'running', '.')
#' lemmatize_words(x)
lemmatize_words <- function(x, dictionary = lexicon::hash_lemmas, ...) {
    locs <- match(tolower(x), dictionary[[1]])
    x[!is.na(locs)] <- dictionary[locs[!is.na(locs)], ][[2]]
    x
}


#' Lemmatize a Vector of Strings
#'
#' Lemmatize a vector of strings.
#'
#' @param x A vector of strings.
#' @param dictionary A dictionary of base terms and lemmas to use for
#' replacement.  The first column should be the full word form in lower case
#' while the second column is the corresponding repalcement lemma. The default
#' makes the dictionary from the text using
#' \code{\link[textstem]{make_lemma_dictionary}}.  For larger texts a
#' dictionary may take some time to compute.  It may be more useful to generate
#' the dictionary prior to running the unction and explicitly pass the
#' dictionary in.
#' @param \ldots Other arguments passed to \code{\link[textshape]{split_token}}.
#' @return Returns a vector of lemmatized strings.
#' @note The lemmatizer splits the string apart into tokens for speed
#' optimization.  After the lemmatizing occurs the strings are pasted back
#' together.  The strings are not guaranteed to retain exact spacing of the
#' original.
#' @export
#' @seealso \code{\link[textstem]{lemmatize_words}}
#' @examples
#' x <- c(
#'     'the dirtier dog has eaten the pies',
#'     'that shameful pooch is tricky and sneaky',
#'     "He opened and then reopened the food bag",
#'     'There are skies of blue and red roses too!',
#'     NA,
#'     "The doggies, well they aren't joyfully running.",
#'     "The daddies are coming over...",
#'     "This is 34.546 above"
#' )
#'
#' ## Default lexicon::hash_lemmas dictionary
#' lemmatize_strings(x)
#'
#' ## Hunspell dictionary
#' lemma_dictionary <- make_lemma_dictionary(x, engine = 'hunspell')
#' lemmatize_strings(x, dictionary = lemma_dictionary)
#'
#' ## Bigger data set
#' library(dplyr)
#' presidential_debates_2012$dialogue %>%
#'     lemmatize_strings() %>%
#'     head()
#'
#' \dontrun{
#' ## Treetagger dictionary
#' lemma_dictionary2 <- make_lemma_dictionary(x, engine = 'treetagger')
#' lemmatize_strings(x, lemma_dictionary2)
#'
#' lemma_dictionary3 <- presidential_debates_2012$dialogue %>%
#'     make_lemma_dictionary(engine = 'treetagger')
#'
#' presidential_debates_2012$dialogue %>%
#'      lemmatize_strings(lemma_dictionary3) %>%
#'      head()
#' }
lemmatize_strings <- function(x, dictionary = lexicon::hash_lemmas, ...) {

    na_locs <- is.na(x)
    tokens <- textshape::split_token(x, lower = FALSE, ...)
    locs <- textshape::starts(sapply(tokens, length))[-1]

    lemmatized <- textshape::split_index(lemmatize_words(unlist(tokens), dictionary = dictionary), locs)
    lemmatized[na_locs] <- x[na_locs]
    lemmatized[!na_locs] <- unlist(lapply(lemmatized[!na_locs],function(x) {
        gsub("(\\s+)([.!?,;:])", "\\2", paste(x, collapse = " "), perl = TRUE)
    }))
    unlist(lemmatized)
}


