
#!/bin/bash
PYTHON_PATH="scripts/python"
OUT_PATH="out/states"

clingo_args="-t 2 --configuration=frumpy"
# frumpy, many
# --heuristic=Vsids
instance=""
domain_path=""
semantics="semantics/ma_rho.lp"
config="run_config/find_plan.lp"
print=false
new_features=false

while [[ $# -gt 0 ]]; do
    case $1 in
    -i|--instance)
        instance="$2"
        domain_path=$(dirname "$instance")
        shift # past argument
        shift # past value
        ;;
    -s|--semantics)
        if [ "$2" = poss ] ; then
            semantics="semantics/ma_rho.lp"
        elif [ "$2" = kripke ] ; then
            semantics="semantics/ma_star.lp"
        else
            echo "Unknown semantics $input"
            exit 1
        fi
        shift # past argument
        shift # past value
        ;;
    -d|--debug)
        config="run_config/debug.lp"
        shift # past argument=value
        ;;
    -p|--print)
        print=true
        shift # past argument with no value
        ;;
    ---n)
        config="run_config/find_plan1.lp"
        semantics="semantics/ma_rho1.lp"
        new_features=true
        shift
        ;;
    ---c)
        semantics="semantics/ma_rho2.lp"
        shift
        ;;
    -*|--*)
        clingo_args+=" ${1}"
        shift # past argument
        ;;
    *)
        clingo_args+=" ${1}" # save positional arg
        shift # past argument
        ;;
    esac
done

if [ "$print" = false ] ; then
    if [ "$new_features" = false ] ; then
        clingo plato.lp $clingo_args $domain_path/domain.lp $instance $semantics $config
    else
        clingo plato.lp $clingo_args $domain_path/domain1.lp $instance $semantics $config
    fi
else
    mkdir -p $OUT_PATH

    if [ "$new_features" = false ] ; then
        clingo plato.lp $clingo_args run_config/print.lp $domain_path/domain.lp $instance $semantics $config > $OUT_PATH/output.txt;
    else
        clingo plato.lp $clingo_args run_config/print.lp $domain_path/domain1.lp $instance $semantics $config > $OUT_PATH/output.txt;
    fi
    python3 $PYTHON_PATH/out_render.py $OUT_PATH/output;
    dot -Tpdf $OUT_PATH/output.dot > $OUT_PATH/output.pdf;

    rm $OUT_PATH/output.txt;
    rm $OUT_PATH/output.dot;
fi
