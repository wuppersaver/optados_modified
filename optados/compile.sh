#!/bin/sh
#PBS -N od_mod_compilation
#PBS -l select=1:ncpus=1:mem=25GB
#PBS -l walltime=01:00:00

cd $PBS_O_WORKDIR

module load intel-suite

CASE_OUT=compile_od_schottky.log

make 2>&1 | tee $CASE_OUT