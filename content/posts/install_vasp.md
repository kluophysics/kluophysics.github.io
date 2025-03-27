
# without using ELPA 
cmake ..   -D CMAKE_CXX_COMPILER=icpx -D MPI_CXX_COMPILER=mpiicpc  -DCMAKE_INSTALL_PREFIX=/opt/abacus/3.5.4  -D USE_ELPA=OFF  -D Libxc_DIR=/opt/libxc/6.2.2/