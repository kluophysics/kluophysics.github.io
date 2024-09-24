---
title: "Installation of NWCHEM on Debian"
date: 2024-09-20T17:53:13+08:00
tags: ["nwchem", "debian"]
categories: ["blog"] 
draft: false
---

## Installation using `gcc` and `gfortan`

Below is a brief diary for my attempted installation of NWCHEM on my Debian desktop.

The latest version of NWCHEM can be found on Github at [https://github.com/nwchemgit/nwchem](https://github.com/nwchemgit/nwchem)

As the first, use git to pull down the latest repo,

```
git clone https://github.com/nwchemgit/nwchem.git
```

Here I chose version 7.2.2 so I switched to it using 
```
git checkout v7.2.2-release
```

Then install needed libraries for NWCHEM or install them manually. In this case, I chose the former to facilitate the process.

I placed these settings into a file called `comple_setting`, as detailed below.

```
export NWCHEM_TOP=$PWD

export NWCHEM_TARGET=LINUX64

export USE_MPI=y

export NWCHEM_MODULES="all python"

#MRCC_METHODS can be set to request the multireference coupled cluster capability to be included in the code, e.g.
export MRCC_METHODS=y #TRUE 

#CCSDTQ can be set to request the CCSDTQ method and its derivatives to be included in the code, e.g.
export CCSDTQ=TRUE

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

Note the direct library flag usage such as `-lscalapack-openmpi` and `-lopenblas` assume that these libraries could be found 
in the default `LD_LIBRARY_PATH`. Otherwise, add some additional path to it:

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:your-own-path-should-be-replaced
```

For example, I can find my lapack library using `find`

```
find /usr/ -name "*lapack*
```
and it shows the relevant paths

```
/usr/lib/x86_64-linux-gnu/lapack/liblapack.a
/usr/lib/x86_64-linux-gnu/lapack/liblapack.so
/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.11.0
/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3
/usr/lib/x86_64-linux-gnu/liblapack.a
/usr/lib/x86_64-linux-gnu/liblapack_pic.a
/usr/lib/x86_64-linux-gnu/liblapack.so
/usr/lib/x86_64-linux-gnu/liblapack.so.3
/usr/lib/x86_64-linux-gnu/openblas-openmp/liblapack.a
/usr/lib/x86_64-linux-gnu/openblas-openmp/liblapack.so
/usr/lib/x86_64-linux-gnu/openblas-openmp/liblapack.so.3
...
```

So next, I simply issue the command 
```
bash compile_setting
```
and wait for some big time (get a cup of coffee?). That should generate executable `nwchem` within directory
`$NWCHEM_TOP/bin/LINUX64`. To use it directly from the terminal, I append it to the variable `$PATH` in the `~/.bashrc` file,

```
export PATH="$NWCHEM_TOP/bin/LINUX64/":$PATH
```
where `$NWCHEM_TOP` is your acutal path. 

Source the bashrc file
```
source ~/.bashrc
```

## Test run 

### DFT calculation using `scanl` xc functional

Prepare an input file `dft_scanl.nw`
```
echo
title "Test SCAN-L"

start scanl

geometry
  H     -0.53613834     1.65036000     0.76488131
  N     -0.20560016     1.19352105    -0.09517494
  C      0.50994699     0.02103750     0.20703847
  H      1.50546027    -0.04117360    -0.23494242
  F     -0.24147792    -1.09742630    -0.06675439
end

basis cartesian
  C library 6-31g*
  N library 6-31g*
  F library 6-31g*
  H library 6-31g
end

dft
 xc scanl
 grid xfine
end
task dft energy
```

Run it with the following command
```
nwchem dft_scanl.nw > dft_scanl.out
```

The output file is appended here [dft_scanl.out](../data/dft_scanl.out).


### MP2 optimization and then CCSD(T) single point

Input file `input.nw`:

```
start n2   

geometry  
  symmetry d2h  
  n 0 0 0.542  
end  

basis spherical  
  n library cc-pvtz  
end  

mp2  
  freeze core  
end  

task mp2 optimize  

ccsd  
  freeze core  
end  

task ccsd(t)

```

Now I use 4 cpus `mpirun` to shorten my calculation,
```
mpirun -n 4 ~/Documents/repos/nwchem/bin/LINUX64/nwchem input.nw > mp2_opt.out
```
The output file is appended here [mp2_opt.out](../data/mp2_opt.out).

