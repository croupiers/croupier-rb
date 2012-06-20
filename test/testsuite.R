#!/usr/bin/env Rscript
#
# This script runs all the R tests of the croupier gem for all the distributions.
# Running the script:
#  Option 1, Via Rscript:
#    $> Rscript testsuite.R
#
#  Option 2, from the R console:
#    source('testsuite.R')
#
# In order to run the tests you need to have installed the testthat package
# If it is not included in your R installation you can do so running this command:
# install.packages("testthat", repos = "http://cran.r-project.org/", type="source")
#
library("testthat")
if(require('triangle') == FALSE) {
  install.packages('triangle')
  require('triangle')
}
test_dir("./distributions/R_tests/")
