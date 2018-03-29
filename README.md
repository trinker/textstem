textstem   
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/0.1.0/active.svg)](https://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textstem.svg?branch=master)](https://travis-ci.org/trinker/textstem)
[![Coverage
Status](https://coveralls.io/repos/trinker/textstem/badge.svg?branch=master)](https://coveralls.io/r/trinker/textstem?branch=master)
[![](https://cranlogs.r-pkg.org/badges/textstem)](https://cran.r-project.org/package=textstem)

![](tools/textstem_logo/r_textstem.png)

**textstem** is a tool-set for stemming and lemmatizing words. Stemming
is a process that removes affixes. Lemmatization is the process of
grouping inflected forms together as a single base form.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Examples](#examples)
    -   [Load the Tools/Data](#load-the-toolsdata)
    -   [Stemming Versus Lemmatizing](#stemming-versus-lemmatizing)
        -   ["Drive" Stemming vs. Lemmatizing](#drive-stemming-vs-lemmatizing)
        -   ["Be" Stemming vs. Lemmatizing](#be-stemming-vs-lemmatizing)
    -   [Stemming](#stemming)
    -   [Lemmatizing](#lemmatizing)
        -   [Default Lemma Dictionary](#default-lemma-dictionary)
        -   [Hunspell Lemma Dictionary](#hunspell-lemma-dictionary)
        -   [koRpus Lemma Dictionary](#korpus-lemma-dictionary)
        -   [Lemmatization Speed](#lemmatization-speed)
    -   [Combine With Other Text Tools](#combine-with-other-text-tools)

Functions
============


The main functions, task category, & descriptions are summarized in the
table below:

<table>
<colgroup>
<col width="35%" />
<col width="15%" />
<col width="49%" />
</colgroup>
<thead>
<tr class="header">
<th>Function</th>
<th>Task</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>stem_words</code></td>
<td>stemming</td>
<td>Stem words</td>
</tr>
<tr class="even">
<td><code>stem_strings</code></td>
<td>stemming</td>
<td>Stem strings</td>
</tr>
<tr class="odd">
<td><code>lemmatize_words</code></td>
<td>lemmatizing</td>
<td>Lemmatize words</td>
</tr>
<tr class="even">
<td><code>lemmatize_strings</code></td>
<td>lemmatizing</td>
<td>Lemmatize strings</td>
</tr>
<tr class="odd">
<td><code>make_lemma_dictionary_words</code></td>
<td>lemmatizing</td>
<td>Generate a dictionary of lemmas for a text</td>
</tr>
</tbody>
</table>

Installation
============

To download the development version of **textstem**:

Download the [zip
ball](https://github.com/trinker/textstem/zipball/master) or [tar
ball](https://github.com/trinker/textstem/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/textstem")

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/textstem/issues>    
- send a pull request on: <https://github.com/trinker/textstem/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    

Examples
========

The following examples demonstrate some of the functionality of
**textstem**.

Load the Tools/Data
-------------------

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(textstem, dplyr)

    data(presidential_debates_2012)

Stemming Versus Lemmatizing
---------------------------

Before moving into the meat these two examples let's highlight the
difference between stemming and lemmatizing.

### "Drive" Stemming vs. Lemmatizing

    dw <- c('driver', 'drive', 'drove', 'driven', 'drives', 'driving')

    stem_words(dw)

    ## [1] "driver" "drive"  "drove"  "driven" "drive"  "drive"

    lemmatize_words(dw)

    ## [1] "driver" "drive"  "drive"  "drive"  "drive"  "drive"

### "Be" Stemming vs. Lemmatizing

    bw <- c('are', 'am', 'being', 'been', 'be')

    stem_words(bw)

    ## [1] "ar"   "am"   "be"   "been" "be"

    lemmatize_words(bw)

    ## [1] "be" "be" "be" "be" "be"

Stemming
--------

Stemming is the act of removing inflections from a word not necessarily
["identical to the morphological root of the word"
(wikipedia)](https://en.wikipedia.org/wiki/Stemming). Below I show
stemming of several small strings.

    y <- c(
        'the dirtier dog has eaten the pies',
        'that shameful pooch is tricky and sneaky',
        "He opened and then reopened the food bag",
        'There are skies of blue and red roses too!',
        NA,
        "The doggies, well they aren't joyfully running.",
         "The daddies are coming over...",
        "This is 34.546 above"
    )
    stem_strings(y)

    ## [1] "the dirtier dog ha eaten the pi"          
    ## [2] "that shame pooch i tricki and sneaki"     
    ## [3] "He open and then reopen the food bag"     
    ## [4] "There ar ski of blue and red rose too!"   
    ## [5] NA                                         
    ## [6] "The doggi, well thei aren't joyfulli run."
    ## [7] "The daddi ar come over..."                
    ## [8] "Thi i 34.546 abov"

Lemmatizing
-----------

### Default Lemma Dictionary

Lemmatizing is the ["grouping together the inflected forms of a word so
they can be analysed as a single item"
(wikipedia)](https://en.wikipedia.org/wiki/Lemmatisation). In the
example below I reduce the strings to their lemma form.
`lemmatize_strings` uses a lookup dictionary. The default uses
[Mechura's (2016)](http://www.lexiconista.com) English lemmatization
list available from the
[**lexicon**](https://cran.r-project.org/package=lexicon) package. The
`make_lemma_dictionary` function contains two additional engines for
generating a lemma lookup table for use in `lemmatize_strings`.

    y <- c(
        'the dirtier dog has eaten the pies',
        'that shameful pooch is tricky and sneaky',
        "He opened and then reopened the food bag",
        'There are skies of blue and red roses too!',
        NA,
        "The doggies, well they aren't joyfully running.",
         "The daddies are coming over...",
        "This is 34.546 above"
    )
    lemmatize_strings(y)

    ## [1] "the dirty dog have eat the pie"           
    ## [2] "that shameful pooch be tricky and sneaky" 
    ## [3] "He open and then reopen the food bag"     
    ## [4] "There be sky of blue and red rose too!"   
    ## [5] NA                                         
    ## [6] "The doggy, good they aren't joyfully run."
    ## [7] "The daddy be come over..."                
    ## [8] "This be 34.546 above"

### Hunspell Lemma Dictionary

This lemmatization uses the
[**hunspell**](https://CRAN.R-project.org/package=hunspell) package to
generate lemmas.

    lemma_dictionary_hs <- make_lemma_dictionary(y, engine = 'hunspell')
    lemmatize_strings(y, dictionary = lemma_dictionary_hs)

    ## [1] "the dirty dog ha eat the pie"               
    ## [2] "that shameful pooch i tricky and sneaky"    
    ## [3] "He open and then reopen the food bag"       
    ## [4] "There are sky of blue and re rose too!"     
    ## [5] NA                                           
    ## [6] "The doggy, well they aren't joyful running."
    ## [7] "The daddy are come over..."                 
    ## [8] "This i 34.546 above"

### koRpus Lemma Dictionary

This lemmatization uses the
[**koRpus**](https://CRAN.R-project.org/package=koRpus) package and the
[TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)
program to generate lemmas. You'll have to get TreeTagger set up,
preferably in your machine's root directory.

    lemma_dictionary_tt <- make_lemma_dictionary(y, engine = 'treetagger')
    lemmatize_strings(y, lemma_dictionary_tt)

    ## [1] "the dirty dog have eat the pie"           
    ## [2] "that shameful pooch be tricky and sneaky" 
    ## [3] "He open and then reopen the food bag"     
    ## [4] "There be sky of blue and red rose too!"   
    ## [5] NA                                         
    ## [6] "The doggy, well they aren't joyfully run."
    ## [7] "The daddy be come over..."                
    ## [8] "This be 34.546 above"

### Lemmatization Speed

It's pretty fast too. Observe:

    tic <- Sys.time()

    presidential_debates_2012$dialogue %>%
        lemmatize_strings() %>%
        head()

    ## [1] "We'll talk about specifically about health care in a moment."                            
    ## [2] "But what do you support the voucher system, Governor?"                                   
    ## [3] "What I support be no change for current retiree and near retiree to Medicare."           
    ## [4] "And the president support take dollar seven hundred sixteen billion out of that program."
    ## [5] "And what about the voucher?"                                                             
    ## [6] "So that's that's numb one."

    (toc <- Sys.time() - tic)

    ## Time difference of 0.8516021 secs

That's 2,912 rows of text, or 42,708 words, in 0.85 seconds.

Combine With Other Text Tools
-----------------------------

This example shows how stemming/lemmatizing might be complemented by
other text tools such as `replace_contraction` from the **textclean**
package.

    library(textclean)

    'aren\'t' %>% 
        lemmatize_strings()

    ## [1] "aren't"

    'aren\'t' %>% 
        textclean::replace_contraction() %>%
        lemmatize_strings()

    ## [1] "be not"