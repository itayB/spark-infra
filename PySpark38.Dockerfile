FROM itayb/spark:3.0.1-hadoop-3.2.0-aws

RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-get install -y gpg-agent
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
RUN tar -xf Python-3.8.6.tgz
RUN cd Python-3.8.6 && ./configure --enable-optimizations && make -j 8 && make altinstall
RUN ln -sf /usr/local/bin/python3.8 /usr/bin/python3
RUN apt-get install -y python3-pip
RUN ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python3.8/site-packages/lsb_release.py
RUN pip3 install pyspark==3.0.1
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir -p /opt/conda/lib/python3.8/site-packages/pyspark/jars
RUN cd /opt/conda/lib/python3.8/site-packages/pyspark/jars && wget --quiet "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.888/aws-java-sdk-bundle-1.11.888.jar"
RUN cd /opt/conda/lib/python3.8/site-packages/pyspark/jars && wget --quiet "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar"
