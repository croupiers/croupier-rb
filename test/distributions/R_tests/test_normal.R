context('** Normal Distribution **')
# Run a K-S test on the Croupier sample against a exponential R-generated sample
# Accept Croupier's sample as normal if p-value > 0.05
# Also check for a statistic near 0

context('Kolmogorov-Smirnov test for default mean = 0 and std = 1')
  croupier_normal <- read.table("../generated_samples/normal_0_1.data")
  ks_result<-ks.test(croupier_normal$V1, "pnorm")

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Shapiro test for default mean = 0 and std = 1')
  croupier_normal <- read.table("../generated_samples/normal_0_1.data")
  s_result<-shapiro.test(croupier_normal$V1[1:5000])

  test_that("p-value > 0.05", {
    expect_true(s_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Kolmogorov-Smirnov test for given mean = 5 and std = 6')
  croupier_normal <- read.table("../generated_samples/normal_5_6.data")
  ks_result<-ks.test((croupier_normal$V1 - 5)/6, "pnorm")

  test_that("p-value > 0.05", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

context('Shapiro test for default mean = 5 and std = 1')
  croupier_normal <- read.table("../generated_samples/normal_0_1.data")
  s_result<-shapiro.test((croupier_normal$V1[1:5000] - 5 ) / 6)

  test_that("p-value > 0.05", {
    expect_true(s_result$p.value > 0.05)
  })

  test_that("statistic converging to 0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })
