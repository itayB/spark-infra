# spark-infra  
  
This repository provides (a full) working local environment to run Spark via Jupiter notebook.   
Additional reqs:  
- Spark will run on k8s in cluster mode.  
- We will use S3 local  

## setup
- macOS Catalina, Version 10.15.3
- docker desktop, Version 2.2.0.3 (Kubernetes v1.15.5)
- minikube Version 1.7.3 (`brew install minikube` or follow the [installation guide](https://kubernetes.io/docs/tasks/tools/install-minikube/)).   

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
- [Running Spark on Kubernetes](https://tech.olx.com/running-spark-on-kubernetes-a-fully-functional-example-and-why-it-makes-sense-for-olx-d56b6a61fcbe)  
- [Jupyter notebook in docker](https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook/Dockerfile)
