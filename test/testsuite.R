#!/usr/bin/env Rscript
#
# This script runs all the R tests of the croupier gem for all the distributions.
#
# Running the script:
#  Option 1, Via Rscript:
#    $> Rscript testsuite.R
#
#  Option 2, from the R console:
#    source('testsuite.R')
#
# Dependencies:
# In order to run the tests you need to have installed the following packages:
#
#   - testthat
#   - triangle
#   - vcd
#
# Croupier will try to install them automatically if they are not included
# in your R installation.

if(require('testthat') == FALSE) {
  install.packages('testthat', repos = "http://cran.r-project.org/", type="source")
  require('testthat')
}

if(require('triangle') == FALSE) {
  install.packages('triangle')
  require('triangle')
}
if(require('vcd') == FALSE) {
  install.packages('vcd')
  require('vcd')
}
options(warn=-1)
test_dir("./distributions/R_tests/")
options(warn=0)