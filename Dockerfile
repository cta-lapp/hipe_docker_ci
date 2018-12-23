FROM ctalapp/centos7_gcc_730

MAINTAINER Jean J.  <jacquem@lapp.in2p3.fr>

ENV LANG=en_US.UTF-8

#RUN yum install -y yum-plugin-ovl
#RUN yum clean all

#RUN yum -y update
   
RUN source activate hipetest && \
    conda  install -y -c cta-observatory ctapipe

RUN source activate hipetest && \
    cd /usr/local && \
    git clone https://gitlab.in2p3.fr/CTA-LAPP/HiPeCTA.git && \
    cd HiPeCTA && \
    python setup.py install

RUN source activate hipetest && \
    cd /usr/local && \
    git clone https://gitlab.in2p3.fr/CTA-LAPP/HiPeData.git && \
    export CC=/usr/local/bin/gcc ; export CXX=/usr/local/bin/g++ && \
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib64:/usr/local/lib:/opt/conda/envs/hipetest/lib && \
    export PYTHON_INCLUDE_DIR=/opt/conda/envs/hipetest/include/python3.6m && \
    export PYTHON_LIBRARY=/opt/conda/envs/hipetest/lib/lib/python3.6m.dylib && \
    export PYTHON_EXECUTABLE=/opt/conda/envs/hipetest/bin/python && \
    cd /usr/local/HiPeData ; ./install.sh

