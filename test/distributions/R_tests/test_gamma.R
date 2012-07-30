context('** Gamma Distribution **')

context('Kolmogorov-Smirnov test for gamma, shape=1.0, scale=1.0')
  croupier_gamma <- read.table("../generated_samples/gamma_1_1.data")
  ks_result<-ks.test(croupier_gamma$V1, "pgamma", shape = 1.0, scale=1.0)

  test_that("p-value > 0.05 gamma, shape=1.0, scale=1.0", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0 gamma, shape=1.0, scale=1.0", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })


context('Kolmogorov-Smirnov test for gamma, shape=10.35, scale=2.5')
  croupier_gamma <- read.table("../generated_samples/gamma_1035_25.data")
  ks_result<-ks.test(croupier_gamma$V1, "pgamma", shape=10.35, scale=2.5)

  test_that("p-value > 0.05 gamma, shape=10.35, scale=2.5", {
    expect_true(ks_result$p.value > 0.05)
  })

  test_that("statistic converging to 0 gamma, shape=10.35, scale=2.5", {
    expect_true(as.numeric(ks_result$statistic) < 0.05)
  })

