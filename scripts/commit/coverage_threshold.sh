#!/usr/bin/env bash

COVERAGE=$(go tool cover -func=coverage.out | grep total | awk '{print $3}' | sed 's/%//')
echo "Quality Gate: checking test coverage is above threshold ..."
echo "Threshold                 : $COVERAGE_THRESHOLD %"
if (( $(echo "$COVERAGE < $COVERAGE_THRESHOLD" | bc -l) ))
then
	echo "Coverage $COVERAGE% is below threshold $COVERAGE_THRESHOLD%"
	exit 1
else
	echo "Coverage $COVERAGE% meets threshold" 
fi
