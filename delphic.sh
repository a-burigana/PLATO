INSTANCE="$1"    # Name of the instance
shift            # Shift all arguments to the left (original $1 gets lost)
ARGUMENTS=("$@") # Rebuild the array with rest of arguments

DOMAIN_PATH=$(dirname "$INSTANCE")

clingo plato.lp --configuration=frumpy --heuristic=Vsids -t 2 $DOMAIN_PATH/domain.lp $INSTANCE;
