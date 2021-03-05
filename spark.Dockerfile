FROM itayb/spark:3.1.1-hadoop-3.2.0

#ENV PYTHON_VERSION=3.8.6

#RUN apt-get update && apt install -y \
#    software-properties-common \
#    gpg-agent \
#    build-essential \
#    zlib1g-dev \
#    libncurses5-dev \
#    libgdbm-dev \
#    libnss3-dev \
#    libssl-dev \
#    libreadline-dev \
#    libffi-dev \
#    libsqlite3-dev \
#    wget \
#    libbz2-dev \
#    python3-pip \
# && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
# && tar -xf Python-${PYTHON_VERSION}.tgz \
# && cd Python-${PYTHON_VERSION} && ./configure --enable-optimizations && make -j 8 && make altinstall \
# && rm -rf /var/lib/apt/lists/* \
# && rm -rf /var/cache/apt/*
#
#RUN ln -sf /usr/local/bin/python3.8 /usr/bin/python3 \
# && ln -s /usr/bin/python3 /usr/bin/python \
# && ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python3.8/site-packages/lsb_release.py
#
#RUN python3 -m pip install --upgrade pip && pip3 install pyspark==3.1.1

USER root

RUN apt-get update && apt install -y \
    wget \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/apt/*

RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.888/aws-java-sdk-bundle-1.11.888.jar"
RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar"
#
#RUN cd /usr/local/lib/python3.8/site-packages/pyspark/jars \
# && wget "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.888/aws-java-sdk-bundle-1.11.888.jar"
#RUN cd /usr/local/lib/python3.8/site-packages/pyspark/jars \
# && wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar"
#
#RUN ln -s /usr/local/lib/python3.8/site-packages/pyspark/jars/aws-java-sdk-bundle-1.11.888.jar \
#    /opt/spark/jars/aws-java-sdk-bundle-1.11.888.jar
#RUN ln -s /usr/local/lib/python3.8/site-packages/pyspark/jars/hadoop-aws-3.2.0.jar \
#    /opt/spark/jars/hadoop-aws-3.2.0.jar
