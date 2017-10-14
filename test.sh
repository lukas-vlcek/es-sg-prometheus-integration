#!/bin/bash

set -ex

testUser() {

  echo "Access REST API as ${1} user"
  curl -sS --insecure -u ${1}:test https://localhost:9200/_prometheus/metrics | tail -n 5
  curl -sS --insecure -u ${1}:test https://localhost:9200/_cluster/health
  curl -sS --insecure -u ${1}:test https://localhost:9200/_nodes/stats | tail -n 1 | sed -E "s/(.{200}).*$/\1/"
  echo

}

testUser first_perm
testUser second_perm
testUser both_perms
testUser prometheus_perm

