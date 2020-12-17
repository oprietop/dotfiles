#/usr/bin/sh
find . -name "*.png"  | xargs --max-procs=4 -n1 optipng -o7
