context('** Uniform Distribution **')
# Run a K-S test on the Croupier sample against a uniform R-generated sample
# Accept Croupier's sample as uniform if p-value > 0.05
# Also check for a statistic near 0

context('Kolmogorov-Smirnov test for default sample in [0,1]')
  croupier_uniform_0_1 <- read.table("../generated_samples/uniform_0_1.data")
  ks_result<-ks.test(croupier_uniform_0_1$V1, "punif")

  test_that("p-value > 0.05, uniform, [0,1]", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })


context('Kolmogorov-Smirnov test for sample with custom interval')
  croupier_uniform_5_33 <- read.table("../generated_samples/uniform_5_33.data")
  ks_result<-ks.test(croupier_uniform_5_33$V1, "punif", min = 5, max = 33)

  test_that("p-value > 0.05, uniform, [5,33]", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

