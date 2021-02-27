FROM jupyter/pyspark-notebook:016833b15ceb

RUN pip install pyspark==3.0.1

RUN pip install ipynb==0.5.1

# install extension to monitor spark
RUN pip install sparkmonitor==1.1.1
RUN jupyter nbextension install sparkmonitor --py --user --symlink
RUN jupyter nbextension enable  sparkmonitor --py
RUN jupyter serverextension enable --py --user --debug sparkmonitor
RUN ipython profile create && \
echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

# AWS support
RUN cd /opt/conda/lib/python3.8/site-packages/pyspark/jars && wget --quiet "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.888/aws-java-sdk-bundle-1.11.888.jar"
RUN cd /opt/conda/lib/python3.8/site-packages/pyspark/jars && wget --quiet "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar"

USER root

CMD jupyter notebook --port=8888 --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/home/notebook/

