FROM tensorflow/tensorflow:2.4.1-gpu


# for opencv
RUN apt-get -y install build-essential \
    pkg-config \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libopenexr-dev \
    libavcodec-dev \
    libavformat-dev \
    yasm \
    libfaac-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    libx264-dev \
    libswscale-dev \
    libjasper-dev \
    libdc1394-22-dev \
    libv4l-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base0.10-dev \
    libgstreamer-plugins-base1.0-dev \
    libtbb2 \
    libtbb-dev \
    libeigen3-dev

RUN pip install --upgrade \
    scipy \
    jupyterlab \
    pandas \
    scikit-image \
    opencv-python \
    scikit-learn  \
    keras \
    pydot \
    joblib \
    matplotlib \
    seaborn \

RUN apt-get -y install vim \
    tmux \
    libsm6 \
    libxext6 \
    libxrender-dev \
    graphviz

EXPOSE 8888
EXPOSE 6006
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
