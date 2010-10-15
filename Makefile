DEBUG ?= 0

ifeq ($(DEBUG), 1)
 FFLAGS_OPT=-O0 -fbounds-check -pg -g -ff2c #-fno-underscoring
 NAME_OPT=.debug
else
 FFLAGS_OPT=-O3 -funroll-loops
 NAME_OPT=
endif

F90=gfortran

#FFLAGS_OPT=-O3 -funroll-loops 
#FFLAGS_OPT=-O0 -fbounds-check -pg -g
#FFLAGS_OPT=-O0 -fbounds-check -pg -g -ff2c #-fno-underscoring
#FFLAGS_OPT=-O0  -fprofile-arcs -ftest-coverage

FFLAGS= $(FFLAGS_OPT) -fconvert=big-endian -frecord-marker=4

# Where would you like the executables?
EXTENSION=$(NAME_OPT).x86_64
BIN_DIR=${HOME}/bin

# Put object names here
OBJS=algorithms.o cell.o constants.o dos.o

all : optados

optados : $(OBJS)
	$(F90) $(FFLAGS) optados.f90 $(OBJS) -o $(BIN_DIR)/optdos$(EXTENSION) 

algorithms.o : constants.o
	$(F90) -c $(FFLAGS) algorithms.f90

cell.o : constants.o
	$(F90) -c $(FFLAGS) cell.f90

constants.o : 
	$(F90) -c $(FFLAGS) constants.f90

dos.o : constants.o
	$(F90) -c $(FFLAGS) dos.f90

# Utility targets
.PHONY: clean veryclean

clean:
	rm -f *.o *.mod *.MOD


