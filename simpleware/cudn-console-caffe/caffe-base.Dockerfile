FROM simpleware/nvidia_cuda_8.0-cudnn6-devel_console
ENV DATA /data
ENV CAFFE /data/caffe

# install base OS env
RUN apt-get update \
	&& apt-get install -y git python-pip \
	&& pip install --upgrade pip

# install dependent packages
RUN apt-get install -y libprotobuf-dev libleveldb-dev \
	libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler \
	&& apt-get install -y --no-install-recommends libboost-all-dev \
	&& apt-get install -y libatlas-base-dev python-dev python-numpy  \
		libgflags-dev libgoogle-glog-dev liblmdb-dev

# install caffe and its dependent
RUN mkdir -p $DATA; cd $DATA \
	&& git clone https://github.com/BVLC/caffe.git \
	&& cd $CAFFE && git checkout 1.0 \
	&& pip install -r $CAFFE/python/requirements.txt


