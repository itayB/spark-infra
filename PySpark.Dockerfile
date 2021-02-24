FROM 884661243007.dkr.ecr.us-east-1.amazonaws.com/spark:3.0.1-aws

RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-get install -y python3 python3-pip
RUN pip3 install pyspark==3.0.1
