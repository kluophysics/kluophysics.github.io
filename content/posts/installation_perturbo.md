---
title: "Installation of Perturbo on Rocky Linux with Intel oneAPI"
date: 2024-11-20T16:13:13+08:00
tags: ["perturbo", "Quantum Espresso", "debian"]
categories: ["blog"] 
draft: true
---

Following the instructions  on [Perturbo](https://perturbo-code.github.io/mydoc_installation.html).

## Installation of `hdf5`

wget https://support.hdfgroup.org/releases/hdf5/v1_14/v1_14_5/downloads/hdf5-1.14.5.tar.gz

tar xvf hdf5-1.14.5.tar.gz 

cd hdf5-1.14.5/

CC=mpicc CXX=mpiicx FC=mpiifx ./configure --prefix=/opt/hdf5 --enable-fortran

make -j 4

make install



```
ls /opt/hdf5/

bin  include  lib

```

## Install QE 7.2
```
git clone https://github.com/QEF/q-e.git
cd q-e
git checkout qe-7.2
```


<!-- ./configure --with-hdf5=/opt/hdf5 -->

Following [Intel Compilers with MPI:](https://github.com/perturbo-code/perturbo/tree/master/config)
```
./configure F90=ifx CC=mpiicx CFLAGS=-O3 FFLAGS=-O3 MPIF90=mpiifx --with-hdf5=/opt/hdf5
```

One thing I had trouble is that the latest 2025 version does not have `ifort` in, so I have to cheat it a bit by using early version 
using soft link


Inside `/opt/intel/oneapi/compiler/2025.0/bin`
I created a link with 
`ln -s /opt/oneapi/2022/compiler/2022.1.0/linux/bin/intel64/ifort .`
Then `ls` shows a link is created 
```
...
... ifort -> /opt/oneapi/2022/compiler/2022.1.0/linux/bin/intel64/ifort
...
```

