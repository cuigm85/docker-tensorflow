#!/bin/bash

export PATH=$HOME/miniconda/bin:$PATH

conda run -n base \
    && cd $HOME/notebooks \
    && jupyter notebook --allow-root
