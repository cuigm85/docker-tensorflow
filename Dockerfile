FROM tensorflow/tensorflow:2.3.2-gpu-jupyter

#ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y wget

RUN pip install --upgrade pip
RUN pip install Scipy
RUN pip install tensorflow-datasets==3.2.1
RUN pip install Pillow==7.2.0
