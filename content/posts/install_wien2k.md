---
title: "Installation of Wien2k on Rocky Linux with Intel oneAPI"
date: 2024-12-13T16:13:13+08:00
tags: ["Wien2k", "eDMFT", "debian"]
categories: ["blog"] 
draft: false
---

Following the instructions  

```
Below you find the installation instructions:.

Move the WIEN2k-tar(.gz) file(s) into a (new) directory (eg. WIEN2k_24) which will become your $WIENROOT directory, uncompress the package using

tar -xvf WIEN2k_24.1.tar       (skip this if you downloaded files separately)
gunzip *.gz
chmod +x ./expand_lapw
./check_minimal_software_requirements.sh
This will check Linux for necessary and optional software like: tcsh, fortran compiler, fftw, .... If the required software cannot be found on your system, it does not make sense to continue with the installation. You MUST install the missing software components. (Missing optional software products may disable a few features of WIEN2k, but all important parts of WIEN2k can still run).

./expand_lapw
This will expand all files and copies various shell-scripts. In $WIENROOT/SRC you find the postscript and pdf versions of the usersguide (260 pages). Proceed with reading chapter "Installation". New users can then configure and compile WIEN using:

./siteconfig_lapw
If you want to update from a previous (recent) WIEN2k version you can greatly simplify the installation using a previous WIEN2k-directory. It will read the configuration from the corresponding WIEN2k_* files and all you need to do is recompile all programs:
./siteconfig_lapw -update prev_wien2k_dir
After successfull installation, every user should run:

./userconfig_lapw
which set's up the proper environment for WIEN (when you update from a previous version, just edit .bashrc/.cshrc and change the WIENROOT variable). Continue with chapter "Quick start" in the usersguide.

Gavin Abo provides 2 pdf files where he recorded a WIEN2k_23.2 installation on an Ubuntu 22.04.2 LTS Linux system with Intels OneAPI or the gfortran compiler.

Please have a regular look at the reg user site for news, updates and unsupported WIEN2k-related software.
```

