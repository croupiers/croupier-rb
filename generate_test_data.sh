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
