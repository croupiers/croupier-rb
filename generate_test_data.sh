#!/bin/bash

OUTPUT_DIR=./test/sample_test/generated_samples
mkdir -p $OUTPUT_DIR

echo 'Generating exponentials...'
ruby -Ilib ./bin/croupier exponential 10000 --lambda 1 > $OUTPUT_DIR/exponential_1.data
ruby -Ilib ./bin/croupier exponential 10000 --lambda 1.6 > $OUTPUT_DIR/exponential_1_6.data

echo 'Generating normals...'
ruby -Ilib ./bin/croupier normal 10000 --mean 0 --std 1 > $OUTPUT_DIR/normal_0_1.data
ruby -Ilib ./bin/croupier normal 10000 --mean 5 --std 6 > $OUTPUT_DIR/normal_5_6.data

echo 'Generating uniforms...'
ruby -Ilib ./bin/croupier uniform 10000 --included 0 --excluded 1 > $OUTPUT_DIR/uniform_0_1.data
ruby -Ilib ./bin/croupier uniform 10000 --included 5 --excluded 33 > $OUTPUT_DIR/uniform_5_33.data

echo 'Generating triangulars...'
ruby -Ilib ./bin/croupier triangular 10000 --lower 0 --upper 1 --mode 0.5 > $OUTPUT_DIR/triangular_0_1_05.data
ruby -Ilib ./bin/croupier triangular 10000 --lower -1 --upper 5 --mode 4 > $OUTPUT_DIR/triangular_-1_5_4.data

echo 'Generating poissons...'
ruby -Ilib ./bin/croupier poisson 10000 --lambda 5 > $OUTPUT_DIR/poisson_5.data
ruby -Ilib ./bin/croupier poisson 10000 --lambda 50 > $OUTPUT_DIR/poisson_50.data

echo 'Generating cauchys...'
ruby -Ilib ./bin/croupier cauchy 10000 > $OUTPUT_DIR/cauchy_0_1.data
ruby -Ilib ./bin/croupier cauchy 10000 --location 12 --scale 3 > $OUTPUT_DIR/cauchy_12_3.data

echo 'Generating geometrics...'
ruby -Ilib ./bin/croupier geometric 10000 -p 0.5 > $OUTPUT_DIR/geometric_05.data
ruby -Ilib ./bin/croupier geometric 10000 -p 0.05 > $OUTPUT_DIR/geometric_005.data

echo 'Generating nbinomials...'
ruby -Ilib ./bin/croupier nbinomial 10000 -p 0.5 --size 5 > $OUTPUT_DIR/nbinomial_05_5.data
ruby -Ilib ./bin/croupier nbinomial 10000 -p 0.25 --size 15 > $OUTPUT_DIR/nbinomial_025_15.data

echo 'Generating binomials...'
ruby -Ilib ./bin/croupier binomial 10000 -p 0.5 --size 5 > $OUTPUT_DIR/binomial_05_5.data
ruby -Ilib ./bin/croupier binomial 10000 -p 0.35 --size 17 > $OUTPUT_DIR/binomial_035_17.data

echo 'Generating bernoullis...'
ruby -Ilib ./bin/croupier bernoulli 10000 > $OUTPUT_DIR/bernoulli_05.data
ruby -Ilib ./bin/croupier bernoulli 10000 -p 0.75 > $OUTPUT_DIR/bernoulli_075.data

echo 'Generating credit cards...'
ruby -Ilib ./bin/croupier credit_card 10 > $OUTPUT_DIR/credit_card.data
ruby -Ilib ./bin/croupier credit_card 10 --visa > $OUTPUT_DIR/credit_card_visa.data
ruby -Ilib ./bin/croupier credit_card 10 --master-card > $OUTPUT_DIR/credit_card_master_card.data
ruby -Ilib ./bin/croupier credit_card 10 --discover --initial-values 12345 > $OUTPUT_DIR/credit_card_discover.data
ruby -Ilib ./bin/croupier credit_card 10 --american-express > $OUTPUT_DIR/credit_card_american_express.data

echo 'Generating gammas...'
ruby -Ilib ./bin/croupier gamma 10000 --shape 1.0 --scale 1.0 > $OUTPUT_DIR/gamma_1_1.data
ruby -Ilib ./bin/croupier gamma 10000 --shape 10.35 --scale 2.5 > $OUTPUT_DIR/gamma_1035_25.data
