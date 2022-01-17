MAX_FREQ=$(lscpu | grep "CPU max MHz" | sed --expression "s/CPU max MHz:[[:space:]]*//g" | xargs printf "%.*f\n" 0)
CURRENT_MAX_FREG=$(cpufreq-info | grep "c")

