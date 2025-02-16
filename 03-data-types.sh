#!/bin/bash

NUMBER11=$1
NUMBER22=$2

TIMESTAMP=$(date)

echo "script executed at:$TIMESTAMP"

SUM=$(($NUMBER1 + $NUMBER2))

echo "sum of $NUMBER1 and $NUMBER2 is: $sum"