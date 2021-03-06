% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{scrambler_Cpp2}
\alias{scrambler_Cpp2}
\title{Scramble a 2-D Array

Divides a two-dimensional array into \code{nchunk * nchunk} pieces and
scrambles the order in which the pieces appear without altering the size of
the array.}
\arguments{
\item{arr}{The array to be scrambled}

\item{nchunks}{Integer indicating the number of chunks into which each
dimension should be divided, i.e. \code{nchunks = 3} will divide the
rows into 3 chunks and the columns into 3 chunks, yielding 9 pieces}
}
\value{
A scrambled version of \code{arr}
}
\description{
Scramble a 2-D Array

Divides a two-dimensional array into \code{nchunk * nchunk} pieces and
scrambles the order in which the pieces appear without altering the size of
the array.
}
\examples{
# for reproducible results, call set.seed()
set.seed(42)
scrambleMe <- array(as.raw(c(1,1,2,2,1,1,2,2,3,3,4,4,3,3,4,4)),
                     dim = c(4,4))
print(scrambleMe)
scrambleMe <- scrambler_Cpp(arr = scrambleMe, nchunks = 2L)
print(scrambleMe)
}
