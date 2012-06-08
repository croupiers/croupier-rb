context('** Exponential Distribution **')
# Run a K-S test on the Croupier sample against a exponential R-generated sample
# Accept Croupier's sample as exponential if p-value > 0.05
# Also check for a statistic near 0

context('Kolmogorov-Smirnov test for default lambda = 1')
  croupier_exponential <- read.table("../generated_samples/exponential_1.data")
  ks_result<-ks.test(croupier_exponential$V1, "pexp")

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Kolmogorov-Smirnov test for given lambda = 1.6')
  croupier_exponential <- read.table("../generated_samples/exponential_1_6.data")
  ks_result<-ks.test(croupier_exponential$V1, "pexp", rate = 1.6)

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })