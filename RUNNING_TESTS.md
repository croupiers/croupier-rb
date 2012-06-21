## Running tests

The tests suite of the gem is located in the /test folder, and it's divided in two sets that run separately:

* Ruby Tests
* R tests

### Ruby Tests

The ruby set of tests are meant to test the general behaviour of the library.
You can run these tests using the default Rake task:

    $ rake

### R tests

There's a group of tests validating the probability distribution of several samples of numbers generated with Croupier.
To generate samples to be tested, run the script ```generate_test_data.sh```:

    > ./generate_test_data.sh

Now you can run the R testsuite:
These tests are statistical tests included in R scripts.
To run them you need to have R installed in your system. You can get the R software from ```http://www.r-project.org/```

Dependencies:

The testsuite uses the 'testthat' package. You can install it from the R console with the folowing command:

    install.packages("testthat", repos = "http://cran.r-project.org/", type="source")

Other R packages needed:

    * triangle
    * vcd

The test script will try to intall all dependencies if they are not found in your R installation.
You can run the test/testsuite.R file:

Using Rscript:

    $ Rscript testsuite.R

or from the R console:

    source('testsuite.R')

