DOMAIN="$1"      # Name of the domain
INSTANCE="$2"    # Name of the instance
shift            # Shift all arguments to the left (original $1 gets lost)
shift            # Shift all arguments to the left (original $2 gets lost)
ARGUMENTS=("$@") # Rebuild the array with rest of arguments

clingo plato.lp --configuration=frumpy --heuristic=Vsids -t 2 $DOMAIN/domain.lp $DOMAIN/$INSTANCE;
