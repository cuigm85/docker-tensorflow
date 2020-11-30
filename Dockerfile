FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN su - && apt-get install -y wget vim git

# Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
  && bash ~/miniconda.sh -b -p $HOME/miniconda \
  && $HOME/miniconda/bin/conda init

# Installing packages
SHELL ["/root/miniconda/bin/conda", "run", "-n", "base", "/bin/bash", "-c"]
RUN conda install -y tensorflow matplotlib pandas jupyter

SHELL ["/bin/bash", "-c"]
RUN $HOME/miniconda/bin/jupyter notebook --generate-config \
  && echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.password = 'sha1:81a9be8bd391:3d50a1274c2e501f12d0f706b02e460760e234f7'" >> ~/.jupyter/jupyter_notebook_config.py

RUN mkdir $HOME/notebooks

EXPOSE 8888
COPY ./entrypoint.sh ./entrypoint.sh
CMD ["/entrypoint.sh"]
