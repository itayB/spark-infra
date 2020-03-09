ARG JAVA_IMAGE_TAG=8-jre-slim
FROM openjdk:${JAVA_IMAGE_TAG}

RUN apt update
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev\
    libffi-dev wget curl awscli

ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7

WORKDIR /usr/local/spark

RUN curl -O http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/* .

WORKDIR /usr/local/spark/jars
RUN curl -O https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar
RUN curl -O https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.0/hadoop-aws-2.7.0.jar

# preventing issue https://issues.apache.org/jira/browse/SPARK-28921 from happening
RUN rm -f kubernetes*.jar

RUN curl -O https://repo1.maven.org/maven2/io/fabric8/kubernetes-model/4.4.2/kubernetes-model-4.4.2.jar
RUN curl -O https://repo1.maven.org/maven2/io/fabric8/kubernetes-model-common/4.4.2/kubernetes-model-common-4.4.2.jar
RUN curl -O https://repo1.maven.org/maven2/io/fabric8/kubernetes-client/4.4.2/kubernetes-client-4.4.2.jar

WORKDIR /home/spark/sparkjobs
COPY log4j.properties /usr/local/spark/conf/log4j.properties
COPY . /home/spark/sparkjobs/
CMD ["/bin/bash", "./entrypoint.sh"]
