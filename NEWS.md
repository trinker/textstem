NEWS
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor
  and patch)
* New additions without breaking backward compatibility bumps the minor
  (and resets the patch)
* Bug fixes and misc changes bumps the patch


textstem 0.1.0 -
----------------------------------------------------------------

**BUG FIXES**

* `lemmatize_strings` and `stem_strings` would split numbers with decimals
  rather than treating it as a single token.  This issue has been corrected
  (see <a href="https://github.com/trinker/textstem/issues/3">issue #3</a>).

**NEW FEATURES**

**MINOR FEATURES**

**IMPROVEMENTS**

**CHANGES**

textstem 0.0.1
----------------------------------------------------------------

This package is  collection of tools that stem and lemmatize text.  Stemming is
a process that removes endings such as suffixes.  Lemmatization is the process
of grouping inflected forms together as a single base form.