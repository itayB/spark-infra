FROM itayb/spark:3.1.1-hadoop-3.2.0-aws

RUN pip install \
    notebook==6.2.0 \
    ipynb==0.5.1 \
    sparkmonitor==1.1.1 \
    pyspark==3.1.1

# install extension to monitor spark
RUN jupyter nbextension install sparkmonitor --py --user --symlink
RUN jupyter nbextension enable  sparkmonitor --py
RUN jupyter serverextension enable --py --user --debug sparkmonitor
RUN ipython profile create && \
echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

RUN ln -s /usr/local/lib/python3.8/site-packages/sparkmonitor/listener_2.12.jar /opt/spark/jars/listener_2.12.jar

USER root

CMD jupyter notebook --port=8888 --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --notebook-dir=/home/notebook/

RUN echo $'\n\
spec:\n\
  containers:\n\
  - name: executor\n\
  image: "itayb/spark:3.1.1-hadoop-3.2.0-python-3.8.6-aws"\n\
  resources:\n\
    limits:\n\
      cpu: 1000m\n\
      memory: 2048Mi\n\
    requests:\n\
      cpu: 1000m\n\
      memory: 1024Mi\n\
' > /podTemplate.yml
