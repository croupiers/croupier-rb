context('** Negative Binomial Distribution **')

context('ChiSquare Goodness of Fit test for prob=0.5, size=5')
  croupier_nbinomial <- read.table("../generated_samples/nbinomial_05_5.data")
  cs_result<-summary(goodfit(croupier_nbinomial$V1, type="nbinomial", method="ML", par=list(size=5, prob=0.5)))

  test_that("p-value > 0.05, nbinomial, prob = 0.5, size=5", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })

context('ChiSquare Goodness of Fit test for prob = 0.25, size=15')
  croupier_nbinomial <- read.table("../generated_samples/nbinomial_025_15.data")
  cs_result<-summary(goodfit(croupier_nbinomial$V1, type="nbinomial", method="ML", par=list(size=15, prob=0.25)))

  test_that("p-value > 0.05, nbinomial, prob=0.25, size=15", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })
