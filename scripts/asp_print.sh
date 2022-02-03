#!/usr/bin/env bash

DOMAIN="$1"      # Name of the domain
INSTANCE="$2"    # Name of the instance
shift            # Shift all arguments to the left (original $1 gets lost)
shift            # Shift all arguments to the left (original $2 gets lost)
ARGUMENTS=("$@") # Rebuild the array with rest of arguments
PLATO_PATH=".."
PYTHON_PATH="scripts/python"
OUT_PATH="out/states"
# DOMAIN_PATH="../exp/ICLP20"

mkdir -p $OUT_PATH

cd $PLATO_PATH
clingo plato.lp --configuration=frumpy --heuristic=Vsids -t 2 $DOMAIN/domain.lp $DOMAIN/$INSTANCE > $OUT_PATH/output.txt;
python3 $PYTHON_PATH/out_render.py $OUT_PATH/output;
dot -Tpdf $OUT_PATH/output.dot > $OUT_PATH/output.pdf;

rm $OUT_PATH/output.txt;
rm $OUT_PATH/output.dot;
