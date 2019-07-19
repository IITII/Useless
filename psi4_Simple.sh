#!/bin/bash
cd ~/;
rm -rf psi4;
git clone https://github.com/psi4/psi4.git && cd psi4 && git checkout ecbda83;
conda create -n p4dev psi4-dev python=3.7 -c psi4;
conda activate p4dev;
`psi4-path-advisor --gcc`;
cd objdir && make -j`getconf _NPROCESSORS_ONLN`;