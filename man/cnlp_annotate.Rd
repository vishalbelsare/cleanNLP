% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annotate.R
\name{cnlp_annotate}
\alias{cnlp_annotate}
\title{Run the annotation pipeline on a set of documents}
\usage{
cnlp_annotate(
  input,
  backend = NULL,
  verbose = 10,
  text_name = "text",
  doc_name = "doc_id"
)
}
\arguments{
\item{input}{an object containing the data to parse. Either a
character vector with the texts (optional names can
be given to provide document ids) or a data frame. The
data frame should have a column named 'text' containing
the raw text to parse; if there is a column named
'doc_id', it is treated as a a document identifier.
The name of the text and document id columns can be
changed by setting \code{text_name} and \code{doc_name}
This conforms with corpus objects respecting the Text
Interchange Format (TIF), while allowing for some
variation.}

\item{backend}{name of the backend to use. Will default to the last
model to be initalized.}

\item{verbose}{set to a positive integer n to display a progress
message to display every n'th record. The default is
10. Set to a non-positive integer to turn off messages.
Logical input is converted to an integer, so it also
possible to set to TRUE (1) to display a message for
every document and FALSE (0) to turn off messages.}

\item{text_name}{column name containing the text input. The default
is 'text'. This parameter is ignored when \code{input}
is a character vector.}

\item{doc_name}{column name containing the document ids. The default
is 'doc_id'. This parameter is ignored when
\code{input} is a character vector.}
}
\value{
a named list with components "token", "document" and (when
         running spacy with NER) "entity".
}
\description{
Runs the clean_nlp annotators over a given corpus of text
using the desired backend. The details for which annotators to run and
how to run them are specified by using one of:
\code{\link{cnlp_init_stringi}}, \code{\link{cnlp_init_spacy}}, or
\code{\link{cnlp_init_udpipe}}.
}
\details{
The returned object is a named list where each element containing a data
 frame. The document table contains one row for each document, along with
 with all of the metadata that was passed as an input. The tokens table
 has one row for each token detected in the input. The first three columns
 are always "doc_id" (to index the input document), "sid" (an integer index
 for the sentence number), and "tid" (an integer index to the specific
 token). Together, these are a primary key for each row.

 Other columns provide extracted data about each token, which differ slightly
 based on which backend, language, and options are supplied.
 \itemize{
   \item \bold{token}: detected token, as given in the original input
   \item \bold{token_with_ws}: detected token along with white space; in,
        theory, collapsing this field through an entire document will yield
        the original text
   \item \bold{lemma}: lemmatised version of the token; the exact form
        depends on the choosen language and backend
   \item \bold{upos}: the universal part of speech code; see
        \url{https://universaldependencies.org/u/pos/all.html}
        for more information
   \item \bold{xpos}: language dependent part of speech code; the specific
        categories and their meaning depend on the choosen backend, model
        and language
   \item \bold{feats}: other extracted linguistic features, typically given
        as Universal Dependencies
        (\url{https://universaldependencies.org/u/feat/index.html}), but can
        be model dependent; currently only provided by the udpipe backend
   \item \bold{tid_source}: the token id (tid) of the head word for the
        dependency relationship starting from this token; for the token
        attached to the root, this will be given as zero
   \item \bold{relation}: the dependency relation, usually provided using
        Universal Dependencies (more information available here
        \url{https://universaldependencies.org/}
        ), but could be different for a specific model
 }
}
\examples{
cnlp_init_stringi()
cnlp_annotate(un)

}
\author{
Taylor B. Arnold, \email{taylor.arnold@acm.org}
}
