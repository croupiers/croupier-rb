context('** Geometric Distribution **')

# It uses the fact that it is equivalent to a negative binomial
# distribution with parameters size=1 and prob = p (Wikipedia
# set p_{nbinomial} to be the fail probability while R takes
# it as the success one).
# Besides, since for the equality to hold the support must start
# at zero, it just substracts one from the vector of samples.
context('ChiSquare Goodness of Fit test for p=0.5')
  croupier_geometric <- read.table("../generated_samples/geometric_05.data")
  cs_result<-summary(goodfit(croupier_geometric$V1 - 1, type="nbinomial", method="ML", par=list(size=1, prob=0.5)))

  test_that("p-value > 0.05, geometric, p = 0.5", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })

context('ChiSquare Goodness of Fit test for p = 0.05')
  croupier_geometric <- read.table("../generated_samples/geometric_005.data")
  cs_result<-summary(goodfit(croupier_geometric$V1 - 1, type="nbinomial", method="ML", par=list(size=1, prob=0.05)))

  test_that("p-value > 0.05, geometric, p=0.05", {
    expect_true(cs_result['Pearson',3] > 0.05)
  })
