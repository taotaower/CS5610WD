#!/bin/bash

# Attribution: refer to Prof's deploying script
export PORT=5103

cd ~/www/usertask
./bin/usertask stop || true
./bin/usertask start