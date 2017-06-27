FROM ubuntu:14.04

# last update: 20170627
#  -- change previous line to trigger rebuild of docker image on jenkins; eg. when docker-entrypoint.sh changes

# add jenkins user -- this is required for git to work
# note: jenkins has uid 1001 & gid 1002 on our build hosts, this needs to be reflected in here!

ENV UID 1001

RUN groupadd -g 1002 jenkins && \
    useradd jenkins -s /bin/bash -g jenkins -m -u ${UID} -g 1002 -d /home/jenkins && \
    echo "jenkins ALL=NOPASSWD: ALL" >/etc/sudoers.d/jenkins

# add required packages

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y \
                    build-essential \
		    bison \
		    dctrl-tools \
		    debhelper \
		    dh-python \
		    docbook-to-man \
		    doxygen \
		    dpkg-dev \
		    elfutils \
		    flex \
    	    	    g++-4.9 \
    	    	    gcc-4.9 \
		    git-buildpackage \
		    help2man \
		    libbz2-dev \
		    libc6-dbg \
		    libicu-dev \
		    libstdc++-4.9-dev \
		    mpi-default-dev \
                    pkg-create-dbgsym \
		    python \
		    python3 \
		    python-all-dev \
		    python3-all-dev \
                    supervisor \
		    wget \
		    xsltproc \
		    zlib1g-dev && \
    apt-get -y autoremove --purge && apt-get clean && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 99 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 99

RUN echo 'BatchMode yes' >>/etc/ssh/ssh_config && \
    echo 'StrictHostKeyChecking no' >>/etc/ssh/ssh_config

RUN usermod -a -G sudo jenkins && \
    usermod -a -G adm  jenkins

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD docker-entrypoint.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["/sbin/docker-entrypoint.sh"]

CMD [ "/usr/bin/supervisord" ]
