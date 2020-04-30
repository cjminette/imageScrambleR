#include <Rcpp.h>
using namespace Rcpp;
#include <vector>
using namespace std;

//' @name scrambler_Cpp2
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
// [[Rcpp::export]]
RawMatrix scrambler_Cpp2(RawMatrix arr, int nchunks) {
    int chunkR = ceil(arr.nrow() / nchunks);
    int chunkC = ceil(arr.ncol() / nchunks);

    vector<vector<int>> chunkRidx;
    vector<vector<int>> chunkCidx;

    int fromR, fromC, i, j;
    vector<int> temp;
    for(i = 0; i < nchunks; ++i){
        chunkCidx.push_back(temp);
        chunkRidx.push_back(temp);
    }
    for(i = 0; i < nchunks - 1; ++i){
        fromR = chunkR * i;
        fromC = chunkC * i;
        for(j = fromR; j < (fromR + chunkR); ++j){
            chunkRidx[i].push_back(j);
        }
        for(j = fromC; j < (fromC + chunkC); ++j){
            chunkCidx[i].push_back(j);
        }
    }
    // handle ends
    fromR = chunkR * (nchunks-1);
    fromC = chunkC * (nchunks-1);
    for(j = fromR; j < arr.nrow(); ++j){
        chunkRidx[nchunks-1].push_back(j);
    }
    for(j = fromC; j < arr.ncol(); ++j){
        chunkCidx[nchunks-1].push_back(j);
    }

    // vector<int> curR;
    // vector<int> curC;
    //
    // for(i = 0; i < nchunks - 1; ++i){
    //     fromR = chunkR * i;
    //     fromC = chunkC * i;
    //     for(j = fromR; j < (fromR + chunkR); ++j){
    //         curR.push_back(j);
    //     }
    //     chunkRidx.push_back(curR);
    //     curR.clear();
    //     for(j = fromC; j < (fromC + chunkC); ++j){
    //         curC.push_back(j);
    //     }
    //     chunkCidx.push_back(curC);
    //     curC.clear();
    // }
    // // handle ends
    // fromR = chunkR * (nchunks-1);
    // fromC = chunkC * (nchunks-1);
    // for(j = fromR; j < arr.nrow(); ++j){
    //     curR.push_back(j);
    // }
    // chunkRidx.push_back(curR);
    // for(j = fromC; j < arr.ncol(); ++j){
    //     curC.push_back(j);
    // }
    // chunkCidx.push_back(curC);
    // curR.clear();
    // curC.clear();

    // scramble the image

    RawMatrix scrambled(arr.nrow(), arr.ncol());
    int r, r2, c, c2, z;
    vector<int> curR;
    vector<int> curC;
    vector<int> order;
    for(i = 0; i < nchunks; ++i){
        order.push_back(i);
    }

    for(i = 0; i < nchunks; ++i){
        random_shuffle ( order.begin(), order.end() );
        for(j = 0; j < nchunks; ++j){
            z = order[j];

            // for(r = 0; r < chunkRidx.at(i).size(); ++r){
            //     for(c = 0; c < chunkCidx.at(z).size(); ++c){
            //         scrambled(chunkRidx.at(i).at(r), chunkCidx.at(j).at(c)) =
            //             arr(chunkRidx.at(i).at(r), chunkCidx.at(z).at(c));
            //     }
            // }

            for(c = 0; c < chunkCidx.at(z).size(); ++c){
                curC.push_back(chunkCidx[z][c]);
            }
        }
        for(j = 0; j < nchunks; ++j){
            for(r = 0; r < chunkRidx[i].size(); ++r){
                for(c = 0; c < curC.size(); ++c){
                    scrambled(chunkRidx[i][r],c) =
                        arr(chunkRidx[i][r], curC[c]);
                }
            }



            curC.clear();
        }
    }

    for(i = 0; i < nchunks; ++i){
        random_shuffle ( order.begin(), order.end() );
        for(j = 0; j < nchunks; ++j){
            z = order[j];

            // for(c = 0; c < chunkCidx.at(i).size(); ++c){
            //     for(r = 0; r < chunkRidx.at(z).size(); ++r){
            //         scrambled(chunkRidx.at(j).at(r), chunkCidx.at(i).at(c)) =
            //             arr(chunkRidx.at(z).at(r), chunkCidx.at(i).at(c));
            //     }
            // }
            for(r = 0; r < chunkRidx[z].size(); ++r){
                curR.push_back(chunkRidx[z][r]);
            }
        }
        for(j = 0; j < nchunks; ++j){
            for(c = 0; c < chunkCidx[i].size(); ++c){
                for(r = 0; r < curR.size(); ++r){
                    scrambled(r,chunkCidx[i][c]) =
                        arr(curR[r], chunkCidx[i][c]);
                }
            }
        }
        curR.clear();

    }

    return scrambled;

}

