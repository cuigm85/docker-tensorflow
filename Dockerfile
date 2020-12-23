FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN su - && apt-get install -y wget vim git

# Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
  && bash ~/miniconda.sh -b -p $HOME/miniconda \
  && $HOME/miniconda/bin/conda create -n tensorflow-certificate python=3.8.0

# Installing packages
SHELL ["/root/miniconda/bin/conda", "run", "-n", "tensorflow-certificate", "/bin/bash", "-c"]
RUN pip install tensorflow==2.3.0
RUN pip install tensorflow-datasets==3.2.1
RUN pip install Pillow==7.2.0
RUN pip install jupyter

SHELL ["/bin/bash", "-c"]
RUN $HOME/miniconda/envs/tensorflow-certificate/bin/jupyter notebook --generate-config \
  && echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.password = 'sha1:81a9be8bd391:3d50a1274c2e501f12d0f706b02e460760e234f7'" >> ~/.jupyter/jupyter_notebook_config.py

RUN mkdir $HOME/notebooks

EXPOSE 8888
COPY ./entrypoint.sh ./entrypoint.sh
CMD ["/entrypoint.sh"]
