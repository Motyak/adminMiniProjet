#!/usr/bin/gnuplot
set terminal dumb
set xlabel "heure"
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"
set datafile separator "|"
plot ".tmp" using 1:2 title "CPU Usage (%)" with lines