#' Scramble a 2-D Array
#'
#' Divides a two-dimensional array into \code{nchunk * nchunk} pieces and
#' scrambles the order in which the pieces appear without altering the size of
#' the array.
#'
#' @param arr The raw array to be scrambled
#' @param nchunks The number of chunks into which each dimension should be
#'     divided, i.e. \code{nchunks = 3} will divide the rows into 3 chunks and
#'     the columns into 3 chunks, yielding 9 pieces
#'
#' @return A scrambled version of \code{arr}
#' @export
#'
#' @examples
#' # for reproducible results, call set.seed()
#' set.seed(42)
#' scrambleMe <- array(as.raw(c(1,1,2,2,1,1,2,2,3,3,4,4,3,3,4,4)),
#'                     dim = c(4,4))
#' print(scrambleMe)
#' scrambleMe <- scrambler_R(arr = scrambleMe, nchunks = 2)
#' print(scrambleMe)

scrambler_R <- function(arr, nchunks){
    chunkR <- ceiling(nrow(arr) / nchunks)
    chunkC <- ceiling(ncol(arr) / nchunks)

    chunkRidx <- list()
    chunkCidx <- list()

    for(i in 0:(nchunks-2)){
        fromR <- (chunkR * i) + 1
        fromC <- (chunkC * i) + 1
        chunkRidx[[i+1]] <- seq.int(fromR, (fromR + chunkR - 1))
        chunkCidx[[i+1]] <- seq.int(fromC, (fromC + chunkC - 1))
    }
    i <- i + 1
    fromR <- (chunkR * i) + 1
    fromC <- (chunkC * i) + 1
    chunkRidx[[nchunks]] <- seq.int(fromR, nrow(arr))
    chunkCidx[[nchunks]] <- seq.int(fromC, ncol(arr))

    for(r in 1:nchunks){
        randomOrder <- sample.int(nchunks)
        ridx <- chunkRidx[[r]]
        arr[ridx, ] <- arr[ridx, unlist(chunkCidx[randomOrder])]
    }
    for(c in 1:nchunks){
        randomOrder <- sample.int(nchunks)
        cidx <- chunkCidx[[c]]
        arr[ , cidx] <- arr[unlist(chunkRidx[randomOrder]), cidx]
    }
    return(arr)
}
