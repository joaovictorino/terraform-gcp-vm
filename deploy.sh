#!/bin/bash

# Login GCP
gcloud auth login

# Criar SSH Keys
ssh-keygen -t rsa -b 4096

# Acessar máquina usando SSH
ssh ubuntu@[IP Criado] -i id_rsa