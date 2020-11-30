# [***TensorFlow [GPU/CPU] with Jupyter.***](https://hub.docker.com/repository/docker/cuigm85/tensorflow)

## ***Docker Pull Command***
```
docker pull cuigm85/tensorflow:gpu
```

## ***Docker Run Command***
```
docker run -d -p 8888:8888 --name tensorflow-gpu --hostname tensorflow-gpu --gpus all cuigm85/tensorflow:gpu
```

## ***Change Password (default password is "tensorflow")***

### ***Open a jupyter notebook and create a password hash.***
```
from IPython.lib import passwd
passwd()
```
`'sha1:9e053bbd966c:35e7db37a3fa6b1aebeadc70959c7a670f9f3a5f'`

### ***Open a jupyter notebook and create a password hash.***
```
!sed -i '$d' /root/.jupyter/jupyter_notebook_config.py
!echo "c.NotebookApp.password = 'sha1:9e053bbd966c:35e7db37a3fa6b1aebeadc70959c7a670f9f3a5f'" >> /root/.jupyter/jupyter_notebook_config.py
```

### ***Restart the container.***
```
docker restart tensorflow-gpu
```
