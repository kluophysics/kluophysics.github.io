---
title: "My First Post"
date: 2024-06-28T16:09:29+08:00
# layout: "page"
# url: blog/
tags: ["test", "markdown"]
categories: ["blog"] 
draft: false
---


version 7.2.2-release

```
export NWCHEM_TOP=$PWD

export NWCHEM_TARGET=LINUX64

export USE_MPI=y

export NWCHEM_MODULES="all python"

#MRCC_METHODS can be set to request the multireference coupled cluster capability to be included in the code, e.g.
export MRCC_METHODS=y #TRUE 

#CCSDTQ can be set to request the CCSDTQ method and its derivatives to be included in the code, e.g.
#export CCSDTQ=TRUE

export PYTHONVERSION=3.11

export BLASOPT="-lopenblas -lpthread -lrt"

export LAPACK_LIB=$BLASOPT

export SCALAPACK_SIZE=4
export SCALAPACK="-lscalapack-openmpi"

export BLAS_SIZE=4
export USE_64TO32=y


export FC=gfortran
export CC=gcc

cd $NWCHEM_TOP/src 
#make clean
make nwchem_config
make 64_to_32  
make -j 4 >& make.log


```