"""

   ***********************************************************************
   *                                WIEN2k                               *
   *                          site configuration                         *
   ***********************************************************************

   This is the first time that you install WIEN2k on this computer. 
   If you interrupt the "first installation", you can come back using -first
   Please follow the subsequent steps to set up WIEN2k. 


You seem to have installed the ifort compiler at:
/opt/oneapi/2022/compiler/2022.1.0/linux/bin/intel64/ifort
Please remember VERSION and PATH for later reference
Your MKLROOT variable is: 
/opt/intel/oneapi/mkl/2025.0
I could not find your MKL_TARGET_ARCH. You will have to specify it later.

     Press RETURN to continue
```

```

   **************************************************************************
   *                            Specify a system                            *
   **************************************************************************

   Current system is: unknown

     LI   Linux (Intel ifort compiler (12.0 or later)+mkl+intelmpi))
     LS   Linux+SLURM-batchsystem (Intel ifort (12.0 or later)+mkl+intelmpi)
     LG   Linux (gfortran + gcc (version 6 or higher) + OpenBlas)
     
     M    show more, not updated older options (not recommended)     
  Selection: LS
     Selecting system linuxifs, please wait ...


     System linuxifs selected.

     Press RETURN to continue

```


```
   ***********************************************************************
   *                          Specify compilers                          *
   ***********************************************************************
     Recommended setting for f90 compiler: ifort
     Current selection (for current default just press ENTER):   ifort

     Your compiler: ifort

     Changing Compiler to ifort 
     Recommended setting for C compiler: cc
     Current selection (default):   cc

     Your compiler: cc

             SRC_structeditor/SRC_structgen

     Your Fortran compiler will be ifort.
     Your C compiler will be cc.

```

```
   ***********************************************************************
   *                 Specify compiler and linker options                 *
   ***********************************************************************

PLEASE NOTE: Best performance can be obtained with processor specific options. 
Very important for speed-up is an optimized BLAS (like mkl, OpenBlas, essl, ..)
instead of the simple "-lblas_lapw"

For more info see  http://www.wien2k.at/reg_user/faq

searching ...

You have the following mkl libraries in /opt/intel/oneapi/mkl/2025.0/lib/intel64 :
MKL_TARGET_ARCH was set to intel64
The default options shown on the next screen should be ok
Hit Enter to continue 
```


```
   **********************************************************************
   *                       Specify LIBXC settings                       *
   **********************************************************************
    echo "The current wien2k version supports an interface to libxc-5.1.2"
    echo "If you have libxc-5.0.0 you must copy manually in SRC_lapw0"
    echo "libxc.F_libxc5.0 libxc_mod.F_libxc5.0 and inputpars.F_libxc5.0"
    echo "to their default names." 

 Would you like to use LIBXC (needed ONLY for self-consistent gKS mGGA calculations, for the stress tensor and experts who want to play with different DFT options. It must have been installed before)? (y,N): 

   *********************************************************************
   *                       Specify FFTW settings                       *
   *********************************************************************

 We need a FFTW3 library, which must be installed on your system ! 
 To abort the FFTW setup enter 'x' at any point!

 Do you want to automatically search for FFTW installations? (Y,n):
Y
 Please specify a comma separated list of directories to search! (If no list is entered, 
 /usr/lib64, /usr/local and /opt will be searched as default):

```
ls /opt/hdf5/

bin  include  lib

```


```
kluo@ts: ~/Work/Apps/eDMFT
$ module list
Currently Loaded Modulefiles:
 1) tbb/2022.0   2) compiler-rt/2025.0.0   3) umf/0.9.0   4) mpi/2021.14   5) mkl/2025.0   6) oclfpga/2022.1.0   7) compiler/2022.1.0  
(python3) 
```

conda activate python3


configure.py 

```
#! /usr/bin/env python
# -*- coding: utf-8 -*-

class Config:
  prefix      = "bin"          # Installation path

  compiler    = "INTEL"        # Compiler
  
  cflags      = "-O2 -std=c++11" # compiling flags for C++ programs
  fflags      = "-O2"          # compiling flags for Fortran programs
  ldflags     = ""             # linking flags for Fortran programs
  ompflag     = "-fopenmp"     # linker/compiler flag for openmp

  cc          = "icx"          # new C compiler
  cxx         = "icpx"         # new C++ compiler
  
  mpi_define  = "-D_MPI"       # should be -D_MPI for mpi code and empty for serial code.
  #pcc         = "mpicc"        # C compiler 
  #pcxx        = "mpicxx"       # C++ compiler 
  #pfc         = "mpif90"       # Fortran compiler 
  
  pcc         = "mpiicc"        # C compiler 
  pcxx        = "mpiicpx"       # C++ compiler 
  pfc         = "mpiifort"       # Fortran compiler 

  blasname    = "MKL"             # BLAS   library
  #blaslib     = "-qmkl-ilp64=parallel -qmkl" # BLAS   library
  #blaslib     = "-L${MKLROOT}/lib/intel64 -lmkl_blacs_intelmpi_lp64 -qmkl" # BLAS   library
  #blaslib     = " -qmkl" # BLAS   library
  blaslib     = "-L${MKLROOT}/lib/  -qmkl" # BLAS   library

  lapacklib   = ""             # LAPACK library
  fftwlib     = "-lfftw3_omp -lfftw3"     # FFTW   library
  gsl         = "-L/usr/lib64 -lgslcblas -lgsl"  # GSL    library

  f2pylib     = "--f90flags='-fopenmp ' --opt='-fast'" # adding extra libraries for f2py
  f2pyflag    = "--opt='-O2' " # adding extra options to f2py

  arflags     = "rc"           # ar flags

  make        = "make"
  def __init__(self, version):
    self.version = version
  def __getattr__(self,key):
    return None
  
```

```
kluo@ts: ~/Work/Apps/eDMFT
$  python --version
Python 3.11.11
```

downgrade 3.12 to 3.11 to avoid problem of `distutils`  reported here https://github.com/numpy/numpy/issues/24838
***  BUG: f2py still attempts to import numpy.distutils on Python 3.12 when --fcompiler option is specified. #24838 ***

conda install python=3.11

```
$ ls bin/
2D_klist.py           copy_to_database.py   fat_fsplot.py           krams.so            occupr.so                  status_extend.py
2D_kplot.py           CoulUs.py             fermif                  lapw1               PlotBCS.py                 strns.so
analizeInfo.py        createDMFprefix.py    find3dRotation.py       lapw1c              plot_phonons_character.py  Suscept_LB.py
atom                  createW2kmachinef.py  find5dRotation.py       lapwso              plot_phonons.py            Suscept.py
atom_d.py             ctqmc                 findEF.py               latgen2.so          PlotSq.py                  szero.py
atomh                 ctqmcf                findNbands.py           latgen.so           prepare_onreal.py          trafo.so
BCSplot.py            ctqmc.py              findRot.py              ldau.so             prep_maxent_parallel.py    trafoso.so
BCS.py                cubic_harmonics.py    force2vasp.py           linalg.so           qlist_generate.py          transformations.py
brd.so                dclean.py             force_stop_conditon.py  link.py             qmc-progress.py            unfold2.py
broad                 dmft                  FSconvert.py            LinLogMesh.py       RCoulombU.py               unfold.py
brod.py               dmft2                 fsplot.py               local2global.py     rdU.so                     utils.py
bz.py                 dmft_copy.py          gaumesh.py              localaxes.py        readCore.py                w2k_atpar.so
cakw.so               dmft_DC.py            gaunt.so                magnetcoh.py        readTrans.py               w2k_nn.so
chemicalP.py          dmftgk                gpoint.so               MagneticMoment.py   run_dft.py                 wakplot.py
cif2indmf.py          dmftopt               hb1_sig.py              makplot.py          run_dmft.py                wakplot_sophisticated.py
cif2struct.py         dmft_real_bubble      imp2lattc.py            maxentropy.py       saverage.py                wavef.py
clean_dmft.py         downfold_2_to_1.py    indmffile.py            maxent_routines.so  scf_merge.py               wfsplot.py
clean_Titan_run.py    downfold.py           init_dmft.py            maxent_run.py       sgather.py                 Wigner.py
cmpEimp2.py           dpybind.so            init_proj.py            mergeopt.py         sigen.py                   wlatgen.py
cmpEimp.py            Elliashberg.py        kgenall.py              nca                 sinterp.py                 wstruct.py
CmpSlaterInt.py       equal_projector.py    klist2_generate.py      oca                 sjoin.py                   x_dmft.py
combineud             extractInfo.py        klist_generate.py       oca.py              skrams                     x_spaght.py
convert_processes.py  fat_coh.py            klist_gen.py            occupi.so           ssplit.py                  yw_excor.so
(python3) 

```