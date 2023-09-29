FROM apache/spark:latest

# Установите Python 3.11 как root
USER root

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-distutils && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Установите pip для Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.11

# Установите PySpark
RUN pip3.11 install pyspark==3.2.0  # убедитесь, что версия PySpark соответствует вашей версии Spark

CMD ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]

