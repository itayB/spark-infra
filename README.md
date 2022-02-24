# spark-infra  
  
This repository provides a full local environment to run Spark via Jupiter notebook.  
### prerequisites / setup
- macOS Catalina, Version 10.15.3
- docker desktop, Version 2.2.0.3 (Kubernetes v1.15.5)
- minikube Version 1.7.3 (`brew install minikube` or follow the [installation guide](https://kubernetes.io/docs/tasks/tools/install-minikube/)).   

 ## Run with docker-compose and spark in stand-alone mode
First, build spark 2.4.5 image:
 `docker build -t spark:2.4.5-worker .`
 
Run docker-compose:
 `docker-compose up`
 
Open Jupiter notebook in your browser: http://localhost:8888 and create a new Python3 notebook with the following:
```
import os

# make sure pyspark tells workers to use python3 not 2 if both are installed
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3'

import pyspark
conf = pyspark.SparkConf()
conf.set("spark.driver.memory", "1G")
conf.setMaster("spark://spark-master:7077")
# point to spark binary package in HDFS or on local filesystem on all slave
# nodes (e.g., file:///usr/local/spark/spark-2.4.5-bin-hadoop2.7.tgz)
conf.set("spark.executor.uri", "file:///usr/local/spark/spark-2.4.5-bin-hadoop2.7.tgz")
# set other options as desired
conf.set("spark.executor.memory", "1g")
conf.set("spark.core.connection.ack.wait.timeout", "1200")

# create the context
sc = pyspark.SparkContext.getOrCreate(conf=conf)

# do something to prove it works
rdd = sc.parallelize(range(100000))
x=rdd.sumApprox(3)
print(x)
sc.stop()
```
Here is another example that accessing S3 for counting parquet files:
```
import pyspark

spark = pyspark.sql.SparkSession.builder \
        .master("spark://spark-master:7077") \
        .config("spark.driver.memory", '1G') \
        .config("spark.executor.memory", "1G") \
        .config("spark.hadoop.fs.s3a.access.key", '<change_me>') \
        .config("spark.hadoop.fs.s3a.secret.key", '<change_me>') \
        .getOrCreate()

df = spark.read.parquet("s3a://my_bucket/folder1/date=2020-03-03/client=1000")
df.printSchema()
print(df.count())
spark.stop()

```




Additional reqs:  
- Spark will run on k8s in cluster mode.  
- We will use S3 local  




## Installation  
```  
~ $ minikube start --cpus=4 --memory=4000mb 
😄  minikube v1.7.3 on Darwin 10.15.3
✨  Automatically selected the hyperkit driver. Other choices: virtualbox, docker (experimental)
💾  Downloading driver docker-machine-driver-hyperkit:
    > docker-machine-driver-hyperkit.sha256: 65 B / 65 B [---] 100.00% ? p/s 0s
    > docker-machine-driver-hyperkit: 10.88 MiB / 10.88 MiB  100.00% 1.88 MiB p
🔑  The 'hyperkit' driver requires elevated permissions. The following commands will be executed:  

# create registry-values.yaml with the following content:
service:
  type: NodePort
  nodePort: 30000

~ $ helm init & helm upgrade --install --wait registry -f registry-values.yaml stable/docker-registry

~ $ k get pods                                                                                                                                                                                                                                              14:57:47
NAME                                       READY   STATUS    RESTARTS   AGE
registry-docker-registry-68cf4d8d8-m2bls   1/1     Running   0          27s
```

References:  
- [Jupyter Notebook & Spark on Kubernetes](https://towardsdatascience.com/jupyter-notebook-spark-on-kubernetes-880af7e06351)
- [Running Spark on Kubernetes](https://tech.olx.com/running-spark-on-kubernetes-a-fully-functional-example-and-why-it-makes-sense-for-olx-d56b6a61fcbe)  
- [Jupyter notebook in docker](https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook/Dockerfile)
