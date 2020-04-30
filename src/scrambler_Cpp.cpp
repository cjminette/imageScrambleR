#include <Rcpp.h>
using namespace Rcpp;
#include <vector>
using namespace std;

//' @name scrambler_Cpp
//' @title Scramble a 2-D Array
//'
//' Divides a two-dimensional array into \code{nchunk * nchunk} pieces and
//' scrambles the order in which the pieces appear without altering the size of
//' the array.
//'
//' @param arr The array to be scrambled
//' @param nchunks Integer indicating the number of chunks into which each
//'     dimension should be divided, i.e. \code{nchunks = 3} will divide the
//'     rows into 3 chunks and the columns into 3 chunks, yielding 9 pieces
//'
//' @return A scrambled version of \code{arr}
//' @export
//'
//' @examples
//' # for reproducible results, call set.seed()
//' set.seed(42)
//' scrambleMe <- array(as.raw(c(1,1,2,2,1,1,2,2,3,3,4,4,3,3,4,4)),
//'                      dim = c(4,4))
//' print(scrambleMe)
//' scrambleMe <- scrambler_Cpp(arr = scrambleMe, nchunks = 2L)
//' print(scrambleMe)

// [[Rcpp::plugins("cpp11")]]

struct Chunk{int start = 0; int end = 0;};

// [[Rcpp::export]]
RawMatrix scrambler_Cpp(RawMatrix arr, int nchunks) {
    int chunkR = ceil(arr.nrow() / nchunks);
    int chunkC = ceil(arr.ncol() / nchunks);

    vector<Chunk> chunkRidx;
    vector<Chunk> chunkCidx;
    Chunk t, t2;
    int i;
    for(i = 0; i < nchunks; ++i){
        t.start = chunkR * i;
        // end is used non-inclusively
        t.end = t.start + chunkR;
        if (t.end >= arr.nrow()) t.end = arr.nrow();
        chunkRidx.emplace_back(t);
        t2.start = chunkC * i;
        t2.end = t2.start + chunkC;
        if (t2.end >= arr.ncol()) t2.end = arr.ncol();
        chunkCidx.emplace_back(t2);
    }


    // scramble the image

    RawMatrix scrambled(arr.nrow(), arr.ncol());
    int j, r, r2, c, c2, z;
    vector<int> order;
    for(i = 0; i < nchunks; ++i){
        order.push_back(i);
    }

    r2 = 0;
    for(i = 0; i < nchunks; ++i){
        random_shuffle ( order.begin(), order.end() );
        for(r = chunkRidx.at(i).start; r < chunkRidx.at(i).end; ++r){
            c2 = 0;
            for(j = 0; j < nchunks; ++j){
                z = order.at(j);
                for(c = chunkCidx.at(z).start; c < chunkCidx.at(z).end; ++c){
                    scrambled(r, c2) = arr(r, c);
                    ++c2;
                }
            }
        }
    }
    c2 = 0;
    for(i = 0; i < nchunks; ++i){
        random_shuffle ( order.begin(), order.end() );
        for(c = chunkCidx.at(i).start; c < chunkCidx.at(i).end; ++c){
            r2 = 0;
            for(j = 0; j < nchunks; ++j){
                z = order.at(j);
                for(r = chunkRidx.at(z).start; r < chunkRidx.at(z).end; ++r){
                    scrambled(r2, c) = arr(r, c);
                    ++r2;
                }
            }
        }
    }

    return scrambled;

}

