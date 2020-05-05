#' @name imageScrambleR-package
#' @docType package
#' @title Image Scrambling Exercise in R and C++
#' @author Carrie Minette
#'
#' Maintainer: Carrie Minette <carrie.minette@coyotes.usd.edu>
#' @description Transposes chunks of an image array to create a scrambled image.
#'     Scrambling functions are written in pure R and Rcpp-enabled C++ to allow
#'     benchmark comparisons.

## usethis namespace: start
#' @useDynLib imageScrambleR, .registration = TRUE
## usethis namespace: end
NULL

## usethis namespace: start
#' @importFrom Rcpp sourceCpp
## usethis namespace: end
NULL

.onUnload <- function (libpath) {
    library.dynam.unload("imageScrambleR", libpath)
}
