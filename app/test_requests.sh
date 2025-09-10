#!/bin/bash

N=200

echo "Generating $N cache misses..."
for i in $(seq 1 $N); do
  curl -s http://localhost:9000/items/miss_$i > /dev/null
done

echo "Adding keys for hits..."
curl -s -X POST http://localhost:9000/items \
  -H 'Content-Type: application/json' \
  -d '{"key":"foo","value":"bar"}' > /dev/null

curl -s -X POST http://localhost:9000/items \
  -H 'Content-Type: application/json' \
  -d '{"key":"baz","value":"qux"}' > /dev/null

echo "Generating $N cache hits..."
for i in $(seq 1 $N); do
  curl -s http://localhost:9000/items/foo > /dev/null
  curl -s http://localhost:9000/items/baz > /dev/null
done

echo "Done! Check metrics at http://localhost:9000/metrics"
