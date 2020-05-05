#imageScrambleR: Image Scrambling Exercise in R and C++


*imageScrambleR* features functions that transpose chunks of an image array to create a scrambled image, as well as convenience functions to convert *magick* images to hexadecimal arrays containing grayscale pixel values, and those arrays back to *magick* images.  Scrambling functions are written pure R and Rcpp-enabled C++ to allow benchmark comparisons.

## Installation

## Installing R

*imageScrambleR* was written for R version 4.0 or higher.  Previous versions of R may possibly work, but at this time have not been verified.
To install R, follow the directions for your system on the website https://cloud.r-project.org.

If you choose to install the most current version of *imageScrambleR* from source on a Windows system, a valid Rtools installation is required and available at https://cran.r-project.org/bin/windows/Rtools/

RStudio, an IDE (interactive development environment) for R, is not required but is highly recommended.  To download RStudio, please visit https://www.rstudio.com/products/rstudio/download3/ and download and install the appropriate version for your system.  For any additional help, please visit https://www.rstudio.com/online-learning/ for help with R, or use the help menu in RStudio.

## Installing CRAN Dependencies

After installing R, install the CRAN packages required by *imageScrambleR* using command below in R, or use the Install button in the Packages pane in RStudio to install the *magick* package

`install.packages("magick")`

If you wish to perform benchmarking for the functions in *imageScrambleR* on your system as described in the vignette, the *microbenchmark* package is also required.

`install.packages("microbenchmark")`

## Installing *imageScrambleR* (Windows Binary Package)

Download the package file "imageScrambleR_1.0.zip" located in the /final folder in this repository.
To install *imageScrambleR* in RStudio, click on the Packages tab and click "Install" to open the Install Packages window. Under "Install From:" select "Package Archive File (.tgz; .tar.gz)" from the dropdown box, and if necessary click "Browse".  Then find the saved file "imageScrambleR_1.0.zip" on your computer, select it, and click "Install".  Alternatively, run the following command in R, replacing "/path/to/imageScrambleR" with the full file path, including the file name.

`install.packages("/path/to/imageScrambleR", repos = NULL, type = "source")`

## Installing *imageScrambleR* (Source)

The *devtools* package can be used to install a package directly from a Github repository.  On Windows systems, this requires a valid Rtools installation.  For other systems, please see the documentation at https://r-pkgs.org/setup.html#setup-tools

`install.packages("devtools")`
`devtools::install_github("cjminette/imageScrambleR")`

# Using *imageScrambleR*

For a guide on using the features of *imageScrambleR* please see the package vignette, which can be loaded from within R using the following:
`browseVignettes("imageScrambleR")`


Author: Carrie Minette
Maintainer: Carrie Minette <carrie.minette@coyotes.usd.edu
