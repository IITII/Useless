#!/bin/bash
m=4
while ((m > 1)); do
    for ((i = 0; i < m; i++)); do
        printf " "
    done
    for ((j = 0; j < (4 - m) * 2 + 1; j++)); do
        printf "*"
    done
    m=$(expr $m - 1)
    echo ""
done
while ((m < 5)); do
    for ((i = 0; i < m; i++)); do
        printf " "
    done
    for ((j = 0; j < (4 - m) * 2 + 1; j++)); do
        printf "*"
    done
    m=$(expr $m + 1)
    echo ""
done