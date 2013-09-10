context('** Triangular Distribution **')
# Run a K-S test on the Croupier sample against a exponential R-generated sample
# Accept Croupier's sample as exponential if p-value > 0.05
# Also check for a statistic near 0

context('Kolmogorov-Smirnov test for a = -1, b = 5, c=4')
  croupier_exponential <- read.table("../generated_samples/triangular_-1_5_4.data")
  ks_result<-ks.test(croupier_exponential$V1, "ptriangle", a=-1, b=5, c=4)

  test_that("p-value > 0.05 triangular, not default parameters", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Kolmogorov-Smirnov test for default values a=0, b=1, c=0.5')
  croupier_exponential <- read.table("../generated_samples/triangular_0_1_05.data")
  ks_result<-ks.test(croupier_exponential$V1, "ptriangle", a=0, b=1, c=0.5)

  test_that("p-value > 0.05 triangular, default parameters", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })
