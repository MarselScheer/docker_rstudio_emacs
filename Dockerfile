FROM rocker/verse:4.1.1

RUN apt-get update && apt-get install -y \
    ranger \
    git \
    tig \
    htop \
# graphviz necessary for dot-programm for instance used
# by plantuml
    graphviz \
# xdg-utils and ff necessary to display 
# drake-network-graphs from doom-emacs
    xdg-utils \
    firefox \
    # emacs-libs
    wget libsm-dev libjansson4 libncurses5 libgccjit0 \
    librsvg2-2 libjpeg9 libtiff5 libgif7 libpng16-16 \
    libgtk-3-0 libharfbuzz0b libxpm4 \
    && wget https://github.com/emacs-ng/emacs-ng/releases/download/v0.0.e88654b/emacs-ng_0.0.e88654b_amd64.deb \
    && dpkg -i emacs-ng_0.0.e88654b_amd64.deb \
    && ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

USER rstudio
WORKDIR /home/rstudio
RUN mkdir -p /tmp/hostfs \
    && ln -s /tmp/hostfs \
    && ln -s /tmp/hostfs/.emacs.d \
    && ln -s /tmp/hostfs/.gitconfig \
    && ln -s /tmp/hostfs/.ssh \
    && echo "export DISPLAY=:0" > /home/rstudio/.bashrc \
    && echo RENV_PATHS_ROOT=~/hostfs/renv/ > /home/rstudio/.Renviron

# last command MUST be USER root?!?
# otherwise container will directly stop
USER root
