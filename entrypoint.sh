#!/bin/bash

export PATH=$HOME/miniconda/condabin:$HOME/miniconda/envs/tensorflow-certificate/bin:$PATH

conda run -n tensorflow-certificate \
    && cd $HOME/notebooks \
    && jupyter notebook --allow-root
