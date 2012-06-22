#!/bin/bash

OUTPUT_DIR=./test/distributions/generated_samples
mkdir -p $OUTPUT_DIR

echo 'Generating exponentials...'
ruby -Ilib ./bin/croupier exponential 10000 --lambda 1 > $OUTPUT_DIR/exponential_1.data
ruby -Ilib ./bin/croupier exponential 10000 --lambda 1.6 > $OUTPUT_DIR/exponential_1_6.data

echo 'Generating normals...'
ruby -Ilib ./bin/croupier normal 10000 --mean 0 --std 1 > $OUTPUT_DIR/normal_0_1.data
ruby -Ilib ./bin/croupier normal 10000 --mean 5 --std 6 > $OUTPUT_DIR/normal_5_6.data

echo 'Generating uniforms...'
ruby -Ilib ./bin/croupier uniform 10000 --a 0 --b 1 > $OUTPUT_DIR/uniform_0_1.data
ruby -Ilib ./bin/croupier uniform 10000 --a 5 --b 33 > $OUTPUT_DIR/uniform_5_33.data

echo 'Generating triangulars...'
ruby -Ilib ./bin/croupier triangular 10000 --a 0 --b 1 --c 0.5 > $OUTPUT_DIR/triangular_0_1_05.data
ruby -Ilib ./bin/croupier triangular 10000 --a -1 --b 5 --c 4 > $OUTPUT_DIR/triangular_-1_5_4.data

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
