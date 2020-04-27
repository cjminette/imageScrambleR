#' @title Conversion Between 2-D Array and Image
#' @name imageScrambleR-conversions
#'
#' These two convenience functions provide conversion between images as handled
#' by \link[package]{magick} and two-dimensional arrays containing grayscale
#' data for images.
#'
#' @param imgArr a 2-D array containing grayscale pixel values
#' @param img a \pkg{magick} image object as returned by
#'     \code{\link[magick:image_read]{magick::image_read()}}

#'
#' @return A 2-D array containing grayscale pixel values, or a \pkg{magick}
#'     image object containing a grayscale image
#'
#' @examples
#' if(interactive()){
#'     imgArr <- array(c(1,1,2,2,1,1,2,2,3,3,4,4,3,3,4,4),
#'                     dim = c(4,4))
#'     print(imgArr)
#'     magick_imgArr <- arr2magick(imgArr)
#'     print(magick_imgArr)
#'
#'     magick_R <- magick::image_read(file.path(R.home("doc"), "html",
#'                                              "logo.jpg"))
#'     print(magick_R)
#'     imgArr_R <- magick2arr(magick_R)
#'     print(imgArr_R[1:10, 1:10])
#' }
NULL

#' @rdname imageScrambleR-conversions
#' @aliases imageScrambleR-conversions
#' @export
arr2magick <- function(imgArr){
    bm <- array(as.raw(0L), dim= c(1, length(imgArr[,1]), length(imgArr[1,])))
    bm[1,,] <- imgArr
    return(magick::image_read(bm))
}

#' @rdname imageScrambleR-conversions
#' @aliases imageScrambleR-conversions
#' @export
magick2arr <- function(img){
    bw <- magick::image_convert(img, colorspace = "gray")
    arr <- magick::image_data(bw)[1,,]
    return(arr)
}
