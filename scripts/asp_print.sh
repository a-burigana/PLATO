#!/usr/bin/env bash

DOMAIN="$1"      # Name of the domain
shift            # Shift all arguments to the left (original $1 gets lost)
ARGUMENTS=("$@") # Rebuild the array with rest of arguments
PLATO_PATH=".."
PYTHON_PATH="./python"
OUT_PATH="../out/states"
# DOMAIN_PATH="../exp/ICLP20"

clingo $PLATO_PATH/plato.lp $DOMAIN > $OUT_PATH/output.txt;
python3 $PYTHON_PATH/out_render.py $OUT_PATH/output;
dot -Tpdf $OUT_PATH/output.dot > $OUT_PATH/output.pdf;

rm $OUT_PATH/output.txt;
rm $OUT_PATH/output.dot;
