context('** Cauchy Distribution **')
# Run a K-S test on the Croupier sample against a Cauchy R-generated sample
# Accept Croupier's sample as Cauchy if p-value > 0.05
# Also check for a statistic near 0

context('Kolmogorov-Smirnov test for default (location, scale) = (0,1)')
  croupier_cauchy <- read.table("../generated_samples/cauchy_0_1.data")
  ks_result<-ks.test(croupier_cauchy$V1, "pcauchy")

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Kolmogorov-Smirnov test for given (location, scale) = (12, 3)')
  croupier_cauchy <- read.table("../generated_samples/cauchy_12_3.data")
  ks_result<-ks.test(croupier_cauchy$V1, "pcauchy", location=12, scale=3)

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })