context('** Poisson Distribution **')

context('ChiSquare Goodness of Fit test for mean = 5')
  croupier_poisson <- read.table("../generated_samples/poisson_5.data")
  cs_result<-summary(goodfit(croupier_poisson$V1, type="poisson", method="ML", par=list(lambda=5)))

  test_that("p-value > 0.05, poisson mean = 5", {
    expect_true(cs_result[3] > 0.05)
  })

context('ChiSquare Goodness of Fit test for mean = 50')
  croupier_poisson <- read.table("../generated_samples/poisson_50.data")
  cs_result<-summary(goodfit(croupier_poisson$V1, type="poisson", method="ML", par=list(lambda=50)))

  test_that("err, poisson lambda = 50", {
    expect_true(cs_result[03] > 0.05)
  })
