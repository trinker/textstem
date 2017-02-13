textstem   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Build
Status](https://travis-ci.org/trinker/textstem.svg?branch=master)](https://travis-ci.org/trinker/textstem)
[![Coverage
Status](https://coveralls.io/repos/trinker/textstem/badge.svg?branch=master)](https://coveralls.io/r/trinker/textstem?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
**textstem** is a tool-set for stemming and lemmatizing words. Stemming
is a process that removes affixes. Lemmatization is the process of
reducing words to base form.


Table of Contents
============

-   [Functions](#functions)
-   [Installation](#installation)
-   [Contact](#contact)

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
