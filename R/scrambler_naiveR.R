#' Scramble a 2-D Array
#'
#' Divides a two-dimensional array into \code{nchunk * nchunk} pieces and
#' scrambles the order in which the pieces appear without altering the size of
#' the array.  This implementation is designed to mimic code written by someone
#' who is not very familiar with vector optimization in R.
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
#' scrambleMe <- scrambler_naiveR(arr = scrambleMe, nchunks = 2)
#' print(scrambleMe)

scrambler_naiveR <- function(arr, nchunks){
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

    arr2 <- arr
    for(i in seq.int(1,nchunks)){
        randomOrder <- sample.int(nchunks)
        ridx <- chunkRidx[[i]]
        for(r in seq.int(ridx[1], ridx[length(ridx)])){
            c2 <- 1
            for(j in seq.int(1,nchunks)){
                k <- randomOrder[j]
                cidx <- chunkCidx[[k]]
                for(c in seq.int(cidx[1], cidx[length(cidx)])){
                    arr2[r,c2] <- arr[r, c]
                    c2 <- c2 + 1
                }
            }
        }
    }
    arr3 <- arr2
    for(i in seq.int(1, nchunks)){
        randomOrder <- sample.int(nchunks)
        cidx <- chunkCidx[[i]]
        for(c in seq.int(cidx[1], cidx[length(cidx)])){
            r2 <- 1
            for(j in seq.int(1,nchunks)){
                k <- randomOrder[j]
                ridx <- chunkRidx[[k]]
                for(r in seq.int(ridx[1], ridx[length(ridx)])){
                    arr3[r2, c] <- arr2[r, c]
                    r2 <- r2 + 1
                }
            }
        }
    }
    return(arr3)
}
