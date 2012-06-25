context('** Bernoulli Distribution **')

context('ChiSquare Goodness of Fit test for default success p = 0.5')
  croupier_bernoulli <- read.table("../generated_samples/bernoulli_05.data")
  cs_result<-summary(goodfit(croupier_bernoulli$V1, type="binomial", method="ML", par=list(size=1, prob=0.5)))

  test_that("p-value > 0.05, bernoulli, p = 0.5", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })

context('ChiSquare Goodness of Fit test for success p = 0.75')
  croupier_bernoulli <- read.table("../generated_samples/bernoulli_075.data")
  cs_result<-summary(goodfit(croupier_bernoulli$V1, type="binomial", method="ML", par=list(size=1, prob=0.75)))

  test_that("p-value > 0.05, bernoulli, p = 0.75", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })