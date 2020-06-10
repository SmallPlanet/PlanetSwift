#!/bin/sh

# set the directory to the dir in which this script resides
newPath=`echo $0 | awk '{split($0, a, ";"); split(a[1], b, "/"); for(x = 2; x < length(b); x++){printf("/%s", b[x]);} print "";}'`
cd "$newPath"

PROJECT_DIR=".."
GAXB_EXEC="./gaxb"
OUTPUT_DIR="$PROJECT_DIR/Sources/PlanetSwift/Generated"
mkdir -p "$OUTPUT_DIR"
"$GAXB_EXEC" swift "$PROJECT_DIR/XMLSchema/PlanetSwift.xsd" -t "$PROJECT_DIR/tools/template" -o "$OUTPUT_DIR"
