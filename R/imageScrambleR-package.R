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
