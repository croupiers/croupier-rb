## Running tests

The tests suite of the gem is located in the /test folder, and it's divided in two sets that run separately:

* Ruby Tests
* R tests

### Ruby Tests

The ruby set of tests are meant to test the general behaviour of the library.
You can run these tests using the default Rake task:

    $ rake

### R tests (automagic)

Make sure you have downloaded all git submodules first since R tests are now a
dependency. From the 2.0 release, validating the distributions is as simple as running:

    > rake test:distributions

### R tests (manual steps)

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

The test script will try to install all dependencies if they are not found in your R installation.
You can run the test/rtests.R file:

Using Rscript:

    $ Rscript rtests.R

or from the R console:

    source('rtests.R')

