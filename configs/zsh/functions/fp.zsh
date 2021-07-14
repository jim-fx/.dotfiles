#Helps stop processes which use ports

function fp(){

    if [ "$(which lsof)" = "lsof not found" ]; then
        echo "lsof not installed"
    else
        for PORT in "$@"
        do
           if [ "$PORT" != "" ]; then
                #echo "checking ($PORT)"
                PIDS="$(lsof -t -i:$PORT)"
                AMOUNT=$(wc -w<<<$PIDS);

                if [ $AMOUNT = 0 ]; then
                    echo "No processes use port $PORT";
                else
                    echo "Killing $AMOUNT process(es) using port $PORT";
                    echo "$PIDS" | while IFS= read -r pid ; do 
                        kill -9 $pid;
                    done
                fi
            fi
        done
    fi

}
