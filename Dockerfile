FROM ubuntu:18.04

WORKDIR /app

# git is only required to fetch sonoUno from the github repository
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      locales \
      libsdl2-mixer-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-2.0-0 \
      libsdl-ttf2.0-0 \
      libgtk-3-dev \
      libnotify-dev \
      octave \
      python3-setuptools \
      python3-pip \
      git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8

RUN python3 -m pip install -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-18.04 wxPython

RUN python3 -m pip install git+https://github.com/pchanial/sonoUno

ENTRYPOINT ["sonoUno"]

# docker build -t sonouno .
# HOSTDATADIR=/home/chanial/work/reinforce/data
# docker run --net=host --rm --env DISPLAY --volume="$XAUTHORITY:/root/.Xauthority:rw" --volume "$HOSTDATADIR":/app --device /dev/snd -t sonouno
