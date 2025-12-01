FROM jupyter/pyspark-notebook:latest

USER root

ENV PYSPARK_SUBMIT_ARGS="--packages io.delta:delta-spark_2.12:3.2.0,org.apache.hadoop:hadoop-aws:3.3.2,com.amazonaws:aws-java-sdk-bundle:1.12.628 pyspark-shell"

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Copiar requirements
COPY ../requirements.txt /tmp/
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org --upgrade -r /tmp/requirements.txt

# Criar diretórios
RUN mkdir -p /home/jovyan/data /home/jovyan/src

WORKDIR /home/jovyan