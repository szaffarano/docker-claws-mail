FROM ubuntu:17.04

##############################################
# configuration
##############################################
ENV CLAWS_VERSION         3.15.0
ENV CLAWS_THEMES_VERSION  20140629
ENV CLAWSKER_VERSION      1.1.0

ENV USERNAME              user
ENV UID                   1000
ENV GID                   1000
##############################################
# end configuration, dont touch below
##############################################

ENV CLAWS_REPO            http://git.claws-mail.org/readonly/claws.git
ENV CLAWS_THEMES_REPO     http://git.claws-mail.org/readonly/themes.git
ENV CLAWSKER_REPO         http://git.claws-mail.org/readonly/clawsker.git

RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    build-essential \
    pkg-config \
    libpoppler-dev \
    libetpan-dev \
    libgtk2.0-dev \
    libglib2.0-dev \
    libcanberra-dev \
    libcanberra-gtk-dev \
    libcompfaceg1-dev \
    bogofilter \
    bsfilter \
    libwebkitgtk-dev \
    libclamav-dev \
    libical-dev \
    libytnef-dev \
    libgpgme11-dev \
    libnotify-dev \
    libenchant-dev \
    libgdata-dev \
    libpoppler-glib-dev \
    libarchive-dev \
    libperl-dev \
    python-dev \
    libldap-dev \
    python-gtk2-dev \
    librsvg2-dev \
    network-manager-dev \
    libdbus-glib-1-dev \
    git \
    bison \
    flex \
    automake \
    libtool \
    m4 \
    automake \
    gettext \
    curl && \
  rm -rf /var/lib/apt/lists/*

RUN \
  git clone --branch ${CLAWS_VERSION} ${CLAWS_REPO} claws && \
    cd claws && ./autogen.sh  && make -j $(nproc --all) && make install && \
    cd .. && rm -rf claws

RUN git clone --branch ${CLAWS_THEMES_VERSION} ${CLAWS_THEMES_REPO} clawsthemes && \
    cd clawsthemes && ./autogen.sh  && make -j $(nproc --all) && make install && \
    cd .. && rm -rf clawsthemes

RUN git clone --branch ${CLAWSKER_VERSION} ${CLAWSKER_REPO} clawswer && \
    cd clawswer && make install && \
    cd .. && rm -rf clawswer

RUN \
  apt-get update && \
  apt-get install -y \
    pinentry-gtk2 \
    aspell-es \
    greybird-gtk-theme && \
  rm -rf /var/lib/apt/lists/*

RUN \
  groupadd --gid ${GID} ${USERNAME} && \
  useradd --uid ${UID} --gid ${GID} --create-home ${USERNAME}

USER      ${USERNAME}
WORKDIR   /home/${USERNAME}
VOLUME    /home/${USERNAME}

CMD ["/usr/local/bin/claws-mail"]
