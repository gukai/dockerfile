FROM simpleware/console-caffe-base:latest 

# compile caffe
RUN cd $CAFFE ; cp $CAFFE/Makefile.config.example $CAFFE/Makefile.config \
        && sed -i -e 's/INCLUDE_DIRS.*/INCLUDE_DIRS := $(PYTHON_INCLUDE) \/usr\/local\/include \/usr\/include\/hdf5\/serial/' \
                -e 's/LIBRARY_DIRS.*/LIBRARY_DIRS := $(PYTHON_LIB) \/usr\/local\/lib \/usr\/lib \/usr\/lib\/x86_64-linux-gnu\/hdf5\/serial/' \
                Makefile.config

RUN cd $CAFFE && make pycaffe && make all && make test && make runtest

