context('** Binomial Distribution **')

context('ChiSquare Goodness of Fit test for p=0.5, size=5')
  croupier_binomial <- read.table("../generated_samples/binomial_05_5.data")
  cs_result<-summary(goodfit(croupier_binomial$V1, type="binomial", method="ML", par=list(size=5, prob=0.5)))

  test_that("p-value > 0.05, binomial, p = 0.5, size=5", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })

context('ChiSquare Goodness of Fit test for p = 0.35, size=17')
  croupier_binomial <- read.table("../generated_samples/binomial_035_17.data")
  cs_result<-summary(goodfit(croupier_binomial$V1, type="binomial", method="ML", par=list(size=17, prob=0.35)))

  test_that("p-value > 0.05, binomial, p=0.35, size=17", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })