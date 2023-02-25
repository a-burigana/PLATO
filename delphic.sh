
#!/bin/bash
clingo_args="-t 2 --configuration=frumpy"
# frumpy, many
# --heuristic=Vsids
instance=""
domain_path=""
semantics="semantics/delphic.lp"
config="run_config/find_plan.lp"

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
        clingo_args+=" --verbose=0"
        shift # past argument=value
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

clingo plato.lp $clingo_args $domain_path/domain.lp $instance $semantics $config
