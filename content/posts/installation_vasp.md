---
title: "Installation VASP"
date: 2024-11-11T15:23:21+08:00
tags: ["vasp", "debian"]
categories: ["blog"] 
draft: false
---

Before we do it, we assume that Intel `oneapi` toolkit has been correctly installed and activated using `source /opt/intel/oneapi/setvars.sh`.

## Installation using  Intel `oneapi` toolkit

Show the file structure of the vasp package 

```
$ tree -L 1
.
├── arch
├── bin
├── build
├── makefile
├── makefile.include
├── README.md
├── src
├── testsuite
└── tools

7 directories, 3 files
```


1.   Copy the makefile_include given in the arch directory to the top directory. This is what is normally done. However, here I use the makefile_include from page in  [vasp wiki](https://www.vasp.at/wiki/index.php/Makefile.include), click [makefile.include.oneapi_omp]( https://www.vasp.at/wiki/index.php/Makefile.include.oneapi_omp), which reads

```
# Default precompiler options
CPP_OPTIONS = -DHOST=\"LinuxIFC\" \
            -DMPI -DMPI_BLOCK=8000 -Duse_collective \
            -DscaLAPACK \
            -DCACHE_SIZE=4000 \
            -Davoidalloc \
            -Dvasp6 \
            -Duse_bse_te \
            -Dtbdyn \
            -Dfock_dblbuf \
            -D_OPENMP

CPP         = fpp -f_com=no -free -w0  $*$(FUFFIX) $*$(SUFFIX) $(CPP_OPTIONS)

FC          = mpiifort -fc=ifx -qopenmp
FCL         = mpiifort -fc=ifx

FREE        = -free -names lowercase

FFLAGS      = -assume byterecl -w

OFLAG       = -O2 
OFLAG_IN    = $(OFLAG)
DEBUG       = -O0 

OBJECTS     = fftmpiw.o fftmpi_map.o fftw3d.o fft3dlib.o
OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
OBJECTS_O2 += fft3dlib.o

# For what used to be vasp.5.lib
CPP_LIB     = $(CPP)
FC_LIB      = $(FC)
CC_LIB      = icx 
CFLAGS_LIB  = -O
FFLAGS_LIB  = -O1 
FREE_LIB    = $(FREE)

OBJECTS_LIB = linpack_double.o

# For the parser library
CXX_PARS    = icpx
LLIBS       = -lstdc++

##
## Customize as of this point! Of course you may change the preceding
## part of this file as well if you like, but it should rarely be
## necessary ...
##

# When compiling on the target machine itself, change this to the
# relevant target when cross-compiling for another architecture
VASP_TARGET_CPU ?= -xHOST
FFLAGS     += $(VASP_TARGET_CPU)

# Intel MKL (FFTW, BLAS, LAPACK, and scaLAPACK)
# (Note: for Intel Parallel Studio's MKL use -mkl instead of -qmkl)
FCL        += -qmkl
MKLROOT    ?= /path/to/your/mkl/installation
LLIBS      += -L$(MKLROOT)/lib/intel64 -lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64
INCS        =-I$(MKLROOT)/include/fftw

# HDF5-support (optional but strongly recommended)
#CPP_OPTIONS+= -DVASP_HDF5
#HDF5_ROOT  ?= /path/to/your/hdf5/installation
#LLIBS      += -L$(HDF5_ROOT)/lib -lhdf5_fortran
#INCS       += -I$(HDF5_ROOT)/include

# For the VASP-2-Wannier90 interface (optional)
#CPP_OPTIONS    += -DVASP2WANNIER90
#WANNIER90_ROOT ?= /path/to/your/wannier90/installation
#LLIBS          += -L$(WANNIER90_ROOT)/lib -lwannier

# For the fftlib library (hardly any benefit in combination with MKL's FFTs)
#FCL         = mpiifort fftlib.o -qmkl
#CXX_FFTLIB  = icpc -qopenmp -std=c++11 -DFFTLIB_USE_MKL -DFFTLIB_THREADSAFE
#INCS_FFTLIB = -I./include -I$(MKLROOT)/include/fftw
#LIBS       += fftlib
```

2.  Then `make` will generate  three executables 
```
$ tree bin/
bin/
├── vasp_gam
├── vasp_ncl
└── vasp_std

1 directory, 3 files
```

Next, one should be able to use them.


<!-- 
# sss   

https://www.vasp.at/wiki/index.php/METAGGA


cubic symmetry mult=3

FREE ENERGIE OF THE ION-ELECTRON SYSTEM (eV)
  ---------------------------------------------------
  free  energy   TOTEN  =        -3.11061918 eV


cubic symmetry mult=0
FREE ENERGIE OF THE ION-ELECTRON SYSTEM (eV)
  ---------------------------------------------------
  free  energy   TOTEN  =        -3.11058965 eV


Low symmetry mult=3

    FREE ENERGIE OF THE ION-ELECTRON SYSTEM (eV)
  ---------------------------------------------------
  free  energy   TOTEN  =        -3.11424340 eV

Low symmetry mult=0
  FREE ENERGIE OF THE ION-ELECTRON SYSTEM (eV)
  ---------------------------------------------------
  free  energy   TOTEN  =        -3.11456204 eV
 -->
