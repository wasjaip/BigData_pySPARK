#!/bin/bash

# We mount it to docker containers
# So they will see the content in that directory
PATH_TO_PROJECT_DIR="/mnt/c/pySPARK"

MEMORY_PER_WORKER='2g'
CORES_PER_WORKER=1

# Creates local docker network and names it as "spark_network"
docker network create spark_network

# Runs Spark Master Node
docker run -d -p 8080:8080 -p 7077:7077 --name spark_master --network spark_network \
-v $PATH_TO_PROJECT_DIR:/work:rw \
my_spark_image:latest /opt/spark/bin/spark-class org.apache.spark.deploy.master.Master \
-h spark_master

# Save IP address of our Spark Master node 
# to attach workers to it
SPARK_MASTER_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' spark_master`

# Run Spark workers and bind them to our Spark Master node
for i in {1..4}
do
    docker run -d --name spark_worker$i --network spark_network \
    -e SPARK_WORKER_MEMORY=$MEMORY_PER_WORKER \
    -e SPARK_WORKER_CORES=$CORES_PER_WORKER \
    -e PYSPARK_PYTHON=/usr/bin/python3.11 \
    -e PYSPARK_DRIVER_PYTHON=/usr/bin/python3.11 \
    -v $PATH_TO_PROJECT_DIR:/work:rw \
    my_spark_image:latest /opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker \
    spark://$SPARK_MASTER_IP:7077 
done

docker run -d --name jupyter_lab -p 10000:8888 --network spark_network --user root \
-v $PATH_TO_PROJECT_DIR:/work:rw \
-e PYSPARK_PYTHON=/usr/bin/python3.11 \
-e PYSPARK_DRIVER_PYTHON=/usr/bin/python3.11 \
-e SPARK_MASTER=spark://$SPARK_MASTER_IP:7077 \
jupyter/pyspark-notebook start-notebook.sh --NotebookApp.token='' --NotebookApp.notebook_dir='/work'

echo 'YOUR SPARK MASTER NODE IP IS:' $SPARK_MASTER_IP
echo 'YOU CAN ACCESS JUPYTER LAB VIA: http://localhost:10000'